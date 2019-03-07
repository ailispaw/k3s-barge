
# Make data persistent
for i in lib/cni lib/rancher log/containers log/pods ; do
  rm -f "/var/$i"
  mkdir -p "/mnt/data/var/$i"
  ln -s "/mnt/data/var/$i" "/var/$i"
done
