# GENERIC drupal functions and aliases

alias contrib="dd; cd sites/all/modules/contrib"
alias custom="dd; cd sites/all/modules/custom"

# drush 
alias bamb="drush bam-backup"
# report site status
alias ds="drush status"
# list modules
alias dm="drush pm-list"
# navigate to drupal site root
alias dd="cd \`drush dd\`"
# rebuild drupal access table
alias ccperm="drush php-eval 'node_access_rebuild();'"
# create empty contrib directories
alias dcontrib="dd; mkdir -p sites/all/modules/contrib; mkdir -p sites/all/themes/contrib; mkdir -p sites/all/modules/custom; mkdir -p sites/all/themes/custom; mkdir -p sites/all/libraries"
# open drupal aliases for editing
alias .drush="open ~/.drush/aliases.drushrc.php"
# audit drupal site
alias site_audit="drush aa --html --bootstrap --detail > ~/Desktop/site_audit.html"

dinit() {
  drush dl drupal --drupal-project-rename="$1"
  cd $1
  dcontrib
  drush dl admin_menu
  drush dl module_filter
  drush dl views
  drush dl ds
  echo ''
  echo "Drupal project downloaded as $1 with some common mods"
  echo ''
}

# enable/disable all site builder ui modules (eg views_ui)
alias disui="drush pm-list --status=enabled --pipe | grep '_ui' | xargs drush pm-disable '{}' -y"
alias denui="drush pm-list --status=disabled --pipe | grep '_ui' | xargs drush pm-enable '{}' -y"

# change the drupal theme
dtheme() {
  drush vset theme_default $1;
  drush cache-clear theme-registry;
}

# drupal git checkout
dgit() {
 if [ -z "$1" ]; then
   echo "please specify a drupal project to git from d.o"
 else
   git clone http://git.drupal.org/project/$1.git
 fi
}

# copy drupal settings.php file to sites/default for drush use in web root
alias defset="find . -name "settings.php" -exec cp {} sites/default/settings.php \;"

# enable a module (specify or current folder)
den() {
 if [ -z "$1" ]; then
   drush en ${PWD##*/} -y
 else
   drush en $1 -y
 fi
}

# disable a module (specify or current folder)
dis() {
 if [ -z "$1" ]; then
   drush dis ${PWD##*/} -y
 else
   drush dis $1 -y
 fi
}
# download and install module/theme
dlen () {
  drush dl $1;
  den $1;
}
# disable and uninstall module/theme
disun () {
  dis $1;
  drush pm-uninstall $1;
}

# get help for module (project page)
delp() {
 if [ -z "$1" ]; then
   projectname=${PWD##*/}
 else
   projectname=$1
 fi
 open "http://drupal.org/project/$projectname"
}
# open d.o project page for specified module/theme
dp () {
  open 'http://drupal.org/project/'$1;
}
# open d.o repo viewer for specified project
dg () {
  open 'http://drupalcode.org/project/'$1'.git';
}

# apply drupal style patch in current directory from url of patch
dopatch() {
  curl -OL $1;
  patchfile=$(basename $1);
  patch -p1 < $patchfile;
}
alias revpatch="patch -p1 -R < *.patch"
alias rempatch="rm *.patch"

# make a patch out of the unstaged diff of a drupal project
diffpatch () {
  if [ -z "$1" ]; then
    git diff --no-prefix > $(basename `pwd`).patch;
    echo "[module_name]-[short-description]-[issue-number]-[comment-number].patch";
  else
    # optional parameters: d.o node, comment number
    git diff --no-prefix > $(basename `pwd`)-$1-$2.patch
  fi
}

# get a password hash to replace password in db to access another account
md5_hash() {
    echo -n "a" | md5 -s "$1"
}

# flush blocked users table (http://drupal.org/node/1023440)
#alias dunblock="drush php-eval 'db_query(\"DELETE FROM `flood`\");'"

dubl () {
 echo "open sublime project for this drupal project";
 dest=$(pwd);
 dd;
 cd ../;
 project=$(pwd);
 echo $dest;
 echo $project;
 subl -a $project.sublime-project
 cd $dest;
}

# backup a drupal site to a correctly named backup location
# excludes git files and osx .DS_Store files
# corrects file permissions so that remain writable on server (relies on tel_shortcuts)
dbak() {
  drupalpath=`drush dd`;
  drupal_directory=`basename $drupalpath`;  
  # get a list of the sites folders to request all backed up
  cd $drupalpath; cd sites;
  drupal_sites=`\ls -d */`;
  sites_param=${drupal_sites//\//,};
  sites_param=`echo $sites_param | tr -d ' '`
  echo $sites_param." folders found"

  date=`date '+%d-%m-%y_%k-%M'`;
  destpath=$backupdirectory"/"$drupal_directory"/"$drupal_directory"_"$date".tar.gz";
  fixperm;

  echo "Backing up drupal site $drupal_directory";
  drush ard $sites_param  --overwrite --destination=$destpath --tar-options="--exclude=.DS_Store --exclude=.git --exclude=.gitignore --exclude= --exclude=sites/*/files"
}

# back up site as above but use backup migrate to get db first
dbbak() {
  bamb;
  dbak;
}

# download starter buildkit install
buildkit() {
 if [ -z "$1" ]; then
   drush make "http://drupalcode.org/project/buildkit.git/blob_plain/refs/heads/7.x-2.x:/distro.make" buildkit
 else
   drush make "http://drupalcode.org/project/buildkit.git/blob_plain/refs/heads/7.x-2.x:/distro.make" $1
 fi
}

