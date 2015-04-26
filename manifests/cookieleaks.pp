# == Class: briancainnet::cookieleaks
# Class to setup cookieleaks.org
#
class briancainnet::cookieleaks {
  $packages = [
    'unzip',
  ]

  package { $packages : ensure => present, }

  $cookieleaks_root = '/var/www/cookieleaks'
  $cookieleaks_repo_root = '/home/brian/projects/cookieleaks.org'

  Vcsrepo {
    owner    => 'brian',
    provider => git,
    ensure   => present,
  }

  vcsrepo { $cookieleaks_repo_root:
    source   => 'https://www.github.com/briancain/cookieleaks.org',
    ensure   => latest,
    revision => master,
  }

  class { 'nginx': }

  file { '/var/www' :
    ensure  => directory,
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0755',
    require => [ Package['nginx'], ],
  }

  nginx::resource::vhost { ['www.cookieleaks.org', 'cookieleaks.org'] :
    www_root => $cookieleaks_root,
  }

  file { $cookieleaks_root :
    ensure => directory,
    owner  => 'www-data',
    group  => 'www-data',
    mode   => '0775',
  }

  # lol deployments
  exec { 'extract cookieleaks artifact':
    command => "/usr/bin/unzip -o ${cookieleaks_repo_root}/files/site.zip",
    path    => "${cookieleaks_repo_root}/files",
    user    => 'root',
    cwd     => "${cookieleaks_repo_root}/files",
    require => [ Vcsrepo[$cookieleaks_repo_root], Package['unzip'] ],
  }

  file { $cookieleaks_root :
    ensure  => directory,
    recurse => true,
    source  => "${cookieleaks_repo_root}/files/_site",
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0755',
    require => Exec['extract cookieleaks artifact'],
  }
}
