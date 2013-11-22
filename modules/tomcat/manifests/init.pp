class tomcat {
  $tomcat_port = 8080 
  
  notice("Establishing http://$hostname:$tomcat_port/")

  Package { # defaults
    ensure => installed,
    require => Class['java::install'],
  }

  package { 'tomcat7':
  }

  package { 'tomcat7-user':
    require => Package['tomcat7'],
  }
 
  package { 'tomcat7-admin':
    require => Package['tomcat7'],
  }


file { "/etc/default/tomcat7":
    owner => 'root',
    require => Package['tomcat7'],
    notify => Service['tomcat7'],
    content => template('tomcat/tomcat7.erb')
  }


  file { '/etc/tomcat7/server.xml':
     owner => 'root',
     require => Package['tomcat7'],
     notify => Service['tomcat7'],
     content => template('tomcat/server.xml.erb'),
  }

  service { 'tomcat7':
    ensure => running,
    enable => true,
    hasstatus => true,
    hasrestart => true,
    require => Package['tomcat7'],
  }

}

#define tomcat::deployment($path) {

#  include tomcat
#  notice("Establishing http://$hostname:${tomcat::tomcat_port}/$name/")

#  file { "/var/lib/tomcat7/webapps/${name}.war":
#    owner => 'root',
#    source => $path,
#  }

#}


