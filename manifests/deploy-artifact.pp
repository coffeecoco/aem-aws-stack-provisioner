File {
  backup => false,
}

class deploy_artifact (
  $package_source    = $::package_source,
  $package_group     = $::package_group,
  $package_name      = $::package_name,
  $package_version   = $::package_version,
  $package_replicate = $::package_replicate,
  $package_activate  = $::package_activate,
  $package_force     = $::package_force,
  $package_aem_id    = $::package_aem_id,
  $path              = '/tmp/shinesolutions/aem-aws-stack-provisioner/',
) {

  file { "${path}/${package_aem_id}/${package_group}/${package_name}-${package_version}.zip":
    ensure => absent,
  } -> archive { "${path}/${package_aem_id}/${package_group}/${package_name}-${package_version}.zip":
    ensure => present,
    source => "${package_source}",
  } -> aem_package { "Deploy package ${package_group}/${package_name}-${package_version}":
    ensure    => present,
    name      => $package_name,
    group     => $package_group,
    version   => $package_version,
    path      => "${path}/${package_aem_id}/${package_group}",
    replicate => $package_replicate,
    activate  => $package_activate,
    force     => $package_force,
    aem_id    => $package_aem_id,
  }

}

include deploy_artifact
