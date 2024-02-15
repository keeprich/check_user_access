Vagrant.configure("2") do |config|
  # Master server configuration
  config.vm.define "worker4" do |worker4|
    worker4.vm.box = "centos/7"
    worker4.vm.network "private_network", ip: "192.168.50.14"

    # Configure SSH
    worker4.vm.provision "shell", inline: <<-SHELL
      sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
      sudo systemctl restart sshd
    SHELL
  end

  # Worker server configuration
  config.vm.define "worker5" do |worker5|
    worker5.vm.box = "centos/7"
    worker5.vm.network "private_network", ip: "192.168.50.15"

    # Configure SSH
    worker5.vm.provision "shell", inline: <<-SHELL
      sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
      sudo systemctl restart sshd
    SHELL
  end
end
