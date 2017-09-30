#!/bin/bash

export ROOT_PIDS=()
export FLAVORS=("minecraft")

build() {
  for flavor in ${FLAVORS[*]};
  do
    FULL_IMAGE="softsrv/minecraft:$version"
    echo "building image: $FULL_IMAGE"
    pushd $flavor
    ./build.sh &
    ROOT_PIDS[${i}]=$!
    popd
  done

  for pid in ${ROOT_PIDS[*]};
  do
    echo "waiting on process $pid"
    wait $pid
    echo "Process $pid exited with status $?"
  done
}

build
