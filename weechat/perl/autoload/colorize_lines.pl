#use Data::Dumper
#$Data::Dumper::Useqq=1;

use strict;
my $PRGNAME     = "colorize_lines";
my $VERSION     = "3.3";
my $AUTHOR      = "Nils Görs <weechatter\@arcor.de>";
my $LICENCE     = "GPL3";
my $DESCR       = "colors text in chat area with according nick color, including highlights";

my %config = ("buffers"             => "all",       # all, channel, query
              "blacklist_buffers"   => "",          # "a,b,c"
              "lines"               => "on",
              "highlight"           => "on",        # on, off, nicks
              "nicks"               => "",          # "d,e,f", "/file"
              "own_lines"           => "on",        # on, off, only
);

my %help_desc = ("buffers"             => "buffer type affected by the script (all/channel/query, default: all)",
                 "blacklist_buffers"   => "comma-separated list of channels to be ignored (e.g. freenode.#weechat,*.#python)",
                 "lines"               => "apply nickname color to the lines (off/on/nicks). the latter will limit highlighting to nicknames in option 'nicks'",
                 "highlight"           => "apply highlight color to the highlighted lines (off/on/nicks). the latter will limit highlighting to nicknames in option 'nicks'",
                 "nicks"               => "comma-separater list of nicks (e.g. freenode.cat,*.dog) OR file name starting with '/' (e.g. /file.txt). in the latter case, nicknames will get loaded from that file inside weechat folder (e.g. from ~/.weechat/file.txt). nicknames in file are newline-separated (e.g. freenode.dog\\n*.cat)",
                 "own_lines"           => "apply nickname color to own lines (off/on/only). the latter turns off all other kinds of coloring altogether",
);

#################################################################################################### config

# program starts here
sub colorize_cb
{
    my ( $data, $modifier, $modifier_data, $string ) = @_;

    # quit if it's not a privmsg or ctcp
    # or we are not supposed to
    if ((index($modifier_data,"irc_privmsg") == -1) ||
        (index($modifier_data,"irc_ctcp") >= 0)) {
        return $string;
    }

    # find buffer pointer
    $modifier_data =~ m/([^;]*);([^;]*);/;
    my $buf_ptr = weechat::buffer_search($1, $2);
    return $string if ($buf_ptr eq "");

    # find buffer name, server name
    # return if buffer is in a blacklist
    my $buffername = weechat::buffer_get_string($buf_ptr, "name");
    return $string if weechat::string_has_highlight($buffername, $config{blacklist_buffers});
    my $servername = weechat::buffer_get_string($buf_ptr, "localvar_server");

    # find stuff between \t
    $string =~ m/^([^\t]*)\t(.*)/;
    my $left = $1;
    my $right = $2;

    # find nick of the sender
    # find out if we are doing an action
    my $nick = ($modifier_data =~ m/(^|,)nick_([^,]*)/) ? $2 : weechat::string_remove_color($left, "");
    my $action = ($modifier_data =~ m/\birc_action\b/) ? 1 : 0;

    ######################################## get color

    my $color = "";
    my $my_nick = weechat::buffer_get_string($buf_ptr, "localvar_nick");
    my $channel_color = weechat::color( get_localvar_colorize_lines($buf_ptr) );

    if ($my_nick eq $nick)
    {
        # it's our own line
        # process only if own_lines is "on" or "only" (i.e. not "off")
        return $string if ($config{own_lines} eq "off") && not ($channel_color);

        $color = weechat::color("chat_nick_self");
        $color = $channel_color if ($channel_color) && ($config{own_lines} eq "off");

    } else {
        # it's someone else's line
        # don't process is own_lines are "only"
        # in order to get correct matching, remove colors from the string
        return $string if ($config{own_lines} eq "only");
        my $right_nocolor = weechat::string_remove_color($right, "");
        if ((
            # if configuration wants us to highlight
            $config{highlight} eq "on" ||
            ($config{highlight} eq "nicks" && weechat::string_has_highlight("$servername.$nick", $config{nicks}))
           ) && (
            # ..and if we have anything to highlight
            weechat::string_has_highlight($right_nocolor, weechat::buffer_string_replace_local_var($buf_ptr, weechat::buffer_get_string($buf_ptr, "highlight_words"))) ||
            weechat::string_has_highlight($right_nocolor, weechat::config_string(weechat::config_get("weechat.look.highlight"))) ||
            weechat::string_has_highlight_regex($right_nocolor, weechat::config_string(weechat::config_get("weechat.look.highlight_regex"))) ||
            weechat::string_has_highlight_regex($right_nocolor, weechat::buffer_get_string($buf_ptr, "highlight_regex"))
           )) {
            # that's definitely a highlight! get a hilight color
            # and replace the first occurance of coloring, that'd be nick color
            $color = weechat::color('chat_highlight');
            $right =~ s/\31[^\31 ]+?\Q$nick/$color$nick/ if ($action);
        } elsif (
            # now that's not a highlight OR highlight is off OR current nick is not in the list
            # let's see if configuration wants us to highlight lines
            $config{lines} eq "on" ||
            ($config{lines} eq "nicks" && weechat::string_has_highlight("$servername.$nick", $config{nicks}))
           ) {
            $color = weechat::info_get('irc_nick_color', $nick);
            $color = $channel_color if ($channel_color); 
        } else {
            # oh well
            return $string;
        }
    }

    ######################################## inject colors and go!

    my $out = "";
    if ($action) {
        # remove the first color reset - after * nick
        # make other resets reset to our color
        $right =~ s/\34//;
        $right =~ s/\34/\34$color/g;
        $out = $left . "\t" . $right . "\34"
    } else {
        # make other resets reset to our color
        $right =~ s/\34/\34$color/g;
        $out = $left . "\t" . $color . $right . "\34"
    }
    #weechat::print("", ""); weechat::print("", "\$str " . Dumper($string)); weechat::print("", "\$out " . Dumper($out));
    return $out;
}


