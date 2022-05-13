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
Welcome to Barge 2.15.0, k3s version v1.23.6+k3s1 (418c3fa8)
go version go1.17.5
[bargee@master ~]$ kubectl get nodes -o wide
NAME      STATUS   ROLES                  AGE   VERSION        INTERNAL-IP      EXTERNAL-IP   OS-IMAGE       KERNEL-VERSION   CONTAINER-RUNTIME
master    Ready    control-plane,master   42s   v1.23.6+k3s1   192.168.56.101   <none>        Barge 2.15.0   4.14.282-barge   containerd://1.5.11-k3s2
node-01   Ready    <none>                 24s   v1.23.6+k3s1   192.168.56.102   <none>        Barge 2.15.0   4.14.282-barge   containerd://1.5.11-k3s2
node-02   Ready    <none>                 12s   v1.23.6+k3s1   192.168.56.103   <none>        Barge 2.15.0   4.14.282-barge   containerd://1.5.11-k3s2
[bargee@master ~]$ helm version
WARNING: Kubernetes configuration file is group-readable. This is insecure. Location: /etc/rancher/k3s/k3s.yaml
version.BuildInfo{Version:"v3.9.0", GitCommit:"7ceeda6c585217a19a1131663d8cd1f7d641b2a7", GitTreeState:"clean", GoVersion:"go1.17.5"}
```