
class nginx::service {
service {'nginx':
    ensure => running,
    enable => true,
    hasrestart => true,
    require => Class["nginx::install"],
  }

exec {'reload-nginx':
    command => '/etc/init.d/nginx reload',
    refreshonly => true,
  }

}
