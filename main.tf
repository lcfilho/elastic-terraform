provider "google" {
 credentials = file("~/Documentos/terraform-elastic/terraform-cloud-282518-a832d5d911bb.json")
 project     = "terraform-cloud-282518"
 region      = "us-east4-c"
}

resource "google_compute_instance" "ece-01" {
 name         = "elastic-01"
 machine_type = "n1-standard-2"
 zone         = "us-east4-a"
 hostname     = "elastic-01.srv"

 boot_disk {
   initialize_params {
     image = "centos-cloud/centos-7"
     size  = "30"
   }
 }

 network_interface {
   network    = "default"
   network_ip = "10.150.0.10"
   access_config {
   
   }
 }
 metadata = {
   ssh-keys = "luisfilho:${file("/home/luisfilho/.ssh/id_rsa.pub")}"
 }
}

resource "google_compute_instance" "ece-02" {
 name         = "elastic-02"
 machine_type = "n1-standard-2"
 zone         = "us-east4-b"
 hostname     = "elastic-02.srv"

 boot_disk {
   initialize_params {
     image = "centos-cloud/centos-7"
     size  = "30"
   }
 }

 network_interface {
   network    = "default"
   network_ip = "10.150.0.11"
   access_config {     
   }
 }
 metadata = {
   ssh-keys = "luisfilho:${file("/home/luisfilho/.ssh/id_rsa.pub")}"
 }
}

resource "google_compute_instance" "ece-03" {
 name         = "elastic-03"
 machine_type = "n1-standard-2"
 zone         = "us-east4-c"
 hostname     = "elastic-03.srv"

 boot_disk {
   initialize_params {
     image = "centos-cloud/centos-7"
     size  = "30"
   }
 }

 network_interface {
   network    = "default"
   network_ip = "10.150.0.12"
   access_config {     
   }
 }
 metadata = {
   ssh-keys = "luisfilho:${file("/home/luisfilho/.ssh/id_rsa.pub")}"
 }
}

resource "null_resource" "hosts" {
 triggers = {
   anything1 = google_compute_instance.ece-01.network_interface.0.access_config.0.nat_ip
   anything2 = google_compute_instance.ece-02.network_interface.0.access_config.0.nat_ip
   anything3 = google_compute_instance.ece-03.network_interface.0.access_config.0.nat_ip
 }
 provisioner "remote-exec" {
   connection {
     type = "ssh"
     user = "luisfilho"
     host = google_compute_instance.ece-01.network_interface.0.access_config.0.nat_ip
     private_key = file("/home/luisfilho/.ssh/id_rsa")
   }
   inline = [
     "echo OK",

   ]
 }
 provisioner "remote-exec" {
   connection {
     type = "ssh"
     user = "luisfilho"
     host = google_compute_instance.ece-02.network_interface.0.access_config.0.nat_ip
     private_key = file("/home/luisfilho/.ssh/id_rsa")
   }
   inline = [
     "echo OK",
   ]
 }
 provisioner "remote-exec" {
   connection {
     type = "ssh"
     user = "luisfilho"
     host = google_compute_instance.ece-03.network_interface.0.access_config.0.nat_ip
     private_key = file("/home/luisfilho/.ssh/id_rsa")
   }
   inline = [
     "echo OK",
   ]
 }
 provisioner "remote-exec" {
   connection {
     type = "ssh"
     user = "luisfilho"
     host = "35.229.60.50"
     private_key = file("/home/luisfilho/.ssh/id_rsa")
   }   
   inline = [
     "cd /home/luisfilho/elastic-terraform/ansible",
     "ansible-playbook -i hosts elastic.yml",
     "ansible-playbook -i elastic-01 docker.yml",
   ]
 }
}
