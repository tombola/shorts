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
# open hosts file for editing
alias hosts="open /private/etc/hosts"
# open file (in default application)
alias o="open ."
# open this directory (is file browser)
alias o..="open .."
# bookmark directory to return to it
bookmark() { bookmark=`pwd`; }
back() { cd $bookmark; }
shortcut() { `echo $1`="cd `pwd`"; }
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
# compress a folder but leave out the OSX clutter
mactar() {
  tar --exclude ".DS_Store" -cvzf $1.tar.gz $1
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

# google calendars (requires googlecl - http://bit.ly/1w3pixt)
# use 'quick add' to create an event
gcal() {
  google calendar add "$1";
}

# Friday hometime countdown
countdown() {
  nowhour=`date '+%H'`;
  endhour=17;
  hours=$endhour−$nowhour;
  echo $hours;

  MIN=10 && for i in $(seq $(($MIN*60)) -1 1);
  do printf "\r%02d:%02d:%02d" $((i/3600)) $(( (i/60)%60)) $((i%60));
  sleep 1;
  done
}
