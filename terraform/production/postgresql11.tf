resource "google_compute_disk" "postgres11-primary-data" {
  name = "${var.env}-postgres11-primary-data"
  type = "pd-ssd"
  size = "1000"
}

resource "google_compute_disk" "postgres11-primary-wal" {
  name = "${var.env}-postgres11-primary-wal"
  type = "pd-ssd"
  size = "350"
}

resource "google_compute_disk" "postgres11-replica1-data" {
  name = "${var.env}-postgres11-replica1-data"
  type = "pd-ssd"
  size = "1000"
}

resource "google_compute_disk" "postgres11-replica1-wal" {
  name = "${var.env}-postgres11-replica1-wal"
  type = "pd-ssd"
  size = "50"
}

resource "google_compute_disk" "postgres11-replica2-data" {
  name = "${var.env}-postgres11-replica2-data"
  type = "pd-ssd"
  size = "1000"
}

resource "google_compute_disk" "postgres11-replica2-wal" {
  name = "${var.env}-postgres11-replica2-wal"
  type = "pd-ssd"
  size = "50"
}

resource "google_compute_instance" "postgres11-primary" {
  name                = "${var.env}-postgres11-primary"
  deletion_protection = true
  machine_type        = "custom-44-102400"

  tags = ["nat-this", "postgres", "pg11", "block-to-local", "block-from-local", "allow-to-postgres", "allow-postgres-from-k8s", "allow-pg-from-jenkins"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
      size  = "40"
    }
  }

  network_interface {
    subnetwork = "prod-data"
  }

  attached_disk {
    source = google_compute_disk.postgres11-primary-data.self_link
  }
  attached_disk {
    source = google_compute_disk.postgres11-primary-wal.self_link
  }
  service_account {
    email  = "64815801080-compute@developer.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
  allow_stopping_for_update = true
}

resource "google_compute_instance" "postgres11-replica1" {
  name                = "${var.env}-postgres11-replica1"
  deletion_protection = true
  machine_type        = "custom-44-102400"

  tags = ["nat-this", "postgres", "pg11", "block-to-local", "block-from-local", "allow-to-postgres", "allow-postgres-from-k8s"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
      size  = "40"
    }
  }

  network_interface {
    subnetwork = "prod-data"
  }

  attached_disk {
    source = google_compute_disk.postgres11-replica1-data.self_link
  }
  attached_disk {
    source = google_compute_disk.postgres11-replica1-wal.self_link
  }
  service_account {
    email  = "64815801080-compute@developer.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
  allow_stopping_for_update = true
}

resource "google_compute_instance" "postgres11-replica2" {
  name                = "${var.env}-postgres11-replica2"
  deletion_protection = true
  machine_type        = "custom-44-102400"

  tags = ["nat-this", "postgres", "pg11", "block-to-local", "block-from-local", "allow-to-postgres", "allow-postgres-from-k8s"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
      size  = "40"
    }
  }

  network_interface {
    subnetwork = "prod-data"
  }

  attached_disk {
    source = google_compute_disk.postgres11-replica2-data.self_link
  }
  attached_disk {
    source = google_compute_disk.postgres11-replica2-wal.self_link
  }
  service_account {
    email  = "64815801080-compute@developer.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
  allow_stopping_for_update = true
}
