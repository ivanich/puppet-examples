class java::install {

package { 'oracle-java6-installer':
    ensure => present,
#    refreshdb  => true,
    require => [Exec['add-apt-repository-oracle'], Exec['apt-update'], Exec['set-licence-selected'], Exec['set-licence-seen']],
  }
}
