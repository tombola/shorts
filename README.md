
# Shorts

> [We love short shorts](https://www.youtube.com/watch?v=UcvjXAtzaMU)

![shorts](shorts.png)

I love using the terminal, but I do get frustrated by long or repetitive commands, so I have a set of shortcut commands that I load at bash startup. I hope they may be of use to someone else, but the main reason they are on github is so that I can clone them when provisioning a [vagrant](https://www.vagrantup.com/) box.

I work a lot with git and drupal (via [drush](http://drush.ws/)), so a lot of the shorts are created for this purpose, though you can pick and choose.

In order to use them, create or amend .profile or .bash_profile in your user directory to include the following:

````
# set custom directories
backupdirectory="/Users/myusername/backups"
script_directory="/Users/myusername/scripts"

# delete or include shortcut categories as required
. $script_directory"/tel_aliases.shortcuts"
. $script_directory"/drupal.sh"
. $script_directory"/shorts.sh"
````