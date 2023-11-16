# add gstreamer library

# On Windows
# Download and install gstreamer from official site to C:\gstreamer

# On macOS
# Install Homebrew
# Install gstreamer using this commands:
# `brew install pkg-config`
# `brew install gstreamer`

if(USE_GSTREAMER)

  # TODO: check correct path, before use
  if(WIN32)

    set(GST_ROOT_DIR "C:/gstreamer/1.0/msvc_x86_64")
    set(GST_LIB_DIR "${GST_ROOT_DIR}/lib")
    set(GST_INCLUDE_DIR "${GST_ROOT_DIR}/include")

    if(MSVC)
      file(GLOB_RECURSE gst_files ${GST_LIB_DIR}/*dll.a)
    else()
      file(GLOB_RECURSE gst_files ${GST_LIB_DIR}/*.lib)
    endif()

    set(GST_INCLUDE_DIRS
      ${GST_INCLUDE_DIR}/gstreamer-1.0
      ${GST_INCLUDE_DIR}/glib-2.0
      ${GST_LIB_DIR}/glib-2.0/include
      ${GST_LIB_DIR}/gstreamer-1.0/include
    )
    set(GST_LINK_LIBRARIES ${gst_files} ${glib_files})
    set(GST_FLAGS "")
  
  endif() # WIN32

  if(APPLE)

    # Required for GStreamer
    find_package(PkgConfig)

    # Look for GStreamer installation
    pkg_check_modules(GST REQUIRED gstreamer-1.0)

  endif() # APPLE

  target_include_directories(Cpp-CMake-Template PUBLIC ${GST_INCLUDE_DIRS})
  target_compile_options(Cpp-CMake-Template PUBLIC ${GST_CFLAGS})
  target_link_libraries(Cpp-CMake-Template PUBLIC ${GST_LINK_LIBRARIES})

  target_compile_definitions(Cpp-CMake-Template PRIVATE "USE_GSTREAMER")

endif() # USE_GSTREAMER
