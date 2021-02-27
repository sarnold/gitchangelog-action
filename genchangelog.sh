#! /usr/bin/env bash

GIT_VERSION=$(git --version)
echo "Found: ${GIT_VERSION}"

NUM_TAGS=$(git tag -l | wc -l)
echo "Number of tags found: ${NUM_TAGS}"

if [[ -n "$INPUT_CONFIG_FILE" ]]; then
    GITCHANGELOG_CONFIG_FILENAME="${INPUT_CONFIG_FILE}"
else
    GITCHANGELOG_CONFIG_FILENAME="./.gitchangelog-release.rc"
fi
echo "Config file: ${GITCHANGELOG_CONFIG_FILENAME}"

if [[ -n "$INPUT_OUTPUT_FILE" ]]; then
    OUT_FILE="${INPUT_OUTPUT_FILE}"
else
    OUT_FILE="CHANGES.md"
fi
echo "Output file: ${OUT_FILE}"

if [[ "${NUM_TAGS}" = "0" || "${NUM_TAGS}" = "1" ]]; then
    echo "No previous tag found, generating full changelog ..."
    CMD="gitchangelog --debug"
else
    VERSION=${GITHUB_REF/refs\/tags\//}
    echo "Current version ref: ${VERSION}"
    CURRENT_TAG="${VERSION}"
    echo "If this is a tag, we use it: ${CURRENT_TAG}"

    REV_LIST=$(git rev-list --tags --skip=1 --max-count=1)
    PREVIOUS_TAG=$(git describe --abbrev=0 --tags "${REV_LIST}")
    PREVIOUS_SORTED=$(git tag --sort=taggerdate | tail -n2 | head -n1)

    if [[ -n $INPUT_EXTRA_SORT ]]; then
        LAST_TAG="${PREVIOUS_SORTED}"
    else
        LAST_TAG="${PREVIOUS_TAG}"
    fi
    echo "Previous tag: ${LAST_TAG}"
    CMD="gitchangelog --debug ${LAST_TAG}..${CURRENT_TAG}"
fi

echo "Using command: ${CMD}"

$CMD > $OUT_FILE
