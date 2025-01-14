#!/QOpenSys/usr/bin/qsh
#----------------------------------------------------------------
# Script name: getrepo-mbsrcarc.sh
# Author: Richard Schoen
# Purpose: Get MBSRCARC repo and build the QSHONI library.
# **WARNING** - Make sure to back up existing MBSRCARC library instances 
#               before running build.sh
#               Existing MBSRCARC library will be cleared by build.sh
#----------------------------------------------------------------
INSTALLTEMP="/tmp"
INSTALLIFS="/tmp/ibmi-srcarcifs"
REPONAME="https://github.com/richardschoen/ibmi-srcarcifs.git"

# Create temp download IFS location
mkdir ${INSTALLTEMP}
cd /${INSTALLTEMP}
# Clone the repo via git to temporary download location
git -c http.sslVerify=false clone --recurse-submodules ${REPONAME}

# Change to IFS temp download directory for repo and call build.sh to create library
cd ${INSTALLIFS}
bash build.sh
# After installation you can manually delete the IFS directory /tmp/QshOni
