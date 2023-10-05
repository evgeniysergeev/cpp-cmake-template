pushd ../..

NUMBER_OF_PROCESSORS=`sysctl -n hw.physicalcpu`

cmake \
  --build ./build-osx \
  --parallel $NUMBER_OF_PROCESSORS

popd
