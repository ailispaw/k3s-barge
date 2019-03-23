# A dummy plugin for Barge to set hostname and network correctly at the very first `vagrant up`
module VagrantPlugins
  module GuestLinux
    class Plugin < Vagrant.plugin("2")
      guest_capability("linux", "change_host_name") { Cap::ChangeHostName }
      guest_capability("linux", "configure_networks") { Cap::ConfigureNetworks }
    end
  end
end

K3S_VERSION  = "v0.3.0"
BASE_IP_ADDR = "192.168.15"
NUM_OF_NODES = 2

Vagrant.configure(2) do |config|
  config.vm.box = "ailispaw/barge"
  config.vm.synced_folder ".", "/vagrant", id: "vagrant"
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--groups", "/k3s-barge"]
    vb.customize ["modifyvm", :id, "--nic2", "natnetwork", "--nat-network2", "natnet1"]
  end

  config.vm.provision :shell, run: "always" do |sh|
    sh.inline = <<-EOT
      # Ensure the default gateway is eth1
      route del default dev eth0 2>/dev/null || true
      route add default gw #{BASE_IP_ADDR}.1 dev eth1 2>/dev/null || true
    EOT
  end

  config.vm.provision :shell do |sh|
    sh.inline = <<-EOT
      set -e

      # Stop Docker
      /etc/init.d/docker stop
      rm -f /etc/init.d/S60docker

      bash /vagrant/scripts/init2.sh
      cat /vagrant/scripts/init2.sh >> /etc/init.d/init.sh

      echo "Installing k3s..."
      mkdir -p /vagrant/dl
      if [ ! -f "/vagrant/dl/k3s-#{K3S_VERSION}" ]; then
        wget -nv https://github.com/rancher/k3s/releases/download/#{K3S_VERSION}/k3s \
          -O /vagrant/dl/k3s-#{K3S_VERSION}
      fi
      cp -f /vagrant/dl/k3s-#{K3S_VERSION} /opt/bin/k3s
      chmod +x /opt/bin/k3s

      cd /opt/bin
      ln -s k3s crictl
      crictl completion > /etc/bash_completion.d/crictl

      source /etc/os-release
      echo "Welcome to ${PRETTY_NAME}, $(k3s --version)" > /etc/motd
    EOT
  end

  config.vm.define "master" do |node|
    node.vm.hostname = "master.k3s.local"
    node.vm.network :private_network, ip: "#{BASE_IP_ADDR}.100"
    node.vm.provision :shell do |sh|
      sh.inline = <<-EOT
        cd /opt/bin
        ln -s k3s kubectl
        kubectl completion bash > /etc/bash_completion.d/kubectl

        cd /etc/init.d
        cp /vagrant/scripts/k3s-server k3s-server
        ln -s k3s-server S70k3s-server
        /etc/init.d/k3s-server start

        NODE_TOKEN="/var/lib/rancher/k3s/server/node-token"
        while [ ! -f ${NODE_TOKEN} ]; do
          sleep 1
        done
        cp ${NODE_TOKEN} /vagrant/config/node-token
      EOT
    end
  end

  (1..NUM_OF_NODES).each do |i|
    config.vm.define "node-%02d" % i do |node|
      node.vm.hostname = "node-%02d.k3s.local" % i
      node.vm.network :private_network, ip: "#{BASE_IP_ADDR}.#{100+i}"
      node.vm.provision :shell do |sh|
        sh.inline = <<-EOT
          echo "SERVER_URL=\\"https://#{BASE_IP_ADDR}.100:6443\\"" > /etc/default/k3s-agent
          echo "NODE_TOKEN=\\"$(cat /vagrant/config/node-token)\\"" >> /etc/default/k3s-agent

          cd /etc/init.d
          cp /vagrant/scripts/k3s-agent k3s-agent
          ln -s k3s-agent S71k3s-agent
          /etc/init.d/k3s-agent start
        EOT
      end
    end
  end
 end