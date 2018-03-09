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
    require    => Package[$packages],
  }

  user { 'quakeaddict':
    ensure     => present,
    comment    => 'preben',
    managehome => true,
    shell      => '/bin/bash',
    home       => '/home/quakeaddict',
    require    => Package[$packages],
  }

  service { 'fail2ban' :
    ensure  => running,
    enable  => true,
    require => [ Package['fail2ban'], ],
  }

}
