#!/bin/sh
if [ $# -eq 0 ]; then
	echo "usage: $0 output_path.jar [paper_version] [paper_build]"
	exit
fi
PAPERMC_VERSION=${2:-latest}
PAPERMC_BUILD=${3:-latest}

if [ "$PAPERMC_VERSION" = "latest" ]; then
	# determine latest version
	echo "Determining latest Paper MC version..."
	PAPERMC_VERSION=$(curl -s "https://api.papermc.io/v2/projects/paper" | jq ".versions[-1]" | sed s/\"//g)
fi


echo "Using version $PAPERMC_VERSION"

if [ "$PAPERMC_BUILD" = "latest" ]; then
	echo "Determining latest build for $PAPERMC_VERSION..."
	PAPERMC_BUILD=$(curl -s "https://api.papermc.io/v2/projects/paper/versions/$PAPERMC_VERSION" | jq ".builds[-1]")
fi

echo "Using build $PAPERMC_BUILD"

DOWNLOAD_NAME=$(curl -s "https://api.papermc.io/v2/projects/paper/versions/$papermc_verison/builds/$papermc_build" | jq ".downloads.application.name")

curl "https://api.papermc.io/v2/projects/paper/versions/paper/versions/$PAPERMC_VERSION/builds/$PAPERMC_BUILD/download/$DOWNLOAD_NAME" -o "$1"

