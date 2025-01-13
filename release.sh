#!/usr/bin/env sh

vagrant up

vagrant package --output windows-11-arm64.box

sha512sum windows-11-arm64.box > windows-11-arm64.box.sha512

cat windows-11-arm64.box.sha512 | bpcopy

echo "SHA512 copied to clipboard"