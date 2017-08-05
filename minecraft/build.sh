#!/bin/bash

export PIDS=()
export VERSIONS=(1.11.2 1.12)

build() {
  for version in ${VERSIONS[*]};
  do
    FULL_IMAGE="softsrv/minecraft:$version"
    echo "building image: $FULL_IMAGE"
    pushd versions/$version
    docker build -t $FULL_IMAGE . &
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

test() {
  echo "future: make sure images boot"
}

push() {
  for version in ${VERSIONS[*]};
  do
    FULL_IMAGE="softsrv/minecraft:$version"
    echo "pushing image: $FULL_IMAGE"
    docker push $FULL_IMAGE &
    PIDS[${i}]=$!
    echo "versionName=$version" >> $JOB_STATE/minecraft_img_$version.env
    echo "commitSha=$COMMIT" >> $JOB_STATE/minecraft_img_$version.env
    echo "buildNumber=$BUILD_NUMBER" >> $JOB_STATE/minecraft_img_$version.env
  done

  for pid in ${PIDS[*]};
  do
    echo "waiting on process $pid"
    wait $pid
    echo "Process $pid exited with status $?"
  done
}

build
test
push
