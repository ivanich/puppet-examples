node "puppetclient.local" {
include apache 
apache::vhost { 'www.lohika.com':
        port => 80,
        docroot => '/var/www/www.lohika.com',
        ssl => false,
        serveralias => 'home.lohika.com',
	}
}


node "node1.local" {
        include ssh, nginx

nginx::vhost { 'testhost':
        docroot => '/usr/share/nginx/html',
        port => 80,
        server_names => ['localhost'],
        group_name => 'tomcat_servers',
 }
nginx::lb { 'tomcat_servers':
        group_name => 'tomcat_servers',
        node_names => ['192.168.8.11:8080', '192.168.8.12:8080'],
         }
}


node "node2.local" {
        include ssh, java, tomcat


$users = {
  u1 => { username => 'admin', password => 'testpass', roles => 'manager,admin,manager-gui,manager-script' },
}
tomcat::users { 'default':
        users => $users,
   }
}


node "node3.local" {
        include ssh, java, tomcat


$users = {
  u1 => { username => 'admin', password => 'testpass', roles => 'manager,admin,manager-gui,manager-script' },
}
tomcat::users { 'default':
        users => $users,
   }

}


