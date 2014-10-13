# GENERIC functions and aliases

# clear terminal window
alias cl="clear; pwd"
# list view of current directory including hidden files
alias la="ls -al"
# list directories only
alias lsd="ls -l | grep ^d"
# osx file sytem shortcuts
alias aliases="open ~/.bash_profile"
alias sites="cd ~/Sites"
# play a text adventure game!
alias textadv="emacs -batch -l dunnet"
# open file (in default application)
alias o="open ."
# open this directory (is file browser)
alias o..="open .."
# open specified file
op() {
  open "$1"
}
# find file/dir by name
f() {
  find . -name $1
}
# find folder (below this one) and navigate to it
cdf() {
  cd ./$(find . -name "$1") 
	pwd
}

# tell me when a minute has gone by
minute() {
		last_m=$(date '+%M');
		now_m=$(date '+%M');
    now_t=$(date '+%T');
		while [ $now_m == $last_m ]; do
			now_m=$(date '+%M');
      now_t=$(date '+%T');
			clear;
			echo $now_t;
			sleep 1;
		done
    # afplay sound.mp3;
		say "one minute has now passed";
		sleep 1;
    minute;
}

# usecase specific - do not use unless understood
# fixes problematic file permissions prior to deployment
fixperm() {
  read -p "Replace all matching permissions in current directory (recursively)? (y/n)" -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    echo "" 
    if [ -z "$1" ]; then
      find . -perm 444 -print -exec chmod 644 {} \;
      echo "444 (read-only) permissions replaced with 644 (owner write)"
      find . -perm 555 -print -exec chmod 755 {} \;
      echo "555 (owner read-execute) permissions replaced with 755 (owner write)"
      echo "files should now be manageable by your user once uploaded to web server"
    else
   	  if [ -z "$2" ]; then
    	  echo "Please specify the permissions that you would like applied instead of $1"
      else
        find . -perm $1 -print -exec chmod $2 {} \;
      fi
    fi
  fi
}