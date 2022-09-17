#!/bin/bash

mkdir -p ~/.config/osc/
cat <<EOF > ~/.config/osc/oscrc
[general]
apiurl = https://os-build.ewe.moe

[https://os-build.ewe.moe]
user=github
pass=$OSC_PASS
EOF

if [ -n ${GITHUB_REF} ]; then
	GITHUB_REF=refs/heads/OBS/test
fi

BRANCH_NAME=${GITHUB_REF#refs/heads/}
OBS_LOC=eweOS:${BRANCH_NAME^}

osc branch eweOS:OBS/template $OBS_LOC \
	|| { echo 'Branch failed' ; exit 1; }

osc checkout $OBS_LOC

sed -i "s:main:$BRANCH_NAME:g" \
	"${OBS_LOC}"/_service

osc commit $OBS_LOC -m "Create package"
