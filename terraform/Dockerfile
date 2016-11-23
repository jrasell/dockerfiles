# Comments:
#	This is used for primary testing Terraform modules. The module must have a
#	tests directory or equivalent which contains variables to be used during the
#	test run, and also use remote state.
#
# docker run --rm -it \
#	-v /<path_to_code>:/terraform-code \
# 	-e AWS_DEFAULT_REGION=<aws_region> \
# 	-e AWS_ACCESS_KEY_ID=<aws_access_key_id> \
# 	-e AWS_SECRET_ACCESS_KEY=<aws_secret_access_key> \
#	/bin/sh -c "terraform remote config -backend=s3 -backend-config="<bucket_name>" \
#	-backend-config="key=tfstate/modules/<module_name><version>.tfstate"; \
#	terraform plan -var-file=/terraform-code/tests/variables.tf /terraform-code"
#

FROM alpine:edge
MAINTAINER James Rasell <jamesrasell@gmail.com>

ENV PATH /go/bin:/usr/local/go/bin:$PATH
ENV GOPATH /go

RUN	apk --no-cache add \
	ca-certificates \
	curl

ENV TERRAFORM_VERSION v0.7.11

RUN buildDeps=' \
		bash \
		go \
		git \
		gcc \
		libc-dev \
		make \
	' \
	set -x \
	&& apk --no-cache add $buildDeps \
	&& mkdir -p /go/src/github.com/hashicorp \
	&& git clone --branch ${TERRAFORM_VERSION} https://github.com/hashicorp/terraform /go/src/github.com/hashicorp/terraform \
	&& cd /go/src/github.com/hashicorp/terraform \
	&& XC_ARCH="amd64" XC_OS="linux" make dev\
	&& mv bin/terraform* /usr/bin/ \
	&& apk del $buildDeps \
	&& rm -rf /go \
	&& echo "Build complete."
