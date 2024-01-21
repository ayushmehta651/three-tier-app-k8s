# three-tier-app-k8s

## Creating cluster using terraform script - TODO



## Configure codebuild to deploy backend and frontend to EKS
- Will be showing the steps to deploy backend and similar steps can be followed to deploy frontend
- While setting up code build give the Buildspec.yaml file from Github repo path of k8s/backend/buildspec_eks.yaml
- Configure environment varibales by clicking on edit -> Environment and add below environment variables

   <img width="743" alt="image" src="https://github.com/ayushmehta651/three-tier-app-k8s/assets/61558525/aecbe027-adaf-43b7-9558-9ddeb1a8f125">

- Create a ECR for the images and specify the name in env variable with the tag as well
- Specify AWS cluster name in env variable
- Edit service role for code build and add attach inline policies by executing create_iam_role.sh file using
```bash
    sh create_iam_role.sh
  ```

<img width="1472" alt="image" src="https://github.com/ayushmehta651/three-tier-app-k8s/assets/61558525/61163b20-d762-4809-a450-2bcbae517d52">

- Even though the CodeBuild role has permission to authenticate to the cluster, it doesn’t have the requisite RBAC access to do any other
action on the cluster. You can even list pods in the cluster. You should read the following quote from EKS documentation:

  <i> "When you create an Amazon EKS cluster, the IAM entity user or role, such as a federated user that creates the cluster, is automatically
granted system:masters permissions in the cluster's RBAC configuration. To grant additional AWS users or roles the ability to interact
with your cluster, you must edit the aws-auth ConfigMap within Kubernetes." </i>

  ```
  eksctl create iamidentitymapping --cluster three-tier-cluster --arn arn:aws:iam::AWS_ACCOUNT_ID:role/CodeBuildKubectlRole  --group system:masters --username CodeBuildKubectlRole --region=AWS_REGION
  
  ```

- Run the code build
