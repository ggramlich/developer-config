class git {
    package { "git": ensure => installed }
    package { "git-gui": ensure => installed }
    package { "gitg": ensure => installed }
    package { "git-svn": ensure => installed }
    # see http://batterypowered.wordpress.com/2008/07/04/deploying-a-git-repository-server-in-ubuntu/
    package { "git-daemon-run": ensure => absent }
    
    user {"git":
        ensure => present
    }
    
    file {"git-daemon":
        path => "/etc/init.d/git-daemon",
        source => "puppet:///modules/git/git-daemon",
        owner => "root",
        group => "root",
        mode => 0744,
        require => Package["git"]
    }

    service {"git-daemon":
        ensure => running,
        require => [File["git-daemon"]],
    }
}

