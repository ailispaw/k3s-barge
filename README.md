# k3s on Barge with Vagrant/VirtualBox

[k3s](https://github.com/rancher/k3s)

> Lightweight Kubernetes. Easy to install, half the memory, all in a binary less than 40mb.

This repo creates the k3s environment on [Barge](https://github.com/bargees/barge-os) with [Vagrant](https://www.vagrantup.com/) locally and instantly.

## Requirements

- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](https://www.vagrantup.com/)

## Boot up

It will create one k3s server node with its agent and two agent nodes by default.

Note) You may need to change `NETWORK_ADAPTOR` variable in `Vagrantfile` for your network.

```
$ vagrant up
```

## Login to the master node

```
$ vagrant ssh master
Welcome to Barge 2.12.0, k3s version v0.2.0
[bargee@master ~]$ kubectl get nodes -o wide
NAME      STATUS   ROLES    AGE   VERSION         INTERNAL-IP    EXTERNAL-IP   OS-IMAGE       KERNEL-VERSION   CONTAINER-RUNTIME
master    Ready    <none>   52s   v1.13.4-k3s.1   192.168.0.48   <none>        Barge 2.12.0   4.14.105-barge   containerd://1.2.4+unknown
node-01   Ready    <none>   35s   v1.13.4-k3s.1   192.168.0.49   <none>        Barge 2.12.0   4.14.105-barge   containerd://1.2.4+unknown
node-02   Ready    <none>   20s   v1.13.4-k3s.1   192.168.0.50   <none>        Barge 2.12.0   4.14.105-barge   containerd://1.2.4+unknown
```