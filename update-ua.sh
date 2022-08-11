#!/usr/bin/env bash

# constants - set me before using!
UAPATH=~/wss-unified-agent.jar  # path to the UA version currently in use
OLDUA=~/old-uas/  # path to directory for saving old versions of the UA

# get current UA version
VERSION=$(java -jar ${UAPATH} -v)

# calculate sha256 of current UA version, then take only the first 64 characters (the actual sha hash value)
CURRENT=$(shasum -a 256 $UAPATH)
CURSUM=${CURRENT::64}

# download the sha256 hash of the latest UA
echo "Getting current sha256"
curl -s https://unified-agent.s3.amazonaws.com/wss-unified-agent.jar.sha256 > ua-sha256

# take only the first 64 characters (the actual sha hash value)
NEW=$(cat ua-sha256)
NEWSUM=${NEW::64}

# compare the two hashes; download the new UA version if they don't match
if [[ "$CURSUM" == "$NEWSUM" ]]; then
	echo "The installed UA is the current version"
else mkdir -p $OLDUA  # create directory for old UA versions, if it doesn't already exist
	mv $UAPATH ${OLDUA}wss-unified-agent-${VERSION}.jar  # rename and move the now-old version of the UA
	echo "The installed UA version is out of date. Downloading newest version:"
	curl -# https://unified-agent.s3.amazonaws.com/wss-unified-agent.jar > $UAPATH  # download new version to the location specified in UAPATH
	NEWVERSION=$(java -jar ${UAPATH} -v)
	echo "UA updated from ${VERSION} to ${NEWVERSION}"
	echo "The old version has been moved to ${OLDUA}"
fi

# remove temp sha file
rm ua-sha256