import 'site'

node default inherits 'developernode' {
    include php-dev
    include monodevelop
    include python
    include hudson
    include ruby
    include pear::php_archive
}
