#!zsh

# Zsh completion for git subtree
#
# Installation
# ------------
#
#  1. Install this file. Either:
#
#     a. Place it in your .zshrc:
#
#     b. Or, copy it somewhere (e.g. ~/.git-subtree-completion.zsh) and put the following line in
#        your .zshrc:
#
#            source ~/.git-subtree-completion.zsh
#
#     c. Or, use this file as a oh-my-zsh plugin.
#

_git-subtree ()
{
	local curcontext="$curcontext" state line
	typeset -A opt_args

	_arguments -C \
		':command:->command' \
		'*::options:->options'

	case $state in
		(command)

			local -a subcommands
			subcommands=(
				"add:Create a subtree"
				"merge:Merge recent changes up to commit into the subtree"
				"pull:Merge recent changes and run 'git pull'"
                "push:Does a 'split' and 'git push'"
				"split:Extract a newly created history suitable for export as a separate git repository"
			)

			_describe -t commands 'git subtree' subcommands
		;;

		(options)
			case $line[1] in

                (add)
                    __git-subtree-add
                ;;

                (merge)
                    __git-subtree-merge
                ;;

                (pull)
                    __git-subtree-pull
                ;;

                (push)
                    __git-subtree-push
                ;;

                (split)
                    __git-subtree-split
                ;;

			esac
		;;
	esac
}

__git-subtree-add ()
{
    _arguments \
        '(-P --prefix)'{-P,--prefix=}'[path in the repository]: :_files' \
        '(-m --message)'{-m,--message=}'[message for merge commit]' \
        '(-d, --debug)'{-d,--debug}'[produce even more unnecessary output messages on stderr'] \
        '(-q, --quiet)'{-q,--quiet}'[suppress unnecessary output on stderr'] \
        --squash'[merge subtree changes as a single commit]'

}

__git-subtree-merge ()
{
    _arguments \
        '(-P --prefix)'{-P,--prefix=}'[path in the repository]: :_files' \
        '(-m --message)'{-m,--message=}'[message for merge commit]' \
        '(-d, --debug)'{-d,--debug}'[produce even more unnecessary output messages on stderr'] \
        '(-q, --quiet)'{-q,--quiet}'[suppress unnecessary output on stderr'] \
        --squash'[merge subtree changes as a single commit]'
}

__git-subtree-pull ()
{
	_arguments \
        '(-P --prefix)'{-P,--prefix=}'[path in the repository]: :_files' \
        '(-m --message)'{-m,--message=}'[message for merge commit]' \
        '(-d, --debug)'{-d,--debug}'[produce even more unnecessary output messages on stderr'] \
        '(-q, --quiet)'{-q,--quiet}'[suppress unnecessary output on stderr'] \
        --squash'[merge subtree changes as a single commit]'

}

__git-subtree-push ()
{
    _arguments \
        '(-P --prefix)'{-P,--prefix=}'[path in the repository]: :_files' \
        '(-d, --debug)'{-d,--debug}'[produce even more unnecessary output messages on stderr'] \
        '(-q, --quiet)'{-q,--quiet}'[suppress unnecessary output on stderr'] \
        --squash'[merge subtree changes as a single commit]'
}

__git-subtree-split ()
{
    _arguments \
        '(-P --prefix)'{-P,--prefix=}'[path in the repository]: :_files' \
        --annotate='[add annotation as prefix to each commit]' \
        '(-b --branch)'{-b,--branch=}'[create a new branch that contains the new history]' \
        '(-P --prefix)'{-P,--prefix=}'[path in the repository]: :_files' \
        --ignore-joins'[generate only new new commits since last --rejoin]' \
        --onto='[first commit]' \
        --rejoin'[after splitting, merge the newly created synthetic history back into project'] \
        '(-d, --debug)'{-d,--debug}'[produce even more unnecessary output messages on stderr'] \
        '(-q, --quiet)'{-q,--quiet}'[suppress unnecessary output on stderr']
}

zstyle ':completion:*:*:git:*' user-commands subtree:'merge subtrees together and split repository into subtrees'
