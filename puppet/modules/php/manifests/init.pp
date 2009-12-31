class php {
    package { "php5": ensure => installed }
    package { "php5-cgi": ensure => installed }
    package { "php5-mysql": ensure => installed }
    package { "php-pear": ensure => installed }
    package { "xsltproc": ensure => installed }
    package { "php5-xsl": ensure => installed }
    package { "libapache2-mod-php5": ensure => installed, require => Class['apache'] }
}

class php-dev {
    include php
    include pear::phpunit
    include pear::phing
}

class pear {
    include php

    class phpunit {
        channelinstall{"phpunit": channel => 'pear.phpunit.de', name => 'phpunit/PHPUnit'}
    }

    class phing {
        channelinstall{"phing/phing": channel => 'pear.phing.info'}
    }

    class upgrade_all {
        $channels = 'pear.php.net'
        channel_update {$channels:}
        upgrade {"": require => Channel_update[$channels]}
    }

    define channelinstall($channel, $update = false) {
        if ($update) {
            include "upgrade_all"
            channel_discover {$channel: require => Class['upgrade_all'] }
        } else {
            channel_discover {$channel: }
        }
        install {$name: require => Channel_discover[$channel]}
    }

    define upgrade() {
        pear_exe {"upgrade $name":}
    }

    define install() {
        pear_exe {"install $name": unless => "pear list $name"}
    }

    define pear_exe($unless = 1) {
        include php
        exec {"pear_$title":
            command => "pear $name",
            unless => $unless
        }
    }

    define channel_update() {
        pear_exe {"channel-update $name":}
    }

    define channel_discover() {
        pear_exe {"channel-discover $name":
            unless => "pear channel-info $name"
        }
    }

}


