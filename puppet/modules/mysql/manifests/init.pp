class mysqldev {
    package { "mysql-client": ensure => installed }
    package { "mysql-server": ensure => installed }
    package { "mysql-admin": ensure => installed }
    package { "mysql-query-browser": ensure => installed }
}

class mysql {
    define create_database($user = 'root', $charset = 'utf8') {
        exec {"create_database_$name":
            unless => "mysql -u$user $name -e';'",
            command => "mysql -u$user -e'create database $name charset $charset'",
            require => Class['mysqldev']
        }
    }

    define flush_privileges($user = 'root') {
        exec {"flush_privileges":
            command => "mysql -u$user -e'flush privileges'",
            require => Class['mysqldev']
        }
    }
}

