# add gstreamer library

if(USE_GSTREAMER)

  # TODO: check correct path, before use
  set(GSTREAMER_ROOT_DIR "C:/gstreamer/1.0/msvc_x86_64")

  if(MSVC)
    file(
      GLOB_RECURSE
      gst_files
      ${GSTREAMER_ROOT_DIR}/lib/*dll.a
    )
  else()
    file(
      GLOB_RECURSE
      gst_files
      ${GSTREAMER_ROOT_DIR}/lib/*.lib
    )
  endif()

  set(GSTREAMER_INCLUDE_DIRS
    ${GSTREAMER_ROOT_DIR}/include/gstreamer-1.0
    ${GSTREAMER_ROOT_DIR}/include/glib-2.0
    ${GSTREAMER_ROOT_DIR}/lib/glib-2.0/include
    ${GSTREAMER_ROOT_DIR}/lib/gstreamer-1.0/include
  )
  target_include_directories(Cpp-CMake-Template PUBLIC ${GSTREAMER_INCLUDE_DIRS})

  set(GSTREAMER_LIBRARIES ${gst_files})
  target_link_libraries (Cpp-CMake-Template PUBLIC ${GSTREAMER_LIBRARIES})

  target_compile_definitions(Cpp-CMake-Template PRIVATE "USE_GSTREAMER")

endif()
