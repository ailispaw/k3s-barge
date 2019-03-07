# k3s on Barge with Vagrant/VirtualBox

[k3s](https://github.com/rancher/k3s)

> Lightweight Kubernetes. Easy to install, half the memory, all in a binary less than 40mb.

This repo creates the k3s environment on [Barge](https://github.com/bargees/barge-os) with [Vagrant](https://www.vagrantup.com/) locally and instantly.

## Requirements

- [VirtualBox](https://www.virtualbox.org/)
- [Vagrant](https://www.vagrantup.com/)

## Boot up

```
$ make
```

It will create one k3s server node with its agent.

## Login to the node

```
$ make ssh
Welcome to Barge 2.12.0, k3s version v0.1.0
[bargee@k3s-barge ~]$ kubectl get nodes
NAME        STATUS   ROLES    AGE   VERSION
k3s-barge   Ready    <none>   38s   v1.13.3-k3s.6
[bargee@k3s-barge ~]$ sudo crictl ps
CONTAINER ID        IMAGE               CREATED             STATE               NAME                ATTEMPT             POD ID
4353303daef25       4a065d8dfa588       12 seconds ago      Running             https               0                   677691081c6b5
cba0f215bb98c       4a065d8dfa588       12 seconds ago      Running             http                0                   677691081c6b5
f0e37ecc228b5       98768a8bf3fed       13 seconds ago      Running             traefik             0                   cdb489f902b0e
05d5d79484fb7       2ee68ed074c6e       22 seconds ago      Running             coredns             0                   43ac66cef9bb3
```