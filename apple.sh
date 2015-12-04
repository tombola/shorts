alias showfiles="defaults write com.apple.finder AppleShowAllFiles YES"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles NO"

alias finderpathtitle="defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES"

function notify() {
    osascript -e 'display notification "'$2'" with title "'$1'"'
}
# for vagrant-notify
function notify-send() {
    osascript -e 'display notification "'$2'" with title "'$1'"'
}