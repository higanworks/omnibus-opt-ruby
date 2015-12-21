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

build_version "2.2.4"
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



override :ruby, version: '2.2.4'


dependency "ruby"
override :rubygems, version: "2.4.8"
dependency "rubygems"
override :bundler, version: '1.10.6'
# dependency "ffi-yajl"
dependency "bundler"
dependency "opt-ruby"

# Version manifest file
dependency "version-manifest"


## libs for me
# dependency "mysql2"
override :mpfr,
  version: "3.1.3",
  source: {
  md5: "7b650781f0a7c4a62e9bc8bdaaa0018b"
  }
#override :gcc,
#  version: "4.9.3",
#  source: {
#  md5: "648bfba342bb41a4b5350fb685f85bc5"
#  }
# dependency 'gcc'
override :postgresql, version: '9.4.5'
dependency "postgresql"

exclude "**/.git"
exclude "**/bundler/git"
