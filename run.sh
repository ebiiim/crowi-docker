#!/bin/sh

VERSION=$(git describe --tags --match "v*")
VERSION=${VERSION:-"dev"}
SKIP_CONFIRM=false

usage() {
    cat <<EOF
Usage: $0 [option]... <command>

Commands:
    serve           do npm start
    load-assets     download assets from env \$ICON_*

Options:
    --yes, -y       skip confirmations
    --debug, -d     print all executed commands (set -x)
    --help, -h      print this message
    --version, -v   print version
EOF
}


prompt_continue_or_exit1() {
    if test "$SKIP_CONFIRM" = true
    then
        return
    fi
    read -r -p "Continue? [y/n]: "
    if test "$REPLY" != y -a "$REPLY" != Y
    then
        exit 1
    fi
}

check_command_exists_or_exit1() {
    if ! command -v "$1" /dev/null 2>&1
    then
        echo "abort: command \"$1\" not found"
        exit 1
    fi
}

if [ $# -eq 0 ] ; then
    usage
    exit 1
fi

while [ $# -gt 0 ];
do
    case ${1} in

        serve)
            npm run start
        ;;

        load-assets)
            apt update
            apt install -y curl
            cd /app/crowi/public/ || exit 1
            curl -LO "$ICON_FAV_1" || true
            curl -LO "$ICON_FAV_2" || true
            curl -LO "$ICON_FAV_3" || true
            curl -LO "$ICON_FAV_4" || true
            curl -LO "$ICON_IOS_1" || true
            curl -LO "$ICON_IOS_2" || true
            curl -LO "$ICON_IOS_3" || true
            curl -LO "$ICON_IOS_4" || true
            curl -LO "$ICON_ANDROID_1" || true
        ;;

        --yes|-y)
            SKIP_CONFIRM=true
        ;;

        --debug|-d)
            set -x
        ;;

        --help|-h)
            usage
        ;;

        --version|-v)
            echo "$(basename "$0") $VERSION"
        ;;

        *)
            echo "$(basename "$0") invalid command or option '${1}'"
            usage
            exit 1
        ;;

    esac
    shift
done
