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
Welcome to Barge 2.13.0, k3s version v1.16.13+k3s1 (b720367f)
[bargee@master ~]$ kubectl get nodes -o wide
NAME      STATUS   ROLES    AGE   VERSION         INTERNAL-IP      EXTERNAL-IP   OS-IMAGE       KERNEL-VERSION   CONTAINER-RUNTIME
master    Ready    master   33s   v1.16.13+k3s1   192.168.65.100   <none>        Barge 2.13.0   4.14.125-barge   containerd://1.3.0-k3s.5
node-01   Ready    <none>   16s   v1.16.13+k3s1   192.168.65.101   <none>        Barge 2.13.0   4.14.125-barge   containerd://1.3.0-k3s.5
node-02   Ready    <none>   1s    v1.16.13+k3s1   192.168.65.102   <none>        Barge 2.13.0   4.14.125-barge   containerd://1.3.0-k3s.5
[bargee@master ~]$ helm version
version.BuildInfo{Version:"v3.2.4", GitCommit:"0ad800ef43d3b826f31a5ad8dfbb4fe05d143688", GitTreeState:"clean", GoVersion:"go1.13.12"}
```