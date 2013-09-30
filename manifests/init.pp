#
# == Class: known_hosts
#
# === Actions
#  - Adds hosts resources for each host in an array of host hashes
#
# == Example
#
# class { 'known_hosts':
#  domain_name => 'evilclowns.org',
#  hosts => [
#    { name => 'machine1', ip => '10.10.10.1'},
#    { name => 'machine2', ip => '10.10.10.2'}
#  ]
# }
#
#
class known_hosts(
  $domain_name,
  $hosts
) {
  validate_string($domain_name)
  validate_array($hosts)

  each($hosts) |$host_hash| {
    host { $host_hash['name']:
      ensure       => present,
      ip           => $host_hash['ip'],
      host_aliases => ["${host_hash['name']}.${domain_name}"]
    }
  }
}
