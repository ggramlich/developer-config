class hudson {
    $hudsonKeyFile = "/opt/hudson/hudson-ci.org.key"

    file {"hudson-dir":
        path => "/opt/hudson",
        ensure => "directory"
    }

    file {"hudson-key-file":
        path => $hudsonKeyFile,
        source => 'puppet:///modules/hudson/hudson-ci.org.key',
        require => File["hudson-dir"]
    }

    exec {"apt-key add $hudsonKeyFile":
        refreshonly => true,
        subscribe => File["hudson-key-file"],
        require => File["hudson-key-file"],
    }

    file {"/etc/apt/sources.list":
        owner => "root",
        group => "root",
        mode => 0444,
        content => template("hudson/sources.list.erb"),
        require => File["hudson-key-file"]
    }

    exec {"apt-get update":
        refreshonly => true,
        subscribe => File["/etc/apt/sources.list"],
        require => File["/etc/apt/sources.list"],
    }

    package { "hudson":
        ensure => latest,
        require => File["/etc/apt/sources.list"],
    }

    file {"hudson.conf":
        path => "/etc/default/hudson",
        source => "puppet:///modules/hudson/hudson.conf",
        owner => "root",
        group => "root",
        mode => 0644,
        require => Package["hudson"]
    }

    class plugins {
        define install_plugin() {
            file {"hudson-plugin $name":
                path => "/var/lib/hudson/plugins/$name.hpi",
                source => "puppet:///modules/hudson/plugins/$name.hpi",
	            owner => "hudson",
	            group => "adm",
                mode => 0750,
                require => Package["hudson"]
            }
        }

        install_plugin{["deploy", "jabber", "instant-messaging", "bazaar", "git", "copyartifact"]:}
    }

    include plugins

    service {"hudson":
        ensure => running,
        subscribe => [File["hudson.conf"], Class["plugins"]],
    }

}

