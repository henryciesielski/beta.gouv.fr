#!/bin/bash
#
# check_yaml_syntax.sh [path/to/files]
#   - extract first part of yamlfile (metadata only)
#   - execute yamllint on this part, and output error if any
#   - yamllint configuration is defined in ".yamllint.yml" at the root dir of the repository (can be overrided with YAMLLINT_CONFIG_FILE variable)
#
set -euo pipefail

DIR="${1:? $(basename $0) path/to/files}"
YAMLLINT_CONFIG_FILE="${YAMLLINT_CONFIG_FILE:-.yamllint.yml}"

error=0
for s in ${DIR}/*.md ; do
    output=$(ci/extract_yaml_front_matter_metadata.py $s | yamllint -c .yamllint.yml  --no-warnings -f github  - ) || { echo "$output"|sed -e "s|file=stdin|file=$s|g"; error=1 ; }
done

exit $error
