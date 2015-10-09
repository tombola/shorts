# GENERIC git functions and aliases

# github
alias github="open https://github.com/"

# git
alias gi="git init"
alias ga="git add ."
alias gs="git status"
alias gb="git branch -a"
alias unstage="git reset HEAD -- ."

# cos my fingers can't reach 'p'!
alias gush="git push"
alias gull="git pull"

# pretty logging
alias glog="git log --graph --pretty=oneline --abbrev-commit"

# git commit with short log message
gc() {
   git commit -m "$1"
}
# revert un-committed changes to repo
grev() {
 read -p "Drop changes and return to the last committed state - continue? (y/n)" -n 1 -r
 if [[ $REPLY =~ ^[Yy]$ ]]
 then
    echo ""
    git checkout -f ; git reset --hard
 fi
}

# add all changes, push with specified commit message
gup() {
  ga;
  gc $1;
  gush;
}