pushd ../..

cmake \
  -B build-osx \
  -G Xcode \
  .

popd
