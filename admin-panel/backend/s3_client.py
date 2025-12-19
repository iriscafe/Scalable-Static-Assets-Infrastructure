import boto3

s3 = boto3.client("s3")

def upload_file(fileobj, bucket, key):
    s3.upload_fileobj(fileobj, bucket, key)