sub get_localvar_colorize_lines
{
    my ( $buf_ptr ) = @_;

    return weechat::buffer_get_string($buf_ptr, "localvar_colorize_lines");
}
#################################################################################################### config

# read nicknames if $conf{nisks} starts with /
# after this, $conf{nisks} is of form a,b,c,d
# if it doesnt start with /, assume it's already a,b,c,d
sub nicklist_read
{
    return if (substr($config{nicks}, 0, 1) ne "/");
    my $file = weechat::info_get("weechat_dir", "") . $config{nicks};
    return unless -e $file;
    my $nili = "";
    open (WL, "<", $file) || DEBUG("$file: $!");
    while (<WL>)
    {
        chomp;                                                         # kill LF
        $nili .= $_ . ",";
    }
    close WL;
    chop $nili;                                                        # remove last ","
    $config{nicks} = $nili;
}

# called when a config option ha been changed
# $name = plugins.var.perl.$prgname.nicks etc
sub toggle_config_by_set
{
    my ($pointer, $name, $value) = @_;
    $name = substr($name,length("plugins.var.perl.$PRGNAME."),length($name));
    $config{$name} = lc($value);
    nicklist_read() if ($name eq "nicks");
}

# read configuration from weechat OR
#   set default options and
#   set dectription if weechat >= 0.3.5
# after done, read nicklist from file if needed
sub init_config
{
    my $weechat_version = weechat::info_get('version_number', '') || 0;
    foreach my $option (keys %config){
        if (!weechat::config_is_set_plugin($option)) {
            weechat::config_set_plugin($option, $config{$option});
            weechat::config_set_desc_plugin($option, $help_desc{$option}) if ($weechat_version >= 0x00030500); # v0.3.5
        } else {
            $config{$option} = lc(weechat::config_get_plugin($option));
        }
    }
    nicklist_read();
}

#################################################################################################### start

weechat::register($PRGNAME, "Nils Görs <weechatter\@arcor.de>", $VERSION, $LICENCE, $DESCR, "", "") || return;

weechat::hook_modifier("500|weechat_print","colorize_cb", "");
init_config();
weechat::hook_config("plugins.var.perl.$PRGNAME.*", "toggle_config_by_set", "");
