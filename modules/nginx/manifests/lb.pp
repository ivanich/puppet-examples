define nginx::lb(  $template = 'nginx/nginx.conf.erb', $group_name, $node_names = ['_'] ) {
  include nginx


file {"/etc/nginx/nginx.conf":
    ensure => present,
    mode => '0644',
    owner => 'root',
    group => 'root',
    content => template($template),
    require => Class['nginx::install'],
    notify => Class['nginx::service'],
    }
}

