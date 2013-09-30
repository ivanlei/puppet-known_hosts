require stdlib

class { 'known_hosts':
  domain_name => 'evilclowns.org',
  hosts       => [
    {
      name => 'machine1',
      ip   => '10.10.10.1' },
    {
      name => 'machine2',
      ip   => '10.10.10.2'}]
}
