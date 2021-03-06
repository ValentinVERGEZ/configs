# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="stosh"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

export PATH="/home/pyro/catkin_ws/devel/bin:/opt/ros/indigo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# function sudo {
#     if [ $@ == "su" ];then
#         echo "su"
#         # builtin sudo su -s /bin/szh
#     else
#         echo "not su"
#         # builtin sudo $@
#     fi
# }

function sudo() {
    if [[ "$@" == su ]]; then
        command sudo su -s /bin/zsh
    else
        command sudo $@
    fi
}

if [[ $(hostname) == "DesktopPC" ]]; then

	# Laptop and desktop
	echo ""
	echo 	"  (‾⌣‾)   ᶠᶸᶜᵏ ♥ ᵧₒᵤ "
	# echo 	"░░░░░░░░░░░░░░░░░░░░░"


	## ROS
	# source ${HOME}/Projets/catkin_ws/devel/setup.zsh
	source ${HOME}/catkin_tests_ws/devel/setup.zsh
	source /opt/ros/jade/setup.zsh

	## Gazebo
	source /usr/share/gazebo/setup.sh

elif [[ $(hostname) == "d336" ]]; then

	# D336
	echo ""
	echo 	" ╭∩╮（︶︿︶）╭∩╮ ᶠᶸᶜᵏ♥ᵧₒᵤ "
	# echo 	'"""""""""""""""""""""""""""'

	## Proxy
	export http_proxy="proxy.polytech-lille.fr:3128"
	export https_proxy="proxy.polytech-lille.fr:3128"
	export HTTP_PROXY=$http_proxy
	export HTTPS_PROXY=$https_proxy

	## ROS
	source ${HOME}/catkin_ws/devel/setup.zsh
	source /opt/ros/jade/setup.zsh

	## Gazebo
	source /usr/share/gazebo/setup.sh

elif [[ $(hostname) == "vve-T1700" ]]; then

	# Work
	echo ""
	echo 	"                 ¯\_(ツ)_/¯"
	# echo 	"==========================="

	# echo -e "\033[36m ___  ____  _____  ___  _   _ ";
	# echo 			"/ __)(_  _)(  _  )/ __)( )_( )";
	# echo 			"\__ \  )(   )(_)( \__ \ ) _ ( ";
	# echo -n 		"(___/ (__) (_____)(___/(_) (_)";
	# echo -e "\033[0m"
	# echo -e 		"=============================="
	# cat ${HOME}/scripts/stosh_logo.txt

	# Upd
	source ~/scripts/upd.sh

	# PSnext
	source ~/scripts/psnext.sh

	# Build machines relative
	source ~/scripts/buildmachines.sh

else

	# Unknown
	echo 	""
	echo 	" Where am I ?? ლ(ಠ益ಠლ)"
	# echo 	"======================="

fi

# Binaires perso
export PATH=$PATH:~/bin

# Start ssh-agent
source ~/scripts/ssh-agent.sh

# Navigate
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../../"
alias .....="cd ../../../../"
alias ......="cd ../../../../../"
alias .......="cd ../../../../../../"

# Anti mouffle
alias sl="sl -e -a"

# Git switch
git() {
  if [[ $@ == "switch" ]]; then
	command ~/scripts/switch.sh
  elif [[ $@ == "commit up" ]];then
	command git commit --amend --no-edit -a
  else
	command git "$@"
  fi
}

alias clear="clear && source ~/.zshrc"
