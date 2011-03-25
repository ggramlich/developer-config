node 'basenode' {
    include git
    include subversion
    Exec { path => "/usr/sbin:/usr/bin:/sbin:/bin" }
    include vmwaretools
    include virtualboxtools
}

node 'developernode' inherits 'basenode' {
    include jdk
    include apache
    include mysqldev
    include php
    include subversion-tools
    include commodities
    include mercurial
    include sqlite
    include postgresql
}

node multilingualdev inherits 'developernode' {
    include php-dev
    include monodevelop
    include python
    include ruby
    include pear::php_archive
    include commodities::keymon
    include commodities::screenkey
}

