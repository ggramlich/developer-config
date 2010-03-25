class monodevelop {
    package { "mono-devel": ensure => installed }
    package { "monodevelop": ensure => installed }
    package { "mono-utils": ensure => installed }
    package { "mono-complete": ensure => installed }
    package { "monodoc-browser": ensure => installed }
    package { "monodoc-http": ensure => installed }
    package { "nant": ensure => installed }
    package { "nunit": ensure => installed }
    package { "nunit-gui": ensure => installed }
    package { "nunit-console": ensure => installed }
    package { "monodevelop-nunit": ensure => installed }
}

