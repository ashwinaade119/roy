#Provider for authentication
provider "aws" {
    region = "ap-south-1"
}


# resource block for server creation
resource "aws_instance" "server_1" {
     ami = "ami-0ad21ae1d0696ad58"
     instance_type = "t2.micro"
     key_name = "hybrid"
     tags = {
        name = "stagint-jordan"
        project = "jordan company"
        enviorment = "production"
        owner = "jarvis"
     }
#provisioner use-case
    connection {
        type = "ssh"
        user = "ubuntu"
        private_key = file("${path.module}/hybrid")
        host = "${self.public_ip}"
    }

# File provisioner
    provisioner "file" {
        source = "jarvis.txt"
        destination = "/home/ubuntu/jarvis.txt"
    }

    provisioner "file" {
        content = "here we can add our content or script or commands, it will paste in our destination file"
        destination = "/home/ubuntu/provisioner_content.txt"
    }

# Local-exec provisioner
    provisioner "local-exec" {
        command = "echo ${self.public_ip} > /home/ubuntu/server_ip.txt"
    }    

    provisioner "local-exec" {
        working_dir = "/media/"
        command = "echo ${self.public_ip} > jarvis.txt"
    }

#Install python3 in local m/c
    provisioner "local-exec" {
        interpreter = [
            "/usr/bin/python3", "-c"
        ]
        command = "print ('Hello jarvis')"
    }

# Remote-provisioner
    provisioner "remote-exec" {
        inline = [
            "ifconfig > /tmp/myipadress_configuration.output",
            "echo 'hello developers'>/tmp/dev.txt"
        ]
    }
    provisioner "remote-exec" {
        script = "./script_demo.sh"
    }

}




