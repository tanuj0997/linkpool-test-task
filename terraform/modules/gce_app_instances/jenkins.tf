resource "google_compute_instance" "jenkins" {
  name         = "jenkins"
  machine_type = "n1-standard-1"

  tags = ["nat-this"]

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-8"
      size  = "20"
    }
  }

  network_interface {
    subnetwork = var.app_subnetwork
  }
}
