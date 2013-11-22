class java::config {

$java_home = "/usr/lib/jvm/java-6-oracle"

 exec {
    'set-licence-selected':
      command => '/bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections',
      unless => "debconf-get-selections | grep 'oracle-java6-installer.*shared/accepted-oracle-license-v1-1.*true'",
      path => ["/bin", "/usr/bin"];

     'set-licence-seen':
      command => '/bin/echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections',
      unless => "debconf-get-selections | grep 'oracle-java6-installer.*shared/accepted-oracle-license-v1-1.*true'",
      path => ["/bin", "/usr/bin"];

  }
exec {
    'update-java-alternatives':
      command => "update-java-alternatives --jre --set java-6-oracle",
      path => ["/usr/sbin", "/usr/bin", "/bin", "/sbin"],
      unless => 'test $(readlink /etc/alternatives/java) = /usr/lib/jvm/java-6-oracle/jre/bin/java',
      require => Package["oracle-java6-installer"];
  }
}


