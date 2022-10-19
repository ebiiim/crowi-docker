#!/bin/sh

SKIP_CONFIRM=false
CROWI_DIR_PUBLIC=/app/crowi/public

usage() {
    cat <<EOF
Usage: $0 [option]... <command>

Commands:
    serve           do npm start
    load-assets     download assets from URLs specified in env \$ASSETS_*

Options:
    --yes, -y       skip confirmations
    --debug, -d     print all executed commands (set -x)
    --help, -h      print this message
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

# Usage: download_if_env_exists <ENVIRONMENT_VARIABLE_NAME>
# Example: download_if_env_exists URL_FAVICON
download_if_env_exists() {
    _key=\$"$1"
    _val=$(eval "echo $_key")
    if [ "$_val" ]
    then
        echo "load-assets: download $_key from $_val"
        curl -LO "$_val"
    else
        echo "load-assets: skip $_key"
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
            cd $CROWI_DIR_PUBLIC || exit 1
            download_if_env_exists ASSETS_ICON_FAV_1
            download_if_env_exists ASSETS_ICON_FAV_2
            download_if_env_exists ASSETS_ICON_FAV_3
            download_if_env_exists ASSETS_ICON_FAV_4
            download_if_env_exists ASSETS_ICON_IOS_1
            download_if_env_exists ASSETS_ICON_IOS_2
            download_if_env_exists ASSETS_ICON_IOS_3
            download_if_env_exists ASSETS_ICON_IOS_4
            download_if_env_exists ASSETS_ICON_IOS_5
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

        *)
            echo "$(basename "$0") invalid command or option '${1}'"
            usage
            exit 1
        ;;

    esac
    shift
done
