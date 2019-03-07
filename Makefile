VM_NAME := k3s-barge
VM_ID   := `cat .vagrant/machines/$(VM_NAME)/virtualbox/id`
VM_IP   := VBoxManage guestproperty get VM_ID /VirtualBox/GuestInfo/Net/0/V4/IP | awk '{print $$2}'

NETWORK_ADAPTER := en0

SSH_CONFIG := .ssh_config
SSH        := ssh -F $(SSH_CONFIG) $(VM_NAME)

$(VM_NAME):
	@vagrant up $@ --no-provision
	@vagrant ssh-config $@ > $(SSH_CONFIG)
	@vagrant provision $@
	@vagrant halt $@
	@echo "Making the first network interface bridged to [$(NETWORK_ADAPTER)]"
	@VBoxManage modifyvm $(VM_ID) --nic1 bridged --bridgeadapter1 "$(NETWORK_ADAPTER)"
	@make resume

up resume:
	@VBoxManage startvm $(VM_ID) --type headless
	@echo "Waiting for SSH connection"
	@ID=$(VM_ID); \
	 while [ "`$(VM_IP:VM_ID=$${ID})`" = "value" ]; do \
		sleep 0.5; \
	 done; \
	 IP=`$(VM_IP:VM_ID=$${ID})`; \
	 sed -i '' 's/HostName .*/HostName '$${IP}'/' $(SSH_CONFIG); \
	 sed -i '' 's/Port .*/Port 22/g' $(SSH_CONFIG); \
	 while ! $(SSH) -q -o "BatchMode=yes" -o "ConnectTimeout=1" exit ; do \
		sleep 0.5; \
	 done

status:
	@VBoxManage showvminfo $(VM_ID) | grep State

ip:
	@$(VM_IP:VM_ID=$(VM_ID))

ssh:
	@$(SSH)

suspend:
	@VBoxManage controlvm $(VM_ID) savestate

halt:
	@VBoxManage controlvm $(VM_ID) acpipowerbutton

destroy:
	-@vagrant destroy -f
	@$(RM) -r .vagrant

.PHONY: $(VM_NAME) up status ip ssh suspend resume halt destroy
