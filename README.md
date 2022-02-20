
<p align="center">
  <img width="460" height="300" src="picture-url">
</p>

<h1 align="center"><a href="blog-url">Blog-name</a></h1>

Commands:

```sh
#Put message to Source SQS
aws --endpoint-url=http://localhost:4566 sqs send-message --queue-url=http://localhost:4566/000000000000/source-sqs --message-body={test}

#Receive message from Source SQS
aws --endpoint-url=http://localhost:4566 sqs receive-message --queue-url=http://localhost:4566/000000000000/source-sqs

#Receive message from DLQ SQS
aws --endpoint-url=http://localhost:4566 sqs receive-message --queue-url=http://localhost:4566/000000000000/dlq-sqs
```