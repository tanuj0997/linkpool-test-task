resource "google_compute_instance" "redis-sentinel-1" {
  name         = "${var.name}-sentinel-1"
  machine_type = var.machine_type

  tags = ["redis", "nat-this", "block-to-local", "block-from-local", "allow-redis-from-k8s", "sentinel"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-8"
      size  = "30"
    }
  }

  network_interface {
    subnetwork = var.subnetwork
  }
}

resource "google_compute_instance" "redis-sentinel-2" {
  name         = "${var.name}-sentinel-2"
  machine_type = var.machine_type

  tags = ["redis", "nat-this", "block-to-local", "block-from-local", "allow-redis-from-k8s", "sentinel"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-8"
      size  = "30"
    }
  }

  network_interface {
    subnetwork = var.subnetwork
  }
}

resource "google_compute_instance" "redis-sentinel-3" {
  name         = "${var.name}-sentinel-3"
  machine_type = var.machine_type

  tags = ["redis", "nat-this", "block-to-local", "block-from-local", "allow-redis-from-k8s", "sentinel"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-8"
      size  = "30"
    }
  }

  network_interface {
    subnetwork = var.subnetwork
  }
}
