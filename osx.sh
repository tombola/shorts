#!/bin/bash
# OSX commands
alias hidedesktop="defaults write com.apple.finder CreateDesktop false; killall Finder" 
alias showdesktop="defaults write com.apple.finder CreateDesktop true; killall Finder" 
alias showfinderpath="defaults write com.apple.finder _FXShowPosixPathInTitle -bool true; killall Finder"
alias hidefinderpath="defaults write com.apple.finder _FXShowPosixPathInTitle -bool true; killall Finder"