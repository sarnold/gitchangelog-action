#! /usr/bin/env bash

echo "Current github ref: ${GITHUB_REF}"
echo "Current tag: ${GITHUB_REF/refs\/tags\//}"
if ! [[ -n "${GITHUB_REF/refs\/tags\//}" ]]; then
    echo "No current tag found!"
else
    CURRENT_TAG="${GITHUB_REF/refs\/tags\//}"
    echo "Using tag: ${CURRENT_TAG}"
fi

REV_LIST=$(git rev-list --tags --skip=1 --max-count=1)
PREVIOUS_TAG=$(git describe --abbrev=0 --tags "${REV_LIST}")
PREVIOUS_SORTED=$(git tag --sort=taggerdate | tail -n2 | head -n1)

NUM_TAGS=$(git tag -l | wc -l)
echo "Number of tags found: ${NUM_TAGS}"
if [[ "${NUM_TAGS}" = "0" ]]; then
    echo "Zero tags found, nothing to do ..."
elif [[ "${NUM_TAGS}" = "1" ]]; then
    echo "No previous tag found, generating full changelog ..."
    BASE_TAG=0
    CMD="gitchangelog"
else
    if [[ -n $USE_SORT ]]; then
        LAST_TAG="${PREVIOUS_SORTED}"
    else
        LAST_TAG="${PREVIOUS_TAG}"
    fi
    echo "Using previous tag: ${LAST_TAG}"
    CMD="gitchangelog ${LAST_TAG}..${CURRENT_TAG}"
fi

echo "Using command: ${CMD}"

gitchangelog --debug HEAD^^..HEAD
