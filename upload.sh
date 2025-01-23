#!/usr/bin/env bash

set -euo pipefail

# Validate parameter is set
if [[ $# -lt 1 || -z "$1" ]]; then
    echo "Usage: $0 <version>"
    echo "Error: Missing required parameter: version"
    exit 1
fi

function downloadBaseBox() {
    # Extract base box name and version from Vagrantfile
    local -r baseBoxInfo="$(cat Vagrantfile | grep 'config.vm.box')"
    local -r baseBoxName="$(echo "${baseBoxInfo}" | grep 'config.vm.box =' | cut -d'"' -f2)"
    local -r baseBoxVersion="$(echo "${baseBoxInfo}" | grep 'config.vm.box_version' | cut -d'"' -f2)"

    echo "Base box name: ${baseBoxName/\//-VAGRANTSLASH-}"
    echo "Base box version: ${baseBoxVersion}"

    # Download base box
    vagrant box add \
        --box-version "${baseBoxVersion}" \
        --architechure arm64 \
        --provider vmware_desktop \
        "$baseBoxName"
    
    # Remove lock files
    local -r baseBoxPath="$HOME/.vagrant.d/boxes/${baseBoxName/\//-VAGRANTSLASH-}/${baseBoxVersion}/vmware_desktop"
    rm -r "${baseBoxPath}"/*.lck || echo "No lock files found to remove."
}

function packageAndUploadBox() {
    local -r version="$1"
    local -r boxFile="windows-11-arm64-vmware.box"

    # Bring up the vagrant environment and package it
    vagrant up --provider vmware_desktop
    vagrant package --output "${boxFile}"

    # Authenticate to HCP
    hcp auth login --client-id="${HPC_CLIENT_ID}" --client-secret="${HPC_CLIENT_SECRET}"

    # Export tokens for use in subsequent commands
    export VAGRANT_CLOUD_TOKEN="$(hcp auth print-access-token)" # Just for compatibility with Vagrant Cloud, can be removed in the future.
    export HPC_TOKEN="${VAGRANT_CLOUD_TOKEN}"  # Use the same token if applicable

    # Calculate the checksum for the box file
    local -r boxChecksum="$(sha512sum "${boxFile}" | cut -d ' ' -f 1)"

    # Publish the box to Vagrant Cloud
    vagrant cloud publish \
        --architecture arm64 \
        --force \
        --checksum "${boxChecksum}" \
        --checksum-type sha512 \
        --direct-upload \
        --default-architecture \
        apter-tech/windows-11-arm64 "${version}" vmware_desktop "${boxFile}"

    # Cleanup environment variables
    unset VAGRANT_CLOUD_TOKEN
    unset HPC_TOKEN
}

downloadBaseBox
packageAndUploadBox "$1"