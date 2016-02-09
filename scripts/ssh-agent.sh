## Source this file in ~/.bashrc in order to start the ssh-agent from it

GREP=/bin/grep
test=`/bin/ps uU $USER | $GREP ssh-agent | $GREP -v grep | /usr/bin/awk '{print $2}' | xargs`

if [ "$test" = "" ]; then
   # there is no agent running
   if [ -e "$HOME/scripts/tmp/agent.sh" ]; then
      # remove the old file
      /bin/rm -f $HOME/scripts/tmp/agent.sh
   fi;
   # start a new agent
   /usr/bin/ssh-agent | $GREP -v echo >&$HOME/scripts/tmp/agent.sh
fi;

test -e $HOME/scripts/tmp/agent.sh && source $HOME/scripts/tmp/agent.sh



if [ "$test" = "" ]; then
   # A new agent was started, add keys
   echo -e "\033[36m * ssh-add needed\033[0m"
   ssh-add
fi;

alias kagent="kill -9 $SSH_AGENT_PID"
