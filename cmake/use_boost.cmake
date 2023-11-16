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

  set(Boost_USE_MULTITHREADED  ON)
  set(Boost_USE_STATIC_LIBS    ON)
  set(Boost_USE_STATIC_RUNTIME OFF)

  if (DEBUG_BOOST_CMAKE)
    set(Boost_DEBUG ON)
  else()
    set(Boost_VERBOSE ON)
  endif()

  find_package(Boost COMPONENTS program_options REQUIRED)

  if(Boost_FOUND)
    if(DEBUG_BOOST_CMAKE)
      message("Boost_LIBRARY_DIRS is set to: ${Boost_LIBRARY_DIRS}")
      message("Boost_INCLUDE_DIRS is set to: ${Boost_INCLUDE_DIRS}")
    endif()

    target_include_directories(Cpp-CMake-Template PUBLIC ${Boost_INCLUDE_DIRS})
    link_directories(${Boost_LIBRARY_DIRS})
    add_definitions(${Boost_DEFINITIONS})
    target_link_libraries(Cpp-CMake-Template PUBLIC Boost::program_options)

    target_compile_definitions(Cpp-CMake-Template PRIVATE "USE_BOOST")

  endif() # Boost_FOUND

endif() # USE_BOOST
