class ssh::params {
	case $operatingsystem {
		/(Ubuntu|Debian)/: {
			$ssh_package_name = 'openssh-server'
			$ssh_service_name = "ssh"
		}
		/(RehHat|CenOS|Fedora)/: {
			$ssh_package_name = 'openssh-server'
			$ssh_service_name = "sshd"
		}
	}
}
			
