class php {
    package { "php5": ensure => installed }
    package { "php5-cgi": ensure => installed }
    package { "php5-mysql": ensure => installed }
    package { "php-pear": ensure => latest }
    package { "xsltproc": ensure => installed }
    package { "php5-xsl": ensure => installed }
    package { "php5-curl": ensure => installed }
    package { "libapache2-mod-php5": ensure => installed, require => Class['apache'] }
    package { "php5-dev": ensure => installed }
    package { "php5-sqlite": ensure => installed, require => Class['sqlite'] }
    package { "php5-pgsql": ensure => installed, require => Class['postgresql'] }
}

class php-dev inherits php {
    package { 'php5-xdebug': ensure => installed }
    include pear::phpunit
    include pear::phing
    include pear::phpcs
    include pear::phpmd
    include pear::phpcpd
    include pear::mdb2
    include pear::vfsStream
}

class pear {
    class phpunit {
        channel_discover{"pear.symfony-project.com":}
        channel_discover{"components.ez.no":}
        channelinstall{"phpunit": channel => 'pear.phpunit.de',
            update => true,
            name => 'phpunit/PHPUnit',
            require => [Channel_discover["pear.symfony-project.com", "components.ez.no"]]
        }
    }

    class phing {
        channelinstall{"phing/phing": channel => 'pear.phing.info'}
    }

    class phpcs {
        install {"PHP_CodeSniffer":}
    }

    class phpmd {
        channel_discover{"pear.pdepend.org":}
        channelinstall{"phpmd": channel => 'pear.phpmd.org',
            name => 'phpmd/PHP_PMD-alpha',
            alldeps => true,
            require => Channel_discover['pear.pdepend.org']
        }
    }

    class phpcpd {
        install {"phpcpd": name => 'phpunit/phpcpd',
            require => Class['phpunit']
        }
    }

    class php_archive {
        install {"PHP_Archive-alpha":}
    }

    class mdb2 {
        install {"MDB2_Driver_mysql": require => Package["mysql-client"]}
    }
    
    class vfsStream {
        channelinstall{"pat/vfsStream-alpha": channel => 'pear.php-tools.net'}
    }

    define upgrade_all($unless = "false") {
        $channels = 'pear.php.net'
        channel_update {$channels: unless => $unless}
        pear_exe {"upgrade-all": require => Channel_update[$channels], unless => $unless}
    }

    define channelinstall($channel, $update = false, $alldeps = false) {
        if ($update) {
            upgrade_all {'all': unless => "pear list $name"}
            channel_discover {$channel: require => Upgrade_all['all'] }
        } else {
            channel_discover {$channel: }
        }
        install {$name: require => Channel_discover[$channel], alldeps => $alldeps}
    }

    define upgrade() {
        pear_exe {"upgrade $name":}
    }

    define install($alldeps = false) {
        if ($alldeps) {
            pear_exe {"install --alldeps $name": unless => "pear list $name"}
        } else {
            pear_exe {"install $name": unless => "pear list $name"}
        }
    }

    define pear_exe($unless = "false") {
        exec {"pear_$title":
            command => "pear $name",
            unless => $unless,
            require => Class['php']
        }
    }

    define channel_update($unless = "false") {
        pear_exe {"channel-update $name": unless => $unless}
    }

    define channel_discover() {
        pear_exe {"channel-discover $name":
            unless => "pear channel-info $name"
        }
    }

}

class pecl {
    define install() {
        pecl_exe {"install $name": unless => "pecl list $name"}
    }

    define pecl_exe($unless = 1) {
        exec {"pecl_$title":
            command => "pecl $name",
            unless => $unless,
            require => Class['php']
        }
    }

    class phar {
        package {"libpcre3-dev": ensure => installed}
        install {"phar":}
    }

}

