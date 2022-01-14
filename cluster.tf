
resource "google_container_cluster" "cluster-1" {
  name       = "cluster-1"
  location   = "europe-west1"
  network    = google_compute_network.main.id
  subnetwork = google_compute_subnetwork.subnet2.id
  
  private_cluster_config {
    master_ipv4_cidr_block  = "172.16.0.0/28"
    enable_private_nodes    = true
    enable_private_endpoint = true
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block = "10.1.0.0/16"
    }
  }
  ip_allocation_policy {
    cluster_ipv4_cidr_block  = "/21"
    services_ipv4_cidr_block = "/21"
  }

  remove_default_node_pool = true
  initial_node_count       = 1
}



resource "google_container_node_pool" "cluster-nodes" {
  name       = "worker-node"
  location   = "europe-west1""
  cluster    = google_container_cluster.cluster-1.name
  node_count = 1

  node_config {
    preemptible  = false
    machine_type = "e2-micro"

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.main-acc.email
    oauth_scopes = [
    ]
  }
}
