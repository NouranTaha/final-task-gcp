resource "google_service_account" "main-acc" {
  account_id   = "vm-account"
  display_name = "vm-private-acc"
}

resource "google_project_iam_binding" "vm-project" {
  project = "final-task-gcp"
  role    = "roles/container.admin"

  members = [
    "serviceAccount:${google_service_account.main-acc.email}"
  ]
}



resource "google_compute_instance" "private-vm" {
  name         = "private-vm"
  machine_type = "e2-micro"
  zone         = "europe-west1-b"
  

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
      size = 10
      type = "pd-balanced"
    }
  }

  network_interface {
    network = google_compute_network.main.id
    subnetwork = google_compute_subnetwork.subnet1.id
  }

  service_account {
    email  = google_service_account.main-acc.email
    scopes = ["cloud-platform"]
  }
}
  


