#!/usr/bin/env sh
set -e
DIR=~/Downloads
MIRROR=https://github.com/PowerShell/PowerShell/releases/download

dl() {
    local ver=$1
    local lhashes=$2
    local os=$3
    local arch=$4
    local archive_type=${5:-tar.gz}

    local platform="${os}-${arch}"

    local infix=powershell
    if [ "${os}" = "win" ];
    then
        infix=PowerShell
    fi

    # https://github.com/PowerShell/PowerShell/releases/download/v7.4.0/powershell-7.4.0-linux-musl-x64.tar.gz
    # https://github.com/PowerShell/PowerShell/releases/download/v7.4.0/PowerShell-7.4.0-win-x64.zip
    local f="${infix}-${ver}-${platform}.${archive_type}"
    local url=${MIRROR}/v${ver}/$f

    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform $(grep -e "$f" $lhashes | awk '{ print $1 }')
}

dl_ver() {
    local ver=$1

    # https://github.com/PowerShell/PowerShell/releases/download/v7.4.0/hashes.sha256
    hashes_url=${MIRROR}/v${ver}/hashes.sha256
    lhashes=${DIR}/powershell-${ver}-hashes.sha256
    if [ ! -e $lhashes ];
    then
        curl -sSLf -o $lhashes $hashes_url
    fi

    printf "  # %s\n" $hashes_url
    printf "  '%s':\n" $ver

    dl $ver $lhashes linux musl-x64
    dl $ver $lhashes linux arm32
    dl $ver $lhashes linux arm64
    dl $ver $lhashes linux x64
    dl $ver $lhashes osx x64
    dl $ver $lhashes win arm64 zip
    dl $ver $lhashes win x64 zip
    dl $ver $lhashes win x86 zip
}

dl_ver ${1:-7.4.0}
