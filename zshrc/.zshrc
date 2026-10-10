export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(git)
source $ZSH/oh-my-zsh.sh

# Move removed files to the user's trash instead of deleting them.
unalias rm 2>/dev/null
rm() {
    local trash_dir="${XDG_DATA_HOME:-$HOME/.local/share}/Trash/files"
    local arg flag i response interactive=0 verbose=0 force=0
    local -a operands selected

    while (( $# )); do
        arg=$1
        shift
        case "$arg" in
            --)
                operands+=("$@")
                break
                ;;
            --help)
                print 'Usage: rm [-fivrR] [--] file...'
                print 'Move files and directories to ~/.local/share/Trash/files.'
                return 0
                ;;
            --version)
                print 'rm (shell trash function)'
                return 0
                ;;
            --interactive)
                interactive=1
                ;;
            --verbose)
                verbose=1
                ;;
            --force)
                force=1
                ;;
            --recursive)
                ;;
            --*)
                print -u2 "rm: unsupported option: $arg"
                return 2
                ;;
            -[!-]*)
                for (( i = 2; i <= ${#arg}; i++ )); do
                    flag=${arg[i]}
                    case "$flag" in
                        f) force=1 ;;
                        r|R|d) ;;
                        v) verbose=1 ;;
                        i|I) interactive=1 ;;
                        *)
                            print -u2 "rm: unsupported option: -$flag"
                            return 2
                            ;;
                    esac
                done
                ;;
            *)
                operands+=("$arg")
                ;;
        esac
    done

    if (( ! ${#operands} )); then
        if (( force )); then
            return 0
        fi
        print -u2 'rm: missing operand'
        return 1
    fi

    if (( interactive )); then
        for arg in "${operands[@]}"; do
            printf "Move '%s' to trash? [y/N] " "$arg" >&2
            response=''
            IFS= read -r response || response=''
            [[ "$response" == [yY]* ]] && selected+=("$arg")
        done
        operands=("${selected[@]}")
    fi

    (( ${#operands} )) || return 0
    command mkdir -p -- "$trash_dir" || return

    if (( verbose )); then
        command mv --backup=numbered --verbose --target-directory="$trash_dir" -- "${operands[@]}"
    else
        command mv --backup=numbered --target-directory="$trash_dir" -- "${operands[@]}"
    fi
}

empty-trash() {
    local trash_dir="${XDG_DATA_HOME:-$HOME/.local/share}/Trash/files"
    [[ -d "$trash_dir" ]] || return 0
    command /usr/bin/rm -rf -- \
        "$trash_dir"/*(N) \
        "$trash_dir"/.[!.]*(N) \
        "$trash_dir"/..?*(N)
}

trash-list() {
    local trash_dir="${XDG_DATA_HOME:-$HOME/.local/share}/Trash/files"
    local -a entries
    if [[ ! -d "$trash_dir" ]]; then
        print 'Trash is empty.'
        return 0
    fi
    entries=("$trash_dir"/*(N) "$trash_dir"/.[!.]*(N) "$trash_dir"/..?*(N))
    if (( ! ${#entries} )); then
        print 'Trash is empty.'
        return 0
    fi
    command ls -lahA -- "$trash_dir"
}

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

# >>> conda initialize >>>
conda() {
    unset -f conda
    source ~/miniconda3/etc/profile.d/conda.sh
    conda "$@"
}
# <<< conda initialize <<<

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# opencode
export PATH=/home/weerawatw/.opencode/bin:$PATH
