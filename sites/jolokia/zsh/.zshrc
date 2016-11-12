setopt AUTO_CD
bindkey -a 'q' push-line


PROMPT_SYM_COLOR=green
PROMPT_HOST_COLOR=white
PROMPT_USER_COLOR=white
PROMPT_PWD_COLOR=white
if [ X0 = "X$(id -u)" ]
then
	PROMPT_SYM_COLOR=yellow
	PROMPT_HOST_COLOR=yellow
	PROMPT_USER_COLOR=yellow
	PROMPT_PWD_COLOR=yellow
fi

PROMPT_HOSTPWD="%{%F{$PROMPT_SYM_COLOR}%}[ %{%f%}%{%F{$PROMPT_HOST_COLOR}%}%m%{%f%}%{%F{$PROMPT_SYM_COLOR}%}:%{%f%}%{%F{$PROMPT_PWD_COLOR}%}%~%{%f%}%{%F{$PROMPT_SYM_COLOR}%} ]%{%f%}"
PROMPT_USER="%{%F{$PROMPT_USER_COLOR}%}%n%{%f%}%{%F{$PROMPT_SYM_COLOR}%}%#%{%f%}"
PROMPT="$PROMPT_HOSTPWD
$PROMPT_USER "
