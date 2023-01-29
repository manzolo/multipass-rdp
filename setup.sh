#!/bin/bash

HOST_DIR_NAME=${PWD}
#------------------- Env vars ---------------------------------------------
#Number of Cpu for main VM
mainCpu=1
#GB of RAM for main VM
mainRam=2Gb
#GB of HDD for main VM
mainHddGb=10Gb
VM_INSTALL_PATH=/home/ubuntu/rdp
#--------------------------------------------------------------------------

#Include functions
. $(dirname $0)/script/__functions.sh 

msg_warn "Check prerequisites..."

#Check prerequisites
check_command_exists "multipass"

msg_warn "Creating vm"
multipass launch -m $mainRam -d $mainHddGb -c $mainCpu -n $VM_NAME

msg_info $VM_NAME" is up!"

msg_info "[Task 1]"
msg_warn "Transfer host installation scripts"
multipass transfer --recursive ${HOST_DIR_NAME} $VM_NAME:$VM_INSTALL_PATH

multipass list

msg_info "[Task 2]"
run_command_on_vm "$VM_NAME" "${VM_INSTALL_PATH}/script/_configure.sh ${VM_INSTALL_PATH}"
#sleep 10
#multipass restart $VM_NAME
#sleep 10
msg_warn "Installing add-ons"
run_command_on_vm "$VM_NAME" "${VM_INSTALL_PATH}/script/_addons.sh ${VM_INSTALL_PATH}"

run_command_on_vm "$VM_NAME" "sudo useradd -s /bin/bash -d /home/${USERNAME}/ -m -p `perl -e 'print crypt($ARGV[0], "password")' \`echo ${PASSWORD}\`` ${USERNAME}"

msg_info "[Task 3]"
msg_warn "Start $VM_NAME"
${HOST_DIR_NAME}/start.sh

msg_info "[Task 4]"
msg_warn "On task complete"