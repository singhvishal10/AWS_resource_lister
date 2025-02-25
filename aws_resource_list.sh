#! /bin/bash

#This script will list all the resources in the AWS account.
#Author : Vishal Singh
#version : 0.0.1

#Following are the supported AWS services by the script
# 1. EC2
# 2. EBS 
# 3. S3
# 4. RDS
# 5. ELB
# 6. ELB
# 7. CLOUDFORMATION
# 8. CLOUDWATCH
# 9. VPC
# 10. SNS
# 11. IAM

########################################################################

#Usage of the script
./aws_resource_list.sh <region> <service_name>

#Example
./aws_resource_list.sh us-east-1 EC2

########################################################################


#Defining the arguments
aws_region=$1
aws_service=$2

#Checking if all the arguments are passed
if [ $# -ne 2 ]; then
    echo "Usage: $0 <region> <service_name>"
    exit 1
fi 

#Check if the AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "AWS CLI is not installed. Please install it and try again."
    exit 1  
fi

#Check if the AWS CLI is configured or not
if [ ! -d ~/.aws ]; then
    echo "AWS CLI is not configured. Please configure it and try again."
    exit 1
fi

#Executing the AWS CLI command based on service name
case $2 in
  EC2)
    aws ec2 describe-instances --region $1
    ;;
  EBS)
    aws ec2 describe-volumes --region $1
    ;;
  S3)
    aws s3api list-buckets --region $1
    ;;
  RDS)
    aws rds describe-db-instances --region $1
    ;;
  Lambda)
    aws lambda list-functions --region $1
    ;;
  ELB)
    aws elb describe-load-balancers --region $1
    ;;
  SNS)
    aws sns list-topics --region $1
    ;;
  SQS)
    aws sqs list-queues --region $1
    ;;
  CLOUDWATCH)
    aws cloudwatch describe-alarms --region $1
    ;;
  CLOUDFORMATION)
    aws cloudformation describe-stacks --region $1
    ;;
  *)
    echo "Invalid Service. Please enter a valid service."
    exit 1
    ;;
esac
