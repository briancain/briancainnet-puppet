# == Class: briancainnet::cookieleaks
# Class to setup cookieleaks.org
#
class briancainnet::cookieleaks {
  $cookieleaks_root = '/var/www/cookieleaks'

  class { 'nginx': }

  file { '/var/www' :
    ensure  => directory,
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0755',
    require => [ Package['nginx'], ],
  }

  nginx::resource::vhost { 'www.cookieleaks.org':
    www_root => $cookieleaks_root,
  }

  nginx::resource::vhost { 'cookieleaks.org':
    www_root => $cookieleaks_root,
  }

  file { $cookieleaks_root :
    ensure => directory,
    owner  => 'www-data',
    group  => 'www-data',
    mode   => '0775',
  }
}
