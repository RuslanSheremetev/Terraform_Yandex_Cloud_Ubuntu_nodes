 data "yandex_compute_image" "ubuntu_image" {
  family = "ubuntu-2204-lts"
}
 
resource "yandex_compute_instance" "k8s_master" {
  name                      = "master"

 
  resources {
    cores  = 2
    memory = 2
  }
 
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_image.id
    }
  }
 
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_terraform.id
    nat       = true
  }
    metadata = {
    user-data = "${file("./meta.yml")}"
  }
 
}
 
resource "yandex_compute_instance" "K8s2_worker" {
  name                      = "worker1"
  allow_stopping_for_update = true
 
  resources {
    cores  = 2
    memory = 2
  }
 
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_image.id
    }
  }
 
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_terraform.id
    nat       = true
  }
    metadata = {
    user-data = "${file("./meta.yml")}"
  }
 
}
 
 resource "yandex_compute_instance" "K8s_worker2" {
  name                      = "worker2"
  allow_stopping_for_update = true
 
  resources {
    cores  = 2
    memory = 2
  }
 
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_image.id
    }
  }
 
    network_interface {
    subnet_id = yandex_vpc_subnet.subnet_terraform.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
  }
 
}
resource "yandex_vpc_network" "network_terraform" {
  name = "network_terraform"
}

resource "yandex_vpc_subnet" "subnet_terraform" {
  name           = "sub_terraform"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network_terraform.id
  v4_cidr_blocks = ["192.168.16.0/24"]
}