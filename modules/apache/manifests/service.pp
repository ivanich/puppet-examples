class apache::service {
	service { "httpd":
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
		require => Class["apache::install"],
	}
}

define apache::vhost( $port, $docroot, $ssl=true, $template='apache/vhost.conf.erb',$serveralias=''){

include apache

file {"/etc/httpd/conf.d/${name}.conf":
	content => template($template),
	owner => 'root',
	group => 'root',
	mode => '644',
	require => Class["apache::install"],
	notify => Class["apache::service"],
	
	}
}
