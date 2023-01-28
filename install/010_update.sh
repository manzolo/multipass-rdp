#!/bin/bash
sudo apt -y remove needrestart
DEBIAN_FRONTEND=noninteractive sudo apt -qqy update;
DEBIAN_FRONTEND=noninteractive sudo apt -qqy upgrade;
