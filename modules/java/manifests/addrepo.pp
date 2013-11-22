class java::addrepo {


package { "software-properties-common":
#    require => Exec['apt-update'],
    ensure => installed
  }


  exec { "add-apt-repository-oracle":
    command => "sudo add-apt-repository -y ppa:webupd8team/java",
    require => Package["software-properties-common"],
    path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
    notify => Exec["apt-update"]
  }
 
 
  exec { 'apt-update':
    command => 'apt-get update',
    refreshonly => true,
    path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ],
  }
}
