# RKE2 Upstream Cluster Upgrade Automation Script

## Overview

This script automates the process of upgrading an RKE2 upstream cluster node by node. This is particularly helpful as the manual upgrade process can be time-consuming, especially for large clusters.

## Usage

1. **Run the Script**: Execute the script on each node of your RKE2 cluster.

2. **Follow Prompted Questions**: The script will prompt you with a series of questions to guide the upgrade process. Here are the questions you will encounter:

   - *Do you want to take a snapshot before upgrade? (yes/no)*:
     - Answer 'yes' if you want to take a snapshot before the upgrade process. This is recommended for the first master node only.
   - *Please enter the tar files path for the target RKE2 version*:
     - Enter the path to the tar files for the target RKE2 version.
   - *Please enter the RKE2 artifacts path*:
     - Provide the path for the RKE2 artifacts.
   - *Is this node a master node or a worker node? (M/W)*:
     - Specify whether the current node is a master node (M) or a worker node (W).

3. **Complete Upgrade**: Once you've answered these questions, the script will handle the upgrade process automatically.

## Notes

- Ensure that you have the necessary permissions and access to execute scripts on each node of your RKE2 cluster.
- Review the script before execution to ensure it meets your requirements and security standards.
