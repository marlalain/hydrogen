#!/usr/bin/env dash

# TODO add support for bash
# \033[38;2;<R>;<G>;<B>m
red="\033[38;2;200;20;20m"
green="\033[38;2;20;200;20m"
blue="\033[38;2;20;20;200m"
reset="\033[38;2;200;200;200m" # FIXME
set -eu

. "./dispatch.sh"


error() {
    echo "${red}[!]${reset} $1";
}

system() {
    echo "${blue}[!]${reset} $1"
}


dsample_command_hello () (
    echo "Hello World!"
)

dsample_option_version () ( echo "Version: <git>" )
dsample_option_help () {
    printf "Usage: hydro [OPTIONS] COMMAND [ARGS]...\n"
    printf "\nAuthor: Paulo Elienay <@paulo-e on GitHub>\n"
    printf "\nOptions:\n"
    printf "\tbootstrap\tbootstraps hydro"
    printf "\nFlags:\n"
    printf "\t--help\tshows this message\n"
    printf "\t\tuse 'hydro command --help' to get more info"
    echo
}

dsample_command_bootstrap () {
    HYDRO_FOLDER="${HOME}/.hydro"
    if [ ! -d "${HYDRO_FOLDER}" ]; then
        system "Hydro is getting for the first time..."
        mkdir -p "${HYDRO_FOLDER}/src/.scripts"
        mkdir -p "${HYDRO_FOLDER}{bin, lib}"
    else
        printf "To bootstrap with hydro already set up the original '%s' needs to be deleted. " "${HYDRO_FOLDER}"
        printf "Is that ok? [yes] "
        read -r input
        if [ ${input-"yes"} = "yes" ]; then
            rm -rf $HYDRO_FOLDER
        else
            error "Nothing left to do"
        fi
    fi
}

dsample_ () {
    error "no operation specified (use --help)"
}

dsample_call_ () (error "invalid call")

dispatch dsample "$@"
