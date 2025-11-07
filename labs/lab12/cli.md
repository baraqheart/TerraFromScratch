
### Provistion Eks cluster with Ec2 managed nodes using the cli and console

Prerequisites
- install awscli 
- install kubectl
- IAM permission

Tasks
- create cluster
- create node
- clean up

**Step 1: Create your Amazon EKS cluster**
-  Create an Amazon VPC with public and private subnets that    meets Amazon EKS requirements.
```
aws cloudformation create-stack \
  --region region-code \
  --stack-name my-eks-vpc-stack \
  --template-url https://s3.us-west-2.amazonaws.com/amazon-eks/cloudformation/2020-10-29/amazon-eks-vpc-private-subnets.yaml
```
- Create a cluster IAM role and attach the required Amazon EKS IAM managed policy to it, copy the code below and save it as eks-role-trust-policy.json


```
{
  "Version":"2012-10-17",		 	 	 
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```
- create the cluster role
```
aws iam create-role \
  --role-name myAmazonEKSClusterRole \
  --assume-role-policy-document file://"eks-role-trust-policy.json"
```

- attach the EKS manged policy to the role
```
aws iam attach-role-policy \
  --policy-arn arn:aws:iam::aws:policy/AmazonEKSClusterPolicy \
  --role-name myAmazonEKSClusterRole
```

- create the cluster, by choosing a name for the cluster, and select the appropriate resource created earlier from the stack and the iam roles.

- create the cluster on the cli using the command below, make sure to replace all the parameter values

```
export account="111122223333"
export $version="1.33"
export $region="us-east-1"
export cluster_name="cluster1"
export subnetIds_1="subnet01"
export subnetIds_2="subnet02"
export $security_group="security-group"


aws eks create-cluster --region $region --name $cluster_name --kubernetes-version $version \
   --role-arn arn:aws:iam::$account:role/myAmazonEKSClusterRole \
   --resources-vpc-config subnetIds=$subnetIds_1,$subnetIds_2,securityGroupIds=$security_group
```

**Step 2: Configure your computer to communicate with your cluster**

- Create or update a kubeconfig file for your cluster.
```
aws eks update-kubeconfig --region <region> --cluster <clustername>
```
- validate the configuration

```
kubectl get svc
```

**Step 3: Create nodes - using EC2 Linux managed node group**

- Create a node IAM role and attach the required Amazon EKS IAM managed policy to it.

- Copy the following contents to a file named node-role-trust-policy.json.

```
{
  "Version":"2012-10-17",		 	 	 
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

- create the node iam role and attach the required managed trust policy

```
aws iam create-role \
  --role-name myAmazonEKSNodeRole \
  --assume-role-policy-document file://"node-role-trust-policy.json"
```
- attach the managed policy to the role

```
aws iam attach-role-policy \
  --policy-arn arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy \
  --role-name myAmazonEKSNodeRole
aws iam attach-role-policy \
  --policy-arn arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly \
  --role-name myAmazonEKSNodeRole
aws iam attach-role-policy \
  --policy-arn arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy \
  --role-name myAmazonEKSNodeRole
```
- locate the cluster name created earlier and create the node groups under compute

**Step 4: View resources**
- on the console, verify resources has been created
- on the terminal, use the commands to verify nodes has been created

```
kubectl get node
```

**Step 5: Delete resources**
- locate the node group and delete
- select the right cluster, and delete the cluster
- delete the eks-vpc-stack you created via cloudformation
- delete the iam roles