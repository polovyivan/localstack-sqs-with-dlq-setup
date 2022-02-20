#!/bin/bash
echo "########### Setting up localstack profile ###########"
aws configure set aws_access_key_id access_key --profile=localstack
aws configure set aws_secret_access_key secret_key --profile=localstack
aws configure set region sa-east-1 --profile=localstack

echo "########### Setting default profile ###########"
export AWS_DEFAULT_PROFILE=localstack

echo "########### Setting SQS names as env variables ###########"
export SOURCE_SQS=source-sqs
export DLQ_SQS=dlq-sqs

echo "########### Creating DLQ ###########"
aws --endpoint-url=http://localstack:4566 sqs create-queue --queue-name $DLQ_SQS

echo "########### ARN for DLQ ###########"
DLQ_SQS_ARN=$(aws --endpoint-url=http://localstack:4566 sqs get-queue-attributes\
                  --attribute-name QueueArn --queue-url=http://localhost:4566/000000000000/"$DLQ_SQS"\
                  |  sed 's/"QueueArn"/\n"QueueArn"/g' | grep '"QueueArn"' | awk -F '"QueueArn":' '{print $2}' | tr -d '"' | xargs)

echo "########### Creating Source queue ###########"
aws --profile=localstack --endpoint-url=http://localstack:4566 sqs create-queue --queue-name $SOURCE_SQS \
     --attributes '{
                   "RedrivePolicy": "{\"deadLetterTargetArn\":\"'"$DLQ_SQS_ARN"'\",\"maxReceiveCount\":\"3\"}",
                   "VisibilityTimeout": "10"
                   }'

echo "########### Listing queues ###########"
aws --endpoint-url=http://localhost:4566 sqs list-queues

echo "########### Listing Source SQS Attributes ###########"
aws --endpoint-url=http://localstack:4566 sqs get-queue-attributes\
                  --attribute-name All --queue-url=http://localhost:4566/000000000000/"$SOURCE_SQS"


