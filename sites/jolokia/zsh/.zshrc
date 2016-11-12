setopt AUTO_CD
bindkey -a 'q' push-line

PROMPT_HOSTPWD="%{%F{blue}[%f%F{cyan}%m%f%F{blue}:%f%F{cyan}%~%f%F{blue}]%f%}"
PROMPT_USER="%{%F{cyan}%n%f%F{blue}%#%f%}"
if [ X0 = "X$(id -u)" ]
then
	PROMPT_USER="%{%F{yellow}%n%f%F{blue}%#%f%}"
fi
PROMPT="$PROMPT_HOSTPWD
$PROMPT_USER "
