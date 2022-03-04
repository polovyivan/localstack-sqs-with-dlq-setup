
<p align="center">
  <img width="460" height="300" src="https://miro.medium.com/max/1400/1*6ew1sTRcjtKmMYwPLkzEvw.png">
</p>

<h1 align="center"><a href="https://faun.pub/aws-sqs-with-dead-letter-queue-dlq-local-setup-using-localstack-346dbad98849">AWS SQS with Dead-letter queue (DLQ) local setup using Localstack
</a></h1>

Commands:

```sh
#Put message to Source SQS
aws --endpoint-url=http://localhost:4566 sqs send-message --queue-url=http://localhost:4566/000000000000/source-sqs --message-body={test}

#Receive message from Source SQS
aws --endpoint-url=http://localhost:4566 sqs receive-message --queue-url=http://localhost:4566/000000000000/source-sqs

#Receive message from DLQ SQS
aws --endpoint-url=http://localhost:4566 sqs receive-message --queue-url=http://localhost:4566/000000000000/dlq-sqs
```