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
    shell      => '/bin/bash',
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

  user { 'hail9000':
    ensure     => present,
    comment    => 'hailee',
    managehome => true,
    shell      => '/bin/bash',
    home       => '/home/hail9000',
    require    => Package[$packages],
  }

  service { 'fail2ban' :
    ensure  => running,
    enable  => true,
    require => [ Package['fail2ban'], ],
  }

}
