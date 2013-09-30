puppet_known_hosts
==================
A puppet module for managing a set of hosts

usage
-----
```ruby
class { 'known_hosts':
  domain_name => 'stinko.com',
  hosts       => [
    {'name' => 'machine1', 'ip' => '10.10.10.1'},
    {'name' => 'machine2', 'ip' => '10.10.10.2'}
  ]
}
```