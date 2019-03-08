# A dummy plugin for Barge to set hostname and network correctly at the very first `vagrant up`
module VagrantPlugins
  module GuestLinux
    class Plugin < Vagrant.plugin("2")
      guest_capability("linux", "change_host_name") { Cap::ChangeHostName }
      guest_capability("linux", "configure_networks") { Cap::ConfigureNetworks }
    end
  end
end

K3S_VERSION     = "v0.1.0"
NETWORK_ADAPTOR = "en0: Wi-Fi (Wireless)"
NUM_OF_NODES    = 2

Vagrant.configure(2) do |config|
  config.vm.box = "ailispaw/barge"
  config.vm.network :public_network, bridge: NETWORK_ADAPTOR, use_dhcp_assigned_default_route: true
  config.vm.synced_folder ".", "/vagrant", id: "vagrant"

  config.vm.provision :shell do |sh|
    sh.inline = <<-EOT
      set -e

      echo "Installing k3s..."
      wget -nv https://github.com/rancher/k3s/releases/download/#{K3S_VERSION}/k3s -O /opt/bin/k3s
      chmod +x /opt/bin/k3s

      # Stop Docker
      /etc/init.d/docker stop
      rm -f /etc/init.d/S60docker

      bash /vagrant/init2.sh
      cat /vagrant/init2.sh >> /etc/init.d/init.sh

      cd /opt/bin
      ln -s k3s crictl
      crictl completion > /etc/bash_completion.d/crictl

      source /etc/os-release
      echo "Welcome to ${PRETTY_NAME}, k3s version #{K3S_VERSION}" > /etc/motd
    EOT
  end

  config.vm.define "master" do |node|
    node.vm.hostname = "master.k3s.local"
    node.vm.provision :shell do |sh|
      sh.inline = <<-EOT
        cd /opt/bin
        ln -s k3s kubectl
        kubectl completion bash > /etc/bash_completion.d/kubectl

        cd /etc/init.d
        cp /vagrant/k3s-server k3s-server
        ln -s k3s-server S70k3s-server
        /etc/init.d/k3s-server start
  
        ifconfig eth1 | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\\.){3}[0-9]*).*/\\2/p' > /vagrant/master-ip

        NODE_TOKEN="/var/lib/rancher/k3s/server/node-token"
        while [ ! -f ${NODE_TOKEN} ]; do
          sleep 1
        done
        cp ${NODE_TOKEN} /vagrant/node-token
      EOT
    end
  end

  (1..NUM_OF_NODES).each do |i|
    config.vm.define "node-%02d" % i do |node|
      node.vm.hostname = "node-%02d.k3s.local" % i
      node.vm.provision :shell do |sh|
        sh.inline = <<-EOT
          k3s agent --server https://$(cat /vagrant/master-ip):6443 --token $(cat /vagrant/node-token) &> /var/log/k3s-agent.log &
        EOT
      end
    end
  end
 end