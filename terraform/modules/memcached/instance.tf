resource "google_compute_instance" "memcached" {
  name         = "memcached"
  machine_type = var.memcached_instance_machine_type
  tags         = ["nat-this", "allow-memcached-from-k8s", "block-from-local", "block-to-local"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-8"
      size  = 20
    }
  }

  network_interface {
    subnetwork = var.data_subnetwork
  }

  service_account {
    email  = var.service_account
    scopes = ["cloud-platform"]
  }

  allow_stopping_for_update = true
}
