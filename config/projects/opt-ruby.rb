#
# Copyright 2015 YOUR NAME
#
# All Rights Reserved.
#

name "opt-ruby"
maintainer "SAWANOBORI Yukihiko <sawanoboriyu@higanworks.com>"
homepage "http://higanworks.com"

# Defaults to C:/opt-ruby on Windows
# and /opt/opt-ruby on all other platforms

build_version '2.1.6'
build_iteration 1

install_dir "#{default_root}/ruby-#{build_version}"

# Creates required build directories
dependency "preparation"

## Cert updates
# override :cacerts,
# version: "2015.04.22",
# source: {
#   md5: "380df856e8f789c1af97d0da9a243769"
# }



override :ruby, version: '2.1.6'
#override :ruby,
#  version: "2.2.2",
#  source: {
#  md5: "326e99ddc75381c7b50c85f7089f3260"
#  }


dependency "ruby"
override :rubygems, version: "2.4.5"
dependency "rubygems"
override :bundler, version: '1.10.6'
# dependency "ffi-yajl"
dependency "bundler"
dependency "opt-ruby"

# Version manifest file
dependency "version-manifest"


## libs for me
# dependency "mysql2"
override :postgresql, version: '9.4.1'
dependency "postgresql"

exclude "**/.git"
exclude "**/bundler/git"
