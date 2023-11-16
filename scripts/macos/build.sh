pushd ../../build

NUMBER_OF_PROCESSORS=`sysctl -n hw.physicalcpu`

cmake \
  --build . \
  --parallel $NUMBER_OF_PROCESSORS

popd
