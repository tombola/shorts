# define github repo path in .bash_profile

# navigate to
alias blog="cd $gitblog/_posts; subl .; git pull;"
alias blogpost="cd $gitblog; ga; gc 'blog post update'; git push;"
alias blogserve="cd $gitblog; open http://0.0.0.0:4000; bundle exec jekyll serve -w;"


newpost() {
  echo "new post"
  echo "Title:";
  read blogtitle;
  blogname=$(echo $blogtitle | tr " " -);
  filename=$(date +"%Y-%m-%d-")$blogname".md";
  # first arg is category, latter arguments as comma separated tags
  args=( "$@" );
  tags=$(printf ",%s" "${args[@]:1}");
  tags=${tags:1};
  echo "category: $1";
  echo "tags: $tags";
  cat <<EOF >> $filename
---
layout: post
published: true
title: "$blogtitle"
category: $1
tagline: 
tags: "$tags"
---
EOF
  echo "created "$filename;
  subl .;
  open $filename;
}

