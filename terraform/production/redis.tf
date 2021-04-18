resource "google_compute_instance" "redis-coreapp" {
  name                      = "redis-coreapp"
  machine_type              = "custom-4-20480"
  allow_stopping_for_update = true
  tags                      = ["redis", "nat-this", "block-to-local", "block-from-local", "allow-redis-from-k8s", "sentinel"]
  deletion_protection       = true

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
      size  = "20"
    }
  }

  network_interface {
    subnetwork = "prod-data"
  }
}

resource "google_compute_instance" "redis-ratelimiter" {
  name         = "redis-ratelimiter"
  machine_type = "custom-2-10240"

  tags                      = ["redis", "nat-this", "block-to-local", "block-from-local", "allow-redis-from-k8s", "sentinel"]
  deletion_protection       = true
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
      size  = "20"
    }
  }

  network_interface {
    subnetwork = "prod-data"
  }
}

resource "google_compute_instance" "redis-sidekiq" {
  name         = "redis-sidekiq"
  machine_type = "custom-2-10240"

  tags                      = ["redis", "nat-this", "block-to-local", "block-from-local", "allow-redis-from-k8s", "sentinel"]
  deletion_protection       = true
  allow_stopping_for_update = true
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
      size  = "20"
    }
  }

  network_interface {
    subnetwork = "prod-data"
  }
}
