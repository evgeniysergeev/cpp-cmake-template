pushd ../..

NUMBER_OF_PROCESSORS=`sysctl -n hw.physicalcpu`

cmake \
  --build ./build \
  --parallel $NUMBER_OF_PROCESSORS

popd
