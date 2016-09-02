#
# docker run --rm -it \
#	-v /<path_to_code>:/packer-code \
#	-e AWS_DEFAULT_REGION=<aws_region> \
#	-e AWS_ACCESS_KEY_ID=<aws_access_key_id> \
#	-e AWS_SECRET_ACCESS_KEY=<aws_secret_access_key> \
#	/bin/sh -c "packer build -var 'foo=bar' \
#	/packer-code/template.json"
#

FROM alpine:edge
MAINTAINER James Rasell <jamesrasell@gmail.com>

ENV PACKER_VERSION 0.10.1

RUN buildDeps=' \
		bash \
		ca-certificates \
		wget \
		unzip \
	' \
	set -x \
	&& apk --no-cache add $buildDeps \
	&& cd /tmp/ \
	&& wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip \
	&& unzip packer_${PACKER_VERSION}_linux_amd64.zip \
	&& mv packer /usr/bin/ \
	&& apk del $buildDeps \
	&& echo "Build complete."
