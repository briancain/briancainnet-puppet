# == Class: briancainnet::website
# Class to setup briancain.net
#
class briancainnet::website {
  $packages = [
    'unzip',
  ]

  package { $packages : ensure => present, }

  $website_root = '/var/www/briancain'
  $website_repo_root = '/home/brian/website'

  class { 'nginx': }

  Vcsrepo {
    owner    => 'brian',
    provider => git,
    ensure   => present,
  }

  vcsrepo { $website_repo_root:
    source   => 'https://www.github.com/briancain/website',
    revision => master,
  }

  file { '/var/www' :
    ensure  => directory,
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0755',
    require => [ Package['nginx'], ],
  }

  nginx::resource::vhost { 'www.briancain.net':
    www_root => $website_root,
  }

  # lol deployments
  exec { 'extract website artifact':
    command => "/usr/bin/unzip -o ${website_repo_root}/files/site.zip",
    path    => "${website_repo_root}/files",
    user    => 'root',
    cwd     => "${website_repo_root}/files",
    require => [ Vcsrepo[$website_repo_root], Package['unzip'] ],
  }

  file { $website_root :
    ensure  => directory,
    recurse => true,
    source  => "${website_repo_root}/files/_site",
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0755',
    require => Exec['extract website artifact'],
  }
}
