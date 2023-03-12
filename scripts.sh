#!/bin/bash

# The Build Script by Advaith Bhat

# Copyright (C) 2021-2023 github.com/Aston-martinn

# Licensed under the GNU General Public License, Version 3.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

# https://github.com/Aston-Martinn/Scripts//blob/master/LICENSE

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Colours
blue='\033[0;34m'
cyan='\033[0;36m'
yellow='\033[0;33m'
red='\033[0;31m'
green='\033[32m'
nocol='\033[0m'

# Print Aston-martinn
echo ""
echo ""
echo -e "$red  █████╗ ███████╗████████╗ ██████╗ ███╗   ██╗      ███╗   ███╗ █████╗ ██████╗ ████████╗██╗███╗   ██╗███╗   ██╗$nocol"
echo -e "$red ██╔══██╗██╔════╝╚══██╔══╝██╔═══██╗████╗  ██║      ████╗ ████║██╔══██╗██╔══██╗╚══██╔══╝██║████╗  ██║████╗  ██║$nocol"
echo -e "$red ███████║███████╗   ██║   ██║   ██║██╔██╗ ██║█████╗██╔████╔██║███████║██████╔╝   ██║   ██║██╔██╗ ██║██╔██╗ ██║$nocol"
echo -e "$red ██╔══██║╚════██║   ██║   ██║   ██║██║╚██╗██║╚════╝██║╚██╔╝██║██╔══██║██╔══██╗   ██║   ██║██║╚██╗██║██║╚██╗██║$nocol"
echo -e "$red ██║  ██║███████║   ██║   ╚██████╔╝██║ ╚████║      ██║ ╚═╝ ██║██║  ██║██║  ██║   ██║   ██║██║ ╚████║██║ ╚████║$nocol"
echo -e "$red ╚═╝  ╚═╝╚══════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═══╝      ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝╚═╝  ╚═══╝╚═╝  ╚═══╝$nocol"
echo ""
echo ""

# Print Usages
function usages () {
    echo ""
    echo ""
    echo -e "==================== Usages ===================="
    echo -e "mega -> Install Mega on your Server"
    echo -e "synctenx -> Sync TenX-OS in your Server"
    echo -e "systemui -> Compiles SystemUI Only!"
    echo -e "settings -> Compiles Settings Only!"
    echo -e "compiletenx -> Compiles TenX-OS"
    echo -e "pushbuild -> Pushes your build to Mega Server"
    echo ""
    echo ""
    echo -e "Example: bash scripts.sh mega"
    echo -e "================================================"
}

# Install mega
mega () {
    echo -e "Checking for Mega..."
    if [[ -f /usr/local/bin/rmega-up ]];
    then
        echo -e "Mega is already installed in your Server!"
    else
        echo -e "Mega is not installed"
        echo -e "Installing Mega"
        sudo apt-get install ruby gem > /dev/null
        sudo gem install rmega > /dev/null
        echo "Mega is succussfully Installed, Enjoy...!"
    fi
    [[ "$@" ]] && echo "options: $@"
}

# Sync TenX-OS
synctenx () {
    echo -e "Syncing TenX-OS into /10x Directory"
    [[ "$@" ]] && echo "options: $@"
}

# Compile SystemUI
systemui () {
    echo -e "Compiling SystemUI"
    [[ "$@" ]] && echo "options: $@"
}

# Compile Settings
settings () {
    echo -e "Compiling Settings"
    [[ "$@" ]] && echo "options: $@"
}

# Compile Tenx-OS
compiletenx () {
    echo -e "Compiling TenX-OS"
    [[ "$@" ]] && echo "options: $@"
}

# Push Build to Mega
pushbuild () {
    echo -e "Pushing the build to Mega Server"
    [[ "$@" ]] && echo "options: $@"
}

# Push SystemUI
pushsystemui () {
    echo -e "Pushing SystemUI to Mega Server"
    [[ "$@" ]] && echo "options: $@"
}

# Push Settings
pushsettings () {
    echo -e "Pushing Settings to Mega Server"
    [[ "$@" ]] && echo "options: $@"
}

# Clone device trees
devicetrees () {
    echo -e "Cloning Device Trees"
    echo ""
    clone_devicetree
    echo ""
    common_tree
    echo ""
    kernel_tree
    echo ""
    vendor_tree
    [[ "$@" ]] && echo "options: $@"
}

# Make clean
makeclean () {
    echo -e "Making a Clean Build"
    [[ "$@" ]] && echo "options: $@"
}

# Make dirty
makedirty () {
    echo -e "Making a Dirty Build"
    [[ "$@" ]] && echo "options: $@"
}

function clone_devicetree() {
    echo -e "Enter Device Tree Link"
    read device
    device=$(echo ${device} | cut -d@ -f2 | cut -d/ -f2- | cut -d/ -f2- | cut -d. -f2 | cut -d/ -f2- | cut -d/ -f2- | cut -d? -f1)
    path=${device//_/\/}
    echo ""

    if [ -z $device ]; then
        echo -e "Input cannot be Null. Please provide an Input!"
        echo ""
        clone_devicetree
    fi

    n=0
    while read -n1 character;
    do
        n=$((n+1));
    done < <(echo -n "$path")

    if [ $n -gt 28 ]; then
        final_path=$(echo ${device} | cut -d. -f2 | cut -d_ -f2- | cut -d? -f1)
        final_device_path=${final_path//_/\/}
        echo -e "$green Your Device Path is :$nocol $final_device_path"
    else
        final_device=${device//_/\/}
        echo -e "$green Your Device Path is :$nocol $final_device$nocol"
    fi

    if [ $n -gt 28 ]; then
        codename=$(echo ${device} | cut -d@ -f2 | cut -d/ -f2- | cut -d/ -f2- | cut -d. -f2 | cut -d/ -f2- | cut -d/ -f2- | cut -d_ -f2- | cut -d_ -f2- | cut -d_ -f2 | cut -d? -f1)
    else
        codename=$(echo ${device} | cut -d@ -f2 | cut -d/ -f2- | cut -d/ -f2- | cut -d. -f2 | cut -d/ -f2- | cut -d/ -f2- | cut -d_ -f2- | cut -d_ -f2- | cut -d? -f1)
    fi
    echo -e "$green Your Device Codename is :$nocol $codename$nocol"
}

function common_tree () {
    echo -e "Enter Common Device Tree link if Exists"
    read commondevice
    common_dev=$(echo ${commondevice} | cut -d@ -f2 | cut -d/ -f2- | cut -d/ -f2- | cut -d. -f2 | cut -d/ -f2- | cut -d/ -f2- | cut -d? -f1)
    common_p=${common_dev//_/\/}
    echo ""
    echo -e "$common_p"

    n=0
    while read -n1 character;
    do
        n=$((n+1));
    done < <(echo -n "$common_p")

    if [ $n -gt 28 ]; then
        final_common_p=$(echo ${common_dev} | cut -d. -f2 | cut -d_ -f2- | cut -d? -f1)
        final_common_path=${final_common_p//_/\/}
        echo "$final_common_p"
        echo "$final_common_path"
    else
        final_common=${common_dev//_/\/}
        echo "$final_common"
    fi
}

function kernel_tree () {
    echo -e "Enter Kernel Tree link"
    read kernel
    kernelpath=$(echo ${kernel} | cut -d@ -f2 | cut -d/ -f2- | cut -d/ -f2- | cut -d. -f2 | cut -d/ -f2- | cut -d/ -f2- | cut -d? -f1)
    kernel_p=${kernelpath//_/\/}
    echo ""
    echo -e "$kernel_p"

    if [ -z $kernel ]; then
        echo -e "Input cannot be Null. Please provide an Input!"
        echo ""
        kernel_tree
    fi

    n=0
    while read -n1 character;
    do
        n=$((n+1));
    done < <(echo -n "$kernel_p")

    if [ $n -gt 25 ]; then
        final_kernel_p=$(echo ${kernelpath} | cut -d. -f2 | cut -d_ -f2- | cut -d? -f1)
        final_kernel_path=${final_kernel_p//_/\/}
        echo "$final_kernel_p"
        echo "$final_kernel_path"
    else
        final_kernel=${kernelpath//_/\/}
        echo "$final_kernel"
    fi
}

function vendor_tree () {
    echo -e "Enter Vendor Tree Link"
    read vendor
    vendorpath=$(echo ${vendor} | cut -d@ -f2 | cut -d/ -f2- | cut -d/ -f2- | cut -d. -f2 | cut -d/ -f2- | cut -d/ -f2- | cut -d? -f1)
    vendor_p=${vendorpath//_/\/}
    echo ""
    echo -e "$vendor_p"

    if [ -z $vendor ]; then
        echo -e "Input cannot be Null. Please provide an Input!"
        echo ""
        vendor_tree
    fi

    n=0
    while read -n1 character;
    do
        n=$((n+1));
    done < <(echo -n "$vendor_p")

    if [ $n -gt 28 ]; then
        final_vendor_p=$(echo ${vendorpath} | cut -d. -f2 | cut -d_ -f2- | cut -d? -f1)
        final_vendor_path=${final_vendor_p//_/\/}
        echo "$final_vendor_p"
        echo "$final_vendor_path"
    else
        final_vendor=${vendorpath//_/\/}
        echo "$final_vendor"
    fi
}

function common_vendor_tree () {
    echo -e "Enter Common Vendor Tree Link if Exists"
    read commonvendor
    commonvendorpath=$(echo ${commonvendor} | cut -d@ -f2 | cut -d/ -f2- | cut -d/ -f2- | cut -d. -f2 | cut -d/ -f2- | cut -d/ -f2- | cut -d? -f1)
    common_vendor_p=${commonvendorpath//_/\/}
    echo ""
    echo -e "$common_vendor_p"

    n=0
    while read -n1 character;
    do
        n=$((n+1));
    done < <(echo -n "$common_vendor_p")

    if [ $n -gt 28 ]; then
        final_common_vendor_p=$(echo ${commonvendorpath} | cut -d. -f2 | cut -d_ -f2- | cut -d? -f1)
        final_common_vendor_path=${final_common_vendor_p//_/\/}
        echo "$final_common_vendor_p"
        echo "$final_common_vendor_path"
    else
        final_common_vendor=${commonvendorpath//_/\/}
        echo "$final_common_vendor"
    fi
}

case $1 in
    pushsystemui)    "$@"; exit;;
    pushsettings)    "$@"; exit;;
    compiletenx)     "$@"; exit;;
    devicetrees)     "$@"; exit;;
    pushbuild)       "$@"; exit;;
    synctenx)        "$@"; exit;;
    systemui)        "$@"; exit;;
    settings)        "$@"; exit;;
    mega)            "$@"; exit;;
esac

usages
