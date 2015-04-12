# == Class: briancainnet::cookieleaks
# Class to setup cookieleaks.org
#
class briancainnet::cookieleaks {

  class { 'nginx': }

  nginx::resource::vhost { ['www.cookieleaks.org', 'cookieleaks.org'] :
    proxy => 'http://localhost:5432',
  }
}
