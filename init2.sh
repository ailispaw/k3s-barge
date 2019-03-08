# Setup cgroups
mkdir -p /sys/fs/cgroup
if ! mountpoint -q /sys/fs/cgroup; then
  mount -t tmpfs cgroup /sys/fs/cgroup
fi
for i in $(awk '!/^#/ { if ($4 == 1) print $1 }' /proc/cgroups); do
  mkdir -p /sys/fs/cgroup/$i
  if ! mountpoint -q /sys/fs/cgroup/$i; then
    mount -t cgroup -o $i cgroup /sys/fs/cgroup/$i
  fi
done

# Make data persistent
for i in lib/cni lib/rancher log/containers log/pods ; do
  rm -rf "/var/$i"
  mkdir -p "/mnt/data/var/$i"
  ln -s "/mnt/data/var/$i" "/var/$i"
done

# Mount the local folder at /vagrant
mkdir -p /vagrant
mount.vboxsf -o uid=$(id -u bargee),gid=$(id -g bargee) vagrant /vagrant
