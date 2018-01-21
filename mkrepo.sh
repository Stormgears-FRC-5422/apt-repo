#!/bin/bash

WD=$(dirname $0)
[ "$WD" == "." ] && WD=$PWD

BASE=$WD/stormgears/frc2018/raspbian
DIST=jessie
COMPONENT="main"

ARCH="armhf"

for component in $COMPONENT; do
  override=$BASE/indices/override.${DIST}.${component}
  touch $override
  for arch in $ARCH; do
    cd $BASE && \
    dpkg-scanpackages dists/$DIST/$component/binary-$arch $override \
      | gzip -9 > dists/$DIST/$component/binary-$arch/Packages.gz
    cd $BASE/dists/$DIST/$component && \
    ln -sf binary-$arch/Packages.gz .
  done
done


