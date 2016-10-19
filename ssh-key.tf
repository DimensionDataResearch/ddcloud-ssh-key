variable "host_ip"  { }
variable "username" { default = "root" }
variable "password" { }
variable "ssh_key"  { }

resource "null_resource" "install_ssh_key" {
	# Install our SSH public key.
	provisioner "remote-exec" {
		inline = [
			"mkdir -p ~/.ssh",
			"chmod 700 ~/.ssh",
			"echo '${var.ssh_key}' > ~/.ssh/authorized_keys",
			"chmod 600 ~/.ssh/authorized_keys"
		]

		connection {
			type 		= "ssh"
			
			user 		= "${var.username}"
			password 	= "${var.password}"

			host 		= "${var.host_ip}"
		}
	}
}
