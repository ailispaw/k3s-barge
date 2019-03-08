
# Make data persistent
for i in var/lib/cni var/lib/rancher var/log/containers var/log/pods \
  run/containerd run/flannel run/k3s ; do
  rm -rf "/$i"
  mkdir -p "/mnt/data/$i"
  ln -s "/mnt/data/$i" "/$i"
done

# Mount the local folder at /vagrant
mkdir -p /vagrant
mount.vboxsf -o uid=$(id -u bargee),gid=$(id -g bargee) vagrant /vagrant
