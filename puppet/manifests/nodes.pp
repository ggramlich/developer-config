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
}
