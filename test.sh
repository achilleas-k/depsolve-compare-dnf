#!/usr/bin/bash

set -euo pipefail

pushd images

export OSBUILD_TESTING_RNG_SEED=1

gen() {
    output=$1
    # clear out any old results
    rm -rfv "${output}"
    mkdir -pv "${output}"
    cp /usr/lib/osbuild/solver.json "${output}/solver.json"
    echo "GENERATING MANIFESTS"
    # also making sure metadata are not reused between runs by putting them in
    # the output directory
    /bin/gen-manifests  \
        --output "${output}/manifests" \
        --packages=True \
        --containers=True \
        --metadata=False \
        --fake-bootc=False \
        --arches="x86_64" \
        --distros="centos-9" \
        --cache "${output}/rpmmd" \
        --workers=10
}

cat > /usr/lib/osbuild/solver.json << EOF
{"use_dnf4": true}
EOF
gen /manifests/dnf4/

cat > /usr/lib/osbuild/solver.json << EOF
{"use_dnf5": true}
EOF

gen /manifests/dnf5/
