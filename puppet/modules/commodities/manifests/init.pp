class commodities {
    package { "xclip": ensure => installed }
    package { "emacs": ensure => installed }
    package { "gftp": ensure => installed }
    package { "nautilus-open-terminal": ensure => installed }
    package { "bzr": ensure => installed }
    package { "python-xlib": ensure => installed }
    package { "gedit-plugins": ensure => installed }
    package { "libssl0.9.8": ensure => installed }

    class keymon {
        file { "/opt/keymon":
            ensure => "directory"
        }

        file { "keymon.deb":
            path => "/opt/keymon/keymon_1.4.3-1_all.deb",
            require => File["/opt/keymon"],
            owner   => root,
            group   => root,
            mode    => 644,
            ensure  => present,
            source  => "puppet:///modules/commodities/keymon_1.4.3-1_all.deb"
        }

        package { "keymon":
            require => [File["keymon.deb"], Package["python-xlib"]],
            provider => dpkg,
            ensure => installed,
            source => "/opt/keymon/keymon_1.4.3-1_all.deb"
        }
    }


    class screenkey {
        file { "/opt/screenkey":
            ensure => "directory"
        }

        file { "screenkey.deb":
            path => "/opt/screenkey/screenkey_0.2_all.deb",
            require => File["/opt/screenkey"],
            owner   => root,
            group   => root,
            mode    => 644,
            ensure  => present,
            source  => "puppet:///modules/commodities/screenkey_0.2_all.deb"
        }

        package { "screenkey":
            require => [File["screenkey.deb"], Package["python-xlib"]],
            provider => dpkg,
            ensure => installed,
            source => "/opt/screenkey/screenkey_0.2_all.deb"
        }
    }
}


