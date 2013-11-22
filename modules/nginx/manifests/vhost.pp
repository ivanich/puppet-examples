define nginx::vhost( $ensure = present, $docroot, $vhost_name = $title, $port = 80, $template = 'nginx/vhost-default.conf.erb', $group_name, $server_names = ['_'], $app_name='' ) {
  include nginx

  $available_dir = '/etc/nginx/sites-available'
  $enabled_dir = '/etc/nginx/sites-enabled'
  $log_dir = '/var/log/nginx'

file {"${available_dir}/${vhost_name}.conf":
    alias => "${vhost_name}.conf",
    ensure => $ensure,
    mode => '0644',
    owner => 'root',
    group => 'root',
    content => template($template),
    require => Class['nginx::install'],
    notify => Class['nginx::service'],
}  

  $link = $ensure ? {
    present => link,
    absent => absent,
    default => link,
  }

  file {"${enabled_dir}/${vhost_name}.conf":
    ensure => $link,
    target => "${available_dir}/${vhost_name}.conf",
    require => File["${vhost_name}.conf"],
    notify => Exec['reload-nginx'],
  }




 file {'/etc/nginx/sites-available/default':
    ensure => absent,
    require => Class['nginx::install'],
    notify => Exec['reload-nginx'],
  }

  file {'/etc/nginx/sites-enabled/default':
    ensure => absent,
    require => Class['nginx::install'],
    notify => Exec['reload-nginx'],
  }


}
