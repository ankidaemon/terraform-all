#!/bin/bash

sleep 50
mkdir -p /mnt/ec2-external-ebs
sudo mkfs.ext4 ${device_name}
sudo mount ${device_name} /ec2-external-ebs