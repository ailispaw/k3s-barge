
# Make data persistent
for i in lib/cni lib/rancher log/containers log/pods ; do
  rm -rf "/var/$i"
  mkdir -p "/mnt/data/var/$i"
  ln -s "/mnt/data/var/$i" "/var/$i"
done

# Mount the local folder at /vagrant
mkdir -p /vagrant
mount.vboxsf -o uid=$(id -u bargee),gid=$(id -g bargee) vagrant /vagrant
