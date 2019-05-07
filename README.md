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
Welcome to Barge 2.12.1, k3s version v0.5.0 (8c0116dd)
[bargee@master ~]$ kubectl get nodes -o wide
NAME      STATUS   ROLES    AGE   VERSION         INTERNAL-IP      EXTERNAL-IP   OS-IMAGE       KERNEL-VERSION   CONTAINER-RUNTIME
master    Ready    <none>   31s   v1.14.1-k3s.4   192.168.65.100   <none>        Barge 2.12.1   4.14.111-barge   containerd://1.2.5+unknown
node-01   Ready    <none>   17s   v1.14.1-k3s.4   192.168.65.101   <none>        Barge 2.12.1   4.14.111-barge   containerd://1.2.5+unknown
node-02   Ready    <none>   3s    v1.14.1-k3s.4   192.168.65.102   <none>        Barge 2.12.1   4.14.111-barge   containerd://1.2.5+unknown
```