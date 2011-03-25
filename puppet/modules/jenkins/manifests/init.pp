class jenkins {
    $jenkinsKeyFile = "/opt/jenkins/jenkins-ci.org.key"
    $httpPort = 8999

    include "add_source"
    include "set_port"

    define line($file, $line) {
        exec {
            "echo '${line}' >> '${file}'":
             unless => "grep -qFx '${line}' '${file}'"
        }
    }

    define shell_config($file, $key, $value) {
        exec {
          "shell_config_update_$ensure '$file$key'":
            unless => "grep -qE '^[ \t]*$key=$value' -- $file",
            command => "sed -i -e 's/$key=.*/$key=$value/' $file";
        }
    }

    file {"jenkins-dir":
        path => "/opt/jenkins",
        ensure => "directory"
    }

    file {"jenkins-key-file":
        path => $jenkinsKeyFile,
        source => 'puppet:///modules/jenkins/jenkins-ci.org.key',
        require => File["jenkins-dir"]
    }

    exec {"apt-key add $jenkinsKeyFile":
        refreshonly => true,
        subscribe => File["jenkins-key-file"],
        require => File["jenkins-key-file"],
    }

    class add_source {
        line {"jenkinssource":
            line => 'deb http://pkg.jenkins-ci.org/debian binary/',
            file => '/etc/apt/sources.list',
            require => Exec["apt-key add $jenkinsKeyFile"]
        }
    }

    exec {"apt-get update":
        refreshonly => true,
        subscribe => Class['add_source'],
        require => Class['add_source'],
    }

    class set_port {
        shell_config {'httpport':
            file => '/etc/default/jenkins',
            key => 'HTTP_PORT',
            value => $httpPort,
            require => Package['jenkins']
        }
    }

    package { "jenkins":
        ensure => latest,
        require => [Exec['apt-get update']]
    }

    service {"jenkins":
        ensure => running,
        subscribe => [Class["set_port"]],
        require => [Class["set_port"]]
    }

}

