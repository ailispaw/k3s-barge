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
Welcome to Barge 2.13.0, k3s version v0.6.1 (7ffe802a)
[bargee@master ~]$ kubectl get nodes -o wide
NAME      STATUS   ROLES    AGE   VERSION         INTERNAL-IP      EXTERNAL-IP   OS-IMAGE       KERNEL-VERSION   CONTAINER-RUNTIME
master    Ready    master   33s   v1.14.3-k3s.1   192.168.65.100   <none>        Barge 2.13.0   4.14.125-barge   containerd://1.2.5+unknown
node-01   Ready    worker   14s   v1.14.3-k3s.1   192.168.65.101   <none>        Barge 2.13.0   4.14.125-barge   containerd://1.2.5+unknown
node-02   Ready    worker   1s    v1.14.3-k3s.1   192.168.65.102   <none>        Barge 2.13.0   4.14.125-barge   containerd://1.2.5+unknown
[bargee@master ~]$ helm version
Client: &version.Version{SemVer:"v2.14.1", GitCommit:"5270352a09c7e8b6e8c9593002a73535276507c0", GitTreeState:"clean"}
Server: &version.Version{SemVer:"v2.14.1", GitCommit:"5270352a09c7e8b6e8c9593002a73535276507c0", GitTreeState:"clean"}
```