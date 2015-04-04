class briancainnet::website {
  $packages = [
    'unzip',
  ]

  $website_root = '/var/www/briancain'

  package { $packages:
    ensure => present,
  }

  class { 'nginx': }

  Vcsrepo {
    owner    => 'brian',
    provider => git,
    ensure   => present,
  }

  vcsrepo { '/home/brian/website':
    source   => "git@github.com:briancain/website.git",
    revision => master,
  }

  file { "/var/www/briancain" :
    ensure  => directory,
    owner   => "root",
    group   => "root",
    mode    => "0755",
    require => [ Package["nginx"], ],
  }

  nginx::resource::vhost { 'www.briancain.net':
    www_root => $website_root,
  }

  # lol deployments
  exec { "unzip site.zip; mv _site/* ${website_root}":
    command => "unzip site.zip; mv _site/* ${website_root}",
    user    => "root",
    cwd     => "/home/brian/website",
    require => [ Vcsrepo['/home/brian/website'], Package['unzip'], File['/var/www/briancain'], ],
  }

}
