#!/bin/bash
set -e

VALIDATE_REPO='https://github.com/jrasell/dockerfiles.git'
VALIDATE_BRANCH='master'

VALIDATE_HEAD="$(git rev-parse --verify HEAD)"

git fetch -q "$VALIDATE_REPO" "refs/heads/$VALIDATE_BRANCH"
VALIDATE_UPSTREAM="$(git rev-parse --verify FETCH_HEAD)"

VALIDATE_COMMIT_DIFF="$VALIDATE_UPSTREAM...$VALIDATE_HEAD"

validate_diff() {
	if [ "$VALIDATE_UPSTREAM" != "$VALIDATE_HEAD" ]; then
		git diff "$VALIDATE_COMMIT_DIFF" "$@"
	else
		git diff HEAD~ "$@"
	fi
}

# Discover which Dockerfiles changed
IFS=$'\n'
files=( $(validate_diff --name-only -- '*Dockerfile') )
unset IFS

# Build the changes Dockerfiles
for f in "${files[@]}"; do
	if ! [[ -e "$f" ]]; then
		continue
	fi

	image=${f%Dockerfile}
	base=${image%%\/*}
	suite=${image##*\/}
	build_dir=$(dirname $f)

	if [[ -z "$suite" ]]; then
		suite=latest
	fi

	(
	set -x
	docker build -t ${base}:${suite} ${build_dir}
	)

	echo "                       ---                                   "
	echo "Successfully built ${base}:${suite} with context ${build_dir}"
	echo "                       ---                                   "
done
