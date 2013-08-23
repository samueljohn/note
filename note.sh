#----- On OS X 10.8 use terminal-notifier more easily
function note {
    if [[ $1 == "--help" ]]
    then
        echo 'note 1.1 -- convenience interface for terminal-notifier on Mac 10.8+.'
        echo ''
        echo 'Usage: note <something>'
        echo 'Usage: note <title> [<message>] [OPTIONS]'
        echo '   where <title> and <message> should be "quoted".'
        echo ''
        echo '   OPTIONS:'
        echo '       -subtitle VALUE    The notification subtitle.'
        echo '       -open URL          The URL of a resource to open on click'
        echo '       -activate ID       Bundle identifier of the app to activate on click.'
        echo '       -execute COMMAND   A shell command to perform on click.'
        echo '       --help             This message.'
        echo ''
        echo 'To install the terminal-notifier:'
        echo '   `brew install terminal-notifier`'
        echo ''
        echo '   Examples:'
        echo '       note "Make new coffee"'
        echo '       note todo "visit awesome page" -open http://www.samueljohn.de'
        echo '       note "write down some things" -activate com.apple.TextEdit'
        echo ''
        echo 'Author: Samuel John <www.samueljohn.de>'
        return
    fi

    if ! type "terminal-notifier" > /dev/null; then
        echo 'The `note` functions needs the terminal-notifier`'
        echo '   `brew install terminal-notifier`'
    else
        local ML_TERM_NOTE_NR msg
        ML_TERM_NOTE_NR=`terminal-notifier -list ALL | head -n 2 | tail -n 1 | sed -e 's|^\([0-9]*\).*|\1|' 2>/dev/null`
        (( ML_TERM_NOTE_NR+=1 ))  # works even if var is not set.
        msg=$2
        if [[ ${#msg} == 0 || ${msg[1]} == "-" ]]
        then
            # No message given
            terminal-notifier -title $1 -group $ML_TERM_NOTE_NR -message ' ' $2 $3 $4 $5
        else
            terminal-notifier -title $1 -group $ML_TERM_NOTE_NR -message $2 $3 $4 $5
        fi
    fi
}
compdef _gnu_generic note
