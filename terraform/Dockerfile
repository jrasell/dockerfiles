FROM alpine:edge
MAINTAINER James Rasell <jamesrasell@gmail.com>

ENV PATH /go/bin:/usr/local/go/bin:$PATH
ENV GOPATH /go

RUN	apk --no-cache add \
	ca-certificates \
	curl

ENV TERRAFORM_VERSION v0.7.1

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

ENTRYPOINT [ "terraform" ]
