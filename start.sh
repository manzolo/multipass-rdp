#!/bin/bash

HOST_DIR_NAME=${PWD}

#Include functions
. ${HOST_DIR_NAME}/script/__functions.sh 

msg_warn "Starting vm"
multipass start $VM_NAME

msg_info "$VM_NAME started!"

. ${HOST_DIR_NAME}/script/_hosts_manager.sh

removehost
addhost

echo "------------------------------------------------"
echo ""
msg_warn "Shell on "$VM_NAME
msg_info "multipass shell "$VM_NAME
echo ""

echo ""
msg_warn "RDP connection settings:"
msg_info "Server   : "$VM_NAME
msg_info "Username : "$USERNAME
msg_info "Password : "$PASSWORD
echo ""

echo ""
msg_warn "RDP xfce session:"
CMD="sudo sh -c \"echo 'xfce4-session' > /home/$USERNAME/.xsession && chown $USERNAME:$USERNAME /home/$USERNAME/.xsession\""
msg_warn "multipass exec -v ${VM_NAME} -- ${CMD}"
echo ""

echo ""
msg_warn "RDP gnome session:"
CMD="sudo sh -c \"echo 'gnome-session' > /home/$USERNAME/.xsession && chown $USERNAME:$USERNAME /home/$USERNAME/.xsession\""
msg_warn "multipass exec -v ${VM_NAME} -- ${CMD}"
echo ""

echo "Start VM:"
msg_warn "./start.sh"
echo "Stop VM:"
msg_warn "./stop.sh"
echo "Uninstall VM:"
msg_warn "./uninstall.sh"
echo "------------------------------------------------"
