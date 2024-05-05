set -U fish_greeting 
set -gx fish_prompt_pwd_dir_length 4

function fish_prompt
    set_color blue 
    echo cronch (pwd) '>' (set_color normal)
end


if status is-interactive
	alias manmaster 'man -k . | awk '\''{for (i=1; i<=NF; i++) if (i != 2) printf "%s ", $i; else printf "%s ", substr($i, 1, 5); printf "\n"}'\'' | awk '\''{ printf "%-16s - %s\n", $1, substr($0, index($0,$4)) }'\'' | fzf --preview "man {1}" | awk '\''{print $1}'\'' | xargs -r tldr'
	alias ls=exa
	# alias cd=zoxide
	alias history='history | fzf'
	alias rm='rm -i'
	alias lsa='exa -a'
	alias vim=nvim
	alias python=python3
	alias tp=trash-put
	set joe random 0 1
	if test ($joe) -eq 0
		susfetch
	else if test ($joe) -eq 1
		susfetch -s | kisser
	else 
		man -k . | grep -v '[.:]' | shuf -n 1
	end
end
