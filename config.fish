set -U fish_greeting 
set -gx fish_prompt_pwd_dir_length 4
if status is-interactive
	alias ls=exa
	alias lsa='exa -a'
	alias vim=nvim
	alias python=python3
	alias bright="sudo vim /sys/class/backlight/intel_backlight/brightness"
	set joe random 0 1
	if test ($joe) -eq 1
		susfetch
	else 
		susfetch -s | kisser
	end
end
