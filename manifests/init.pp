# == Class: briancainnet
#
# A class to set up my servers
#
# === Parameters
#
# === Variables
#
# === Examples
#
# === Authors
#
# Brian Cain <brianccain@gmail.com>
#
# === Copyright
#
# Copyright 2015 Brian Cain
#
class briancainnet {
  $packages = [
    'fail2ban',
    'vim',
    'zsh',
    'git',
    'htop',
    'screen',
    'tree',
  ]

  package { $packages:
    ensure => latest,
  }

  user { 'brian':
    ensure     => present,
    comment    => 'brian',
    managehome => true,
    shell      => '/bin/zsh',
    home       => '/home/brian',
  }
}
