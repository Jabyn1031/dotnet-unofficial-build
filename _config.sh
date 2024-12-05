#!/bin/bash
# shellcheck disable=SC2034  # the file is meant to be sourced so no exports needed

# shellcheck disable=SC1091  # this is up to the user
[[ -e .envrc ]] && . .envrc

ROOTFS_GLIBC_IMAGE_TAG="ghcr.io/loongson-community/dotnet-unofficial-build-rootfs:e0a68f5b86f8-20240904T171513Z"
ROOTFS_MUSL_IMAGE_TAG="ghcr.io/loongson-community/dotnet-unofficial-build-rootfs:95f50458d71c-20241122T091814Z-musl"

DOTNET_VMR_BRANCH="main-9.x-loong"
DOTNET_VMR_REPO=https://github.com/loongson-community/dotnet.git

# For the dotnet build system
# see https://github.com/dotnet/runtime/issues/35727
STAGE2_EXTRA_CFLAGS="-O2 -pipe -march=la64v1.0 -mtls-dialect=desc"
STAGE2_EXTRA_CXXFLAGS="$STAGE2_EXTRA_CFLAGS"
STAGE2_EXTRA_LDFLAGS="-Wl,-O1 -Wl,--as-needed -Wl,-z,pack-relative-relocs -Wl,--hash-style=gnu"

# it may be better to align with dotnet upstream that still sticks with gzip
# so far
# the size savings are not very significant anyway with today's network
# bandwidth
REPACK_TARBALLS=false
