#!/bin/bash

if [ ! -d "assets" ]; then
  echo "===== Copy asset Files ====="
  mkdir -p assets/shaders/base
  cp -r ../../data/shaders/base/*.spv assets/shaders/base


  mkdir -p assets/shaders/bloom
  cp -r ../../data/shaders/bloom/*.spv assets/shaders/bloom

  mkdir -p assets/textures
  cp ../../data/textures/cubemap_space.ktx assets/textures

  mkdir -p assets/models
  cp ../../data/models/retroufo.dae assets/models
  cp ../../data/models/retroufo_glow.dae assets/models
  cp ../../data/models/cube.obj assets/models
fi

if [ ! -d "res" ]; then
  echo "===== Copy res Files ====="
  mkdir -p res/drawable
  cp ../../android/images/icon.png res/drawable
fi

# Make sure you have android & ndk-build in your PATH

echo "===== Update android API ====="
android update project -p . -t android-23

echo "===== Configure and build ====="
NDK_DEBUG=1 ndk-build
ant debug -Dout.final.file=vulkanBloom.apk

echo "===== Install ====="
adb install -r vulkanBloom.apk
