#!/bin/bash

export PIDS=()
export FLAVORS=("minecraft")

build() {
  for flavor in ${FLAVORS[*]};
  do
    FULL_IMAGE="softsrv/minecraft:$version"
    echo "building image: $FULL_IMAGE"
    pushd $flavor
    ./build.sh &
    PIDS[${i}]=$!
    popd
  done

  for pid in ${PIDS[*]};
  do
    echo "waiting on process $pid"
    wait $pid
    echo "Process $pid exited with status $?"
  done
}

build
