pushd ..\..

cmake ^
  --build .\build-win ^
  --parallel %NUMBER_OF_PROCESSORS%

popd
