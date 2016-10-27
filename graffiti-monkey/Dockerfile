#
# docker run --rm -it \
#	-e AWS_DEFAULT_REGION=<aws_region> \
#	-e AWS_ACCESS_KEY_ID=<aws_access_key_id> \
#	-e AWS_SECRET_ACCESS_KEY=<aws_secret_access_key> \
#	--region us-east-1
#

FROM alpine:latest
MAINTAINER James Rasell <jamesrasell@gmail.com>

RUN apk --no-cache add \
	ca-certificates \
	python \
	py-pip \
	&& pip install graffiti_monkey

ENTRYPOINT [ "graffiti-monkey" ]
