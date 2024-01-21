# IAM Setup
# For this setup, create an IAM policy name AmazonEKSAdminPolicy with the policy details in AmazonEKSAdminPolicy.json and
# attach the policy to the principal creating the cluster.


# Command to create cluster from a yaml file

eksctl create cluster -f cluster-create.yaml

