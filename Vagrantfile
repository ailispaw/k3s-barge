# A dummy plugin for Barge to set hostname and network correctly at the very first `vagrant up`
module VagrantPlugins
  module GuestLinux
    class Plugin < Vagrant.plugin("2")
      guest_capability("linux", "change_host_name") { Cap::ChangeHostName }
      guest_capability("linux", "configure_networks") { Cap::ConfigureNetworks }
    end
  end
end

K3S_VERSION  = "v0.1.0"

Vagrant.configure(2) do |config|
  config.vm.define "k3s-barge"
  config.vm.hostname = "k3s-barge"
  config.vm.box = "ailispaw/barge"
  config.vm.synced_folder ".", "/vagrant", id: "vagrant"

  config.vm.provision :shell do |sh|
    sh.inline = <<-EOT
      set -e

      echo "Installing k3s..."
      wget -nv https://github.com/rancher/k3s/releases/download/#{K3S_VERSION}/k3s -O /opt/bin/k3s
      chmod +x /opt/bin/k3s

      bash /vagrant/init2.sh
      cat /vagrant/init2.sh >> /etc/init.d/init.sh

      cd /opt/bin
      ln -s k3s crictl
      crictl completion > /etc/bash_completion.d/crictl

      # Stop Docker
      /etc/init.d/docker stop
      rm -f /etc/init.d/S60docker

      cd /opt/bin
      ln -s k3s kubectl
      kubectl completion bash > /etc/bash_completion.d/kubectl

      cp /vagrant/k3s-server /etc/init.d/k3s-server
      cd /etc/init.d
      ln -s k3s-server S70k3s-server

      source /etc/os-release
      echo "Welcome to ${PRETTY_NAME}, k3s version #{K3S_VERSION}" > /etc/motd
    EOT
  end
end