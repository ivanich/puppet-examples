define tomcat::users ( $template='tomcat/tomcat-users.xml.erb', $users='' ) {
include tomcat 

file { "/etc/tomcat7/tomcat-users.xml":
    owner => 'root',
    require => Package['tomcat7'],
    notify => Service['tomcat7'],
    content => template($template),
  }

}
