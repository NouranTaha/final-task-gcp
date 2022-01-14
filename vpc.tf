resource "google_compute_network" "main" {
  name                    = "python-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet1" {
  name          = "management-subnet"
  ip_cidr_range = "10.1.0.0/16"
  network       = google_compute_network.main.id
  region        = "europe-west1"  
}

resource "google_compute_subnetwork" "subnet2" {
  name          = "restricted-subnet"
  ip_cidr_range = "10.2.0.0/16"
  network       = google_compute_network.main.id
  region        = "europe-west1"  
  
}
