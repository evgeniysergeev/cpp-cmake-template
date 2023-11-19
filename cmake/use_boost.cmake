# add boost library

if(USE_BOOST)

  # build boost using this command:
  # cd C:\Boost\boost_1_83_0
  # cd tools\build
  # bootstrap.bat
  # b2 --prefix=C:\Boost\boost_1_83_0\b2
  # add environment variable BOOST_ROOT=C:\Boost
  # and add to PATH C:\Boost\boost_1_83_0\b2
  # check that cmake is not from mingw installation using command: where cmake
  # check the same for b2: where b2
  # cd C:\Boost\boost_1_83_0
  # b2 -j8 variant=debug,release link=shared,static threading=single,multi runtime-link=shared,static address-model=32,64
  # now go to project directory to scripts\windows and check using generate.bat and build.bat scripts

  option(DEBUG_BOOST_CMAKE "Debug how Boost is added to CMake" OFF)

  # This possibly can be useful if MinGW installed on Windows machine, but you want to use another Boost
  #set(Boost_NO_BOOST_CMAKE ON)

  set(Boost_USE_MULTITHREADED ON)
  set(Boost_USE_STATIC_LIBS ON)
  set(Boost_USE_STATIC_RUNTIME OFF)

  if(DEBUG_BOOST_CMAKE)
    set(Boost_DEBUG ON)
  else()
    set(Boost_VERBOSE ON)
  endif()

  find_package(Boost COMPONENTS program_options REQUIRED)
  find_package(Boost COMPONENTS log log_setup REQUIRED)

  if(APPLE)
    # When building on macOS the error "-licudata library not found" is produced
    # This is ussue for that in boost repository:
    # https://github.com/boostorg/boost_install/issues/47
    #   Non-boost dependencies included in INTERFACE_LINK_LIBRARIES for shared libraries #47
    #
    #   Recently boost 1.75.0 was added to homebrew-core in Homebrew/homebrew-core#66792,
    #   after which I started noticing some failures in some of my software that links against
    #   boost (osrf/homebrew-simulation#1235) with linking errors like
    #   ld: library not found for -licudata. I believe part of the reason is that all non-Boost
    #   dependencies were added to the cmake INTERFACE_LINK_LIBRARIES in 0e39586, but this
    #   should not be necessary for libraries that use target_link_libraries with the PRIVATE
    #   keyword, such as boost_regex (the source of the problem in my case).
    #
    # This is workaround for that from the comment:
    # https://github.com/boostorg/boost_install/issues/47#issuecomment-1548879217
    #   For anyone else who stumbles on this, you can use CMake's alias targets to work around the issue:
    #   ```
    #   find_packge(Boost COMPONENTS regex REQUIRED)
    #   find_package(ICU COMPONENTS uc i18n data REQUIRED)
    #   add_library(icuuc ALIAS ICU::uc)
    #   add_library(icui18n ALIAS ICU::i18n)
    #   add_library(icudata ALIAS ICU::data)
    #   ```
    #   The above will cause CMake to point the icuuc injected by Boost to the actual location found by FindICU.

    # Also, from this link: https://copyprogramming.com/howto/could-not-open-the-icu-common-library
    # When attempting to use find_package(ICU ...) on my Mac, the same error occurred since I had installed
    # ICU via brew. This error appears to be linked to the preinstalled ICU on Mac, which lacks some components
    # causing CMake to report missing components such as ICU_INCLUDE_DIR and ICU_LIBRARY. To resolve this,
    # I specified the ICU_ROOT variable manually in CMakeLists.txt, directing CMake to utilize the brew-installed
    # ICU version rather than the MacOS preinstalled version.
    # 
    # Update this path if unable to build, because icu4c version is set here directly
    # and possibly will need to be adjusted in the future
    set (ICU_ROOT /opt/homebrew/Cellar/icu4c/73.2) 
    find_package(ICU COMPONENTS uc i18n data REQUIRED)
    add_library(icuuc ALIAS ICU::uc)
    add_library(icui18n ALIAS ICU::i18n)
    add_library(icudata ALIAS ICU::data)
  endif()

  if(Boost_FOUND)
    if(DEBUG_BOOST_CMAKE)
      message("Boost_LIBRARY_DIRS is set to: ${Boost_LIBRARY_DIRS}")
      message("Boost_INCLUDE_DIRS is set to: ${Boost_INCLUDE_DIRS}")
    endif()

    target_include_directories(Cpp-CMake-Template PUBLIC ${Boost_INCLUDE_DIRS})
    link_directories(
      ${Boost_LIBRARY_DIRS}
      "library 'icudata' not found"
    )
    add_definitions(${Boost_DEFINITIONS})
    target_link_libraries(Cpp-CMake-Template PUBLIC
      Boost::program_options
      Boost::log
      Boost::log_setup
    )

    target_compile_definitions(Cpp-CMake-Template PRIVATE "USE_BOOST")

  endif() # Boost_FOUND

endif() # USE_BOOST
