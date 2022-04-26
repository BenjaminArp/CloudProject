# ------------------------------------------------------------------------------
# Terraform example :  Openstack Instance + node.js installation
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# Define required providers
# ------------------------------------------------------------------------------
terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.46.0"
    }
  }
}
# ------------------------------------------------------------------------------
# Configure the OpenStack Provider
# ------------------------------------------------------------------------------
provider "openstack" {
  cloud = "openstack"
}
# Create a web server
resource "openstack_compute_instance_v2" "nodejsServer" {
  name            = "DiscordTranslationBot"
  image_id        = "2e170e26-3749-4326-b716-437379c9ba93"
  flavor_name       = "m1.small"
  key_pair        = "sshKeyCloudComputing"
  security_groups = ["default"]

  metadata = {
    this = "it worked, that is wonderful"
  }
  network {
  name = "public-belwue"
}
}
# ------------------------------------------------------------------------------
# Der Rest wird nun mit der etwas einfachen SSH Null Resource gemacht
# ------------------------------------------------------------------------------
resource "null_resource" "softwareconfig" {
  connection {
    type = "ssh"
    host = openstack_compute_instance_v2.nodejsServer.access_ip_v4
    user = "ubuntu"
    port = 22
    private_key = file("C:\\Users\\benny\\Documents\\sshKeyCloudComputing.pem")
  }
  # ----------------------------------------------------------------------------
  # wir definieren einen Arbeitsfolder   ...
  # ----------------------------------------------------------------------------
  provisioner "remote-exec" {
       inline = [
      "rm -r work",
      "mkdir work",
      "chmod ugo+rwx work",
      "cd work",
    ]
   }
   # ---------------------------------------------------------------------------
   # hier copeieren wir unseren eigene JavaScript App oder halt die mitgelieferte
   # tinyNodejsApp
   # ----------------------------------------------------------------------------
   provisioner "file" {
   source      = "D://gitProjects//CloudProject//DiscordBot//"
   destination = "/home/ubuntu/work/discord-bot"
   }
}
# ------------------------------------------------------------------------------
# Viel Glück
# ------------------------------------------------------------------------------
