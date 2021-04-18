variable "data_subnetwork" {
  type        = string
  description = "Subnetwork for data"
}

variable "memcached_instance_machine_type" {
  type        = string
  description = "type of machine for memcached"
}

variable "service_account" {
  type        = string
  description = "GCE service account"
}
