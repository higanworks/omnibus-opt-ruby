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

build_version '2.1.5'
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



override :ruby, version: '2.1.5'
#override :ruby,
#  version: "2.2.0",
#  source: {
#  md5: "cd03b28fd0b555970f5c4fd481700852"
#  }


dependency "ruby"
override :rubygems,
  version: "2.4.6",
  source: {
  md5: "5909df4829e5350ca431644322ea9e89"
  }
dependency "rubygems"
override :bundler, version: '1.9.4'
# dependency "ffi-yajl"
dependency "bundler"
dependency "opt-ruby"

# Version manifest file
dependency "version-manifest"


## libs for me
# dependency "mysql2"
override :postgresql,
  version: '9.4.1',
  source: {
  md5: "2cf30f50099ff1109d0aa517408f8eff"
  }
dependency "postgresql"

exclude "**/.git"
exclude "**/bundler/git"
