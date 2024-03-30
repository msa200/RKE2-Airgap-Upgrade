#!/bin/bash

echo "Do you want to take a snapshot before upgrade? (yes/no)"

read answer

if [[ $answer == "yes" || $answer == "YES" || $answer == "Yes" ]]; then
    # Run the command to take snapshot
    rke2 etcd-snapshot save --name pre-upgrade-snapshot
    echo "Snapshot taken successfully."
else
    echo "No snapshot taken."
    # Continue with the script
fi

echo "Please enter the tar files path for the target RKE2 version:"

read rke2_tar_file

echo "Please enter the rke2 artifacts path:"

read rke2_artifacts

cd $rke2_artifacts

find . -type f ! -name 'get.rke2.io.sh' -exec rm {} +

echo "Please wait files are copying now"

cp $rke2_tar_file/*  .

rm /var/lib/rancher/rke2/agent/images/*

cp $rke2_tar_file/*  /var/lib/rancher/rke2/agent/images/

chmod 0777 $rke2_artifacts/*

chmod 0777 /var/lib/rancher/rke2/agent/images/*


systemctl stop rke2-server
systemctl stop rke2-agent


cd /usr/local/bin

./rke2-killall.sh

cd $rke2_artifacts



echo "Is this node a master node or a worker node? (M/W)"

read node_type

if [[ $node_type == "M" || $node_type == "m" ]]; then
    INSTALL_RKE2_ARTIFACT_PATH=/root/rke2-artifacts sh ./get.rke2.io.sh
    echo "Please wait the rke2 service restarting now"
    systemctl restart rke2-server
elif [[ $node_type == "W" || $node_type == "w" ]]; then
    rm  /var/lib/rancher/rke2/agent/images/sha256sum-amd64.txt
    INSTALL_RKE2_TYPE="agent" INSTALL_RKE2_ARTIFACT_PATH=/root/rke2-artifacts  ./get.rke2.io.sh
    echo "Please wait the rke2 service restarting now"
    systemctl start rke2-agent
else
    echo "Invalid input. Please type M/m for master node or W/w for worker node."
fi

