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

  file { [ '/var/www', $website_root ] :
    ensure  => directory,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    require => [ Package['nginx'], ],
  }

  nginx::resource::vhost { 'www.briancain.net':
    www_root => $website_root,
  }

  # lol deployments
  exec { "/usr/bin/unzip ${website_repo_root}/files/site.zip; /bin/mv ${website_repo_root}/_site/* ${website_root}":
    command => "/usr/bin/unzip ${website_repo_root}/files/site.zip; /bin/mv ${website_repo_root}/_site/* ${website_root}",
    path    => $website_repo_root,
    user    => 'root',
    cwd     => $website_repo_root,
    require => [ Vcsrepo[$website_repo_root], Package['unzip'], File[$website_root], ],
  }
}
