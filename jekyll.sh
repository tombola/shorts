#!/bin/bash
# define github repo path in .bash_profile

# navigate to
# alias blog="cd $gitblog/source/_posts; subl .; git pull;"
# alias blogpost="cd $gitblog; ga; gc 'blog post update'; git push;"

alias blog="cd $gitblog; git pull; cd $gitblog/source/_posts; subl .;"
alias blogpost="cd $gitblog/public; ga; gc 'blog post update'; git push;"
alias blogserve="cd $gitblog; open http://0.0.0.0:4000; bundle exec jekyll serve -w;"
alias blogdate="date +\"%Y-%m-%d-T%H:%m:%S+00:00\""
alias octodate="date +\"%Y-%m-%d-T%H:%m:%S+00:00\""

function newpost() {
  echo "new post"
  echo "Title:";
  read blogtitle;
  blogname=$(echo $blogtitle | tr " " -);
  filename=$gitblog/source/_posts/$(date +"%Y-%m-%d-")$blogname".md";
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

