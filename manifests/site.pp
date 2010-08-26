# /etc/puppet/manifests/site.pp
import "defaults.pp"
import "modules.pp"

node default {
        include puppet::client
        include screen
}

node 'shoemaker.local' inherits default {
        include cobbler::full
        include cobbler::centos
	sysctl::conf { "net.ipv4.ip_forward":  value => "1" }
	cobbler::system { "node01": ip => "10.0.0.201", mac => "aa:aa:bb:bb:ff:01" }
	cobbler::system { "node02": ip => "10.0.0.202", mac => "aa:aa:bb:bb:ff:02" }
	cobbler::system { "node03": ip => "10.0.0.203", mac => "aa:aa:bb:bb:ff:03" }
	cobbler::system { "cobbler2": ip => "10.0.0.204", mac => "aa:aa:bb:bb:ff:04" }
	cobbler::system { "zcore301": ip => "10.0.0.205", mac => "aa:aa:bb:bb:ff:05" }
}

node 'cobbler2' inherits default {
        include cobbler::full
        include cobbler::centos
	sysctl::conf { "net.ipv4.ip_forward":  value => "1" }
	cobbler::system { "node01": ip => "10.0.0.201", mac => "aa:aa:bb:bb:ff:01" }
}

node 'zcore301' inherits default {
        include zenoss::core::301
}
