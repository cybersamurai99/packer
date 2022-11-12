packer {
  required_plugins {
    virtualbox = {
      version = ">= 0.0.1"
      source = "github.com/hashicorp/virtualbox"
    }
  }
}

locals {
  timestamp = formatdate("YYYY-MM", timestamp())
}

source "virtualbox-iso" "basic-example" {
  guest_os_type = "Ubuntu_64"
  iso_url = "ubuntu-22.04.1-live-server-amd64.iso"
  iso_checksum = "md5:E8D2A77C51B599C10651608A5D8C286F"
  ssh_username = "ubuntu"
  ssh_password = "ubuntu"
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"
  ssh_clear_authorized_keys = "true"
  ssh_timeout = "20m"
  memory = "2048"
  boot_wait = "5s"
  boot_command = [
    "<esc><esc><esc><esc>e<wait>",
    "<del><del><del><del><del><del><del><del>",
    "<del><del><del><del><del><del><del><del>",
    "<del><del><del><del><del><del><del><del>",
    "<del><del><del><del><del><del><del><del>",
    "<del><del><del><del><del><del><del><del>",
    "<del><del><del><del><del><del><del><del>",
    "<del><del><del><del><del><del><del><del>",
    "<del><del><del><del><del><del><del><del>",
    "<del><del><del><del><del><del><del><del>",
    "<del><del><del><del><del><del><del><del>",
    "<del><del><del><del><del><del><del><del>",
    "<del><del><del><del><del><del><del><del>",
    "<del><del><del><del><del><del><del><del>",
    "<del><del><del><del><del><del><del><del>",
    "linux /casper/vmlinuz --- autoinstall ds=\"nocloud-net;seedfrom=http://{{ .HTTPIP }}:{{ .HTTPPort }}/\"<enter><wait>",
    "initrd /casper/initrd<enter><wait>",
    "boot<enter>",
    "<enter><f10><wait>"
    ]

  http_directory = "./http"

}

build {
  sources = ["sources.virtualbox-iso.basic-example"]
  provisioner "shell" {
    #inline = ["echo hello"]
    scripts = ["scripts/setup_ubuntu2004.sh"]
  }
}