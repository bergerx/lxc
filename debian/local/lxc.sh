#!bash

# bash completion for lxc
### v1.1 20111211
#
# CHANGE LOG:
# v1.1:
# added basic completion for 'lxc $command $container' next syntax
# v1.0:
# initial kork

have lxc-start && {

_lxc_names()
{
	COMPREPLY=( $( compgen -W "$( /usr/bin/lxc-ls )" "$cur" ) )
}

_lxc_status()
{
	COMPREPLY=( $( compgen -W "RUNNING STOPPED" "$cur" ) )
}

_lxc_templates()
{
	COMPREPLY=( $( compgen -W "$( /bin/ls /usr/share/lxc/templates/ | sed -e 's|^lxc-||' )" "$cur" ) )
}

_lxc-start()
{
	local cur prev

	COMPREPLY=()
	_get_comp_words_by_ref cur prev

	case $prev in
		-n)
			_lxc_names "$cur"
			return 0
			;;
	esac

	if [[ "$cur" == -* ]]
	then
		COMPREPLY=( $( compgen -W '-n -d -f -c -s -q -o -l' -- "$cur" ) )
	fi
}
complete -F _lxc-start lxc-start

_lxc-generic()
{
	local cur prev

	COMPREPLY=()
	_get_comp_words_by_ref cur prev

	case $prev in
		-n)
			_lxc_names "$cur"
			return 0
			;;
	esac

	if [[ "$cur" == -* ]]
	then
		COMPREPLY=( $( compgen -W '-n -q -o -l' -- "$cur" ) )
	fi
}
complete -F _lxc-generic lxc-stop
complete -F _lxc-generic lxc-halt
complete -F _lxc-generic lxc-shutdown
complete -F _lxc-generic lxc-kill
complete -F _lxc-generic lxc-monitor
complete -F _lxc-generic lxc-cgroup
complete -F _lxc-generic lxc-unfreeze

_lxc-info()
{
	local cur prev

	COMPREPLY=()
	_get_comp_words_by_ref cur prev

	case $prev in
		-n)
			_lxc_names "$cur"
			return 0
			;;
	esac

	if [[ "$cur" == -* ]]
	then
		COMPREPLY=( $( compgen -W '-n -s -p -q -o -l' -- "$cur" ) )
	fi
}
complete -F _lxc-info lxc-info

_lxc-wait()
{
	local cur prev

	COMPREPLY=()
	_get_comp_words_by_ref cur prev

	case $prev in
		-n)
			_lxc_names "$cur"
			return 0
			;;

		-s)
			_lxc_status "$cur"
			return 0
			;;
	esac

	if [[ "$cur" == -* ]]
	then
		COMPREPLY=( $( compgen -W '-n -s -p -q -o -l' -- "$cur" ) )
	fi
}
complete -F _lxc-wait lxc-wait

_lxc-create()
{
	local cur prev

	COMPREPLY=()
	_get_comp_words_by_ref cur prev

	case $prev in
		-t)
			_lxc_templates "$cur"
			return 0
			;;
	esac

	if [[ "$cur" == -* ]]
	then
		COMPREPLY=( $( compgen -W '-n -t -f' -- "$cur" ) )
	fi
}
complete -F _lxc-create lxc-create

_lxc-console()
{
	local cur prev

	COMPREPLY=()
	_get_comp_words_by_ref cur prev

	case $prev in
		-n)
			_lxc_names "$cur"
			return 0
			;;
	esac

	if [[ "$cur" == -* ]]
	then
		COMPREPLY=( $( compgen -W '-n -t -q -o -l' -- "$cur" ) )
	fi
}
complete -F _lxc-console lxc-console

_lxc-destroy()
{
	local cur prev

	COMPREPLY=()
	_get_comp_words_by_ref cur prev

	case $prev in
		-n)
			_lxc_names "$cur"
			return 0
			;;
	esac

	if [[ "$cur" == -* ]]
	then
		COMPREPLY=( $( compgen -W '-n' -- "$cur" ) )
	fi
}
complete -F _lxc-destroy lxc-destroy

_lxc-execute()
{
	local cur prev

	COMPREPLY=()
	_get_comp_words_by_ref cur prev

	case $prev in
		-n)
			_lxc_names "$cur"
			return 0
			;;
	esac

	if [[ "$cur" == -* ]]
	then
		COMPREPLY=( $( compgen -W '-n -f -s -- -q -o -l' -- "$cur" ) )
	fi
}
complete -F _lxc-execute lxc-execute

_lxc-ps()
{
	local cur prev

	COMPREPLY=()
	_get_comp_words_by_ref cur prev

	case $prev in
		-n)
			_lxc_names "$cur"
			return 0
			;;
	esac

	if [[ "$cur" == -* ]]
	then
		COMPREPLY=( $( compgen -W '-n -- -q -o -l' -- "$cur" ) )
	fi
}
complete -F _lxc-ps lxc-ps

_lxc-restart()
{
	local cur prev

	COMPREPLY=()
	_get_comp_words_by_ref cur prev

	case $prev in
		-n)
			_lxc_names "$cur"
			return 0
			;;
	esac

	if [[ "$cur" == -* ]]
	then
		COMPREPLY=( $( compgen -W '-n -S -d -p -f -s -q -o -l' -- "$cur" ) )
	fi
}
complete -F _lxc-restart lxc-restart

_lxc-checkpoint()
{
	local cur prev

	COMPREPLY=()
	_get_comp_words_by_ref cur prev

	case $prev in
		-n)
			_lxc_names "$cur"
			return 0
			;;
	esac

	if [[ "$cur" == -* ]]
	then
		COMPREPLY=( $( compgen -W '-n -S -d -p -k -q -o -l' -- "$cur" ) )
	fi
}
complete -F _lxc-checkpoint lxc-checkpoint

# next lxc command usage
_lxc-cmd()
{
	local cur prev

	COMPREPLY=()
	_get_comp_words_by_ref cur prev

	case $prev in
		lxc)
			COMPREPLY=( $( compgen -W 'attach cgroup checkconfig checkpoint clone console create destroy execute freeze halt shutdown info kill ls monitor netstat ps restart setcap setuid start stop unfreeze unshare version wait' -- "$cur" ) )
			return 0
			;;

		attach|cgroup|checkconfig|checkpoint|clone|console|create|destroy|execute|freeze|halt|shutdown|info|kill|monitor|netstat|ps|restart|start|stop|unfreeze|unshare|wait)
			_lxc_names "$cur"
			return 0
			;;
	esac
}
complete -F _lxc-cmd lxc

}
