# k3s on Barge with Vagrant/VirtualBox

[k3s](https://github.com/rancher/k3s)

> Lightweight Kubernetes. Easy to install, half the memory, all in a binary less than 40mb.

This repo creates the k3s environment on [Barge](https://github.com/bargees/barge-os) with [Vagrant](https://www.vagrantup.com/) locally and instantly.

## Requirements

- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](https://www.vagrantup.com/)

## Boot up

It will create one k3s server node with its agent and two agent nodes by default.

```
$ vagrant up
```

## Login to the master node

```
$ vagrant ssh master
Welcome to Barge 2.13.0, k3s version v1.18.17+k3s1 (0a8aa154)
[bargee@master ~]$ kubectl get nodes -o wide
NAME      STATUS     ROLES    AGE   VERSION         INTERNAL-IP      EXTERNAL-IP   OS-IMAGE       KERNEL-VERSION   CONTAINER-RUNTIME
node-01   Ready      <none>   16s   v1.18.17+k3s1   192.168.65.101   <none>        Barge 2.13.0   4.14.125-barge   containerd://1.3.10-k3s2
master    Ready      master   35s   v1.18.17+k3s1   192.168.65.100   <none>        Barge 2.13.0   4.14.125-barge   containerd://1.3.10-k3s2
node-02   NotReady   <none>   0s    v1.18.17+k3s1   192.168.65.102   <none>        Barge 2.13.0   4.14.125-barge   containerd://1.3.10-k3s2
[bargee@master ~]$ helm version
WARNING: Kubernetes configuration file is group-readable. This is insecure. Location: /etc/rancher/k3s/k3s.yaml
version.BuildInfo{Version:"v3.5.3", GitCommit:"041ce5a2c17a58be0fcd5f5e16fb3e7e95fea622", GitTreeState:"dirty", GoVersion:"go1.15.8"}
```