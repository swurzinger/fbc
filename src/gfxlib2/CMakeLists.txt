cmake_minimum_required(VERSION 3.10)
project(gfxlib2 VERSION 1.0.5 LANGUAGES C ASM)

if (CMAKE_SYSTEM_NAME MATCHES "CYGWIN.*")
  set(TARGET_OS "cygwin" CACHE LIST "Target operating system")
elseif (WIN32)
  set(TARGET_OS "win32" CACHE LIST "Target operating system")
elseif(APPLE) 
  set(TARGET_OS "darwin" CACHE LIST "Target operating system")
elseif(UNIX)
  if (CMAKE_SYSTEM_NAME STREQUAL "Linux")
    set(TARGET_OS "linux" CACHE LIST "Target operating system")
  elseif (CMAKE_SYSTEM_NAME MATCHES "FreeBSD")
    set(TARGET_OS "freebsd" CACHE LIST "Target operating system")
  elseif (CMAKE_SYSTEM_NAME STREQUAL "NetBSD")
    set(TARGET_OS "netbsd" CACHE LIST "Target operating system")
  elseif (CMAKE_SYSTEM_NAME STREQUAL "OpenBSD")
    set(TARGET_OS "openbsd" CACHE LIST "Target operating system")
  elseif (CMAKE_SYSTEM_NAME MATCHES "(Solaris|SunOS)")
    set(TARGET_OS "solaris" CACHE LIST "Target operating system")
  endif()
endif()
set_property(CACHE TARGET_OS PROPERTY STRINGS "dos" "linux" "win32" "darwin" "cygwin" "freebsd" "openbsd" "netbsd" "solaris" "xbox")


if(CMAKE_SIZEOF_VOID_P EQUAL 8)
  set(TARGET_ARCH "x86_64" CACHE STRING "Target architecture")
elseif(CMAKE_SIZEOF_VOID_P EQUAL 4)
  set(TARGET_ARCH "x86" CACHE STRING "Target architecture")
endif()
set_property(CACHE TARGET_ARCH PROPERTY STRINGS "x86" "x86_64")


set(ENABLE_MT "YES" CACHE BOOL "Enable thread-safety")
if (ENABLE_MT)
  add_compile_definitions(ENABLE_MT)
endif()



add_library(gfxlib2)

#Add an alias so that library can be used inside the build tree, e.g. when testing
add_library(FreeBasic::gfxlib2 ALIAS gfxlib2)


list(APPEND sources 
  gfx_access.c
  gfx_blitter.c
  gfx_bload.c
  gfx_box.c
  gfx_bsave.c
  gfx_circle.c
  gfx_cls.c
  gfx_color.c
  gfx_control.c
  gfx_core.c
  gfx_data.c
  gfx_draw.c
  gfx_drawstring.c
  gfx_driver_null.c
  gfx_event.c
  gfx_get.c
  gfx_getmouse.c
  gfx_image.c
  gfx_image_convert.c
  gfx_image_info.c
  gfx_inkey.c
  gfx_line.c
  gfx_lineinp.c
  gfx_lineinp_wstr.c
  gfx_lzw.c
  gfx_lzw_enc.c
  gfx_multikey.c
  gfx_opengl.c
  gfx_page.c
  gfx_paint.c
  gfx_palette.c
  gfx_paletteget.c
  gfx_paletteget64.c
  gfx_palettegetusing.c
  gfx_palettegetusing64.c
  gfx_paletteusing.c
  gfx_paletteusing64.c
  gfx_pmap.c
  gfx_point.c
  gfx_print.c
  gfx_print_wstr.c
  gfx_pset.c
  gfx_put.c
  gfx_put_add.c
  gfx_put_alpha.c
  gfx_put_and.c
  gfx_put_blend.c
  gfx_put_custom.c
  gfx_put_or.c
  gfx_put_preset.c
  gfx_put_pset.c
  gfx_put_trans.c
  gfx_put_xor.c
  gfx_readstr.c
  gfx_readxy.c
  gfx_screen.c
  gfx_screeninfo.c
  gfx_screenlist.c
  gfx_setmouse.c
  gfx_sleep.c
  gfx_softcursor.c
  gfx_stick.c
  gfx_vars.c
  gfx_vgaemu.c
  gfx_view.c
  gfx_vsync.c
  gfx_width.c
  gfx_window.c
)

if (TARGET_ARCH STREQUAL "x86")
list(APPEND sources_arch
  x86/gfx_blitter_mmx.s
  x86/gfx_mmx.s
  x86/gfx_put_add_mmx.s
  x86/gfx_put_alpha_mmx.s
  x86/gfx_put_and_mmx.s
  x86/gfx_put_blend_mmx.s
  x86/gfx_put_or_mmx.s
  x86/gfx_put_preset_mmx.s
  x86/gfx_put_pset_mmx.s
  x86/gfx_put_trans_mmx.s
  x86/gfx_put_xor_mmx.s
)
endif()


list(APPEND headers_priv 
  gfxdata_inline.h
)

list(APPEND headers
  fb_gfx.h
  fb_gfx_gl.h
  fb_gfx_lzw.h
)


if ("${TARGET_OS}" MATCHES "^(win32|cygwin)$")
list(APPEND sources_os
  win32/gfx_driver_ddraw.c
  win32/gfx_driver_gdi.c
  win32/gfx_driver_opengl.c
  win32/gfx_joystick.c
  win32/gfx_win32.c
)
elseif (TARGET_OS STREQUAL "dos")
list(APPEND sources_os
  dos/gfx_dos.c
  dos/gfx_driver_bios.c
  dos/gfx_driver_modex.c
  dos/gfx_driver_vesa_bnk.c
  dos/gfx_driver_vesa_lin.c
  dos/gfx_driver_vga.c
  dos/gfx_joystick.c
  dos/gfx_vesa_core.c
  dos/gfx_mouse.s
  dos/gfx_vesa.s
)
elseif (TARGET_OS STREQUAL "darwin")
list(APPEND sources_os
  darwin/sys_getexename.c
  darwin/sys_getexepath.c
)
elseif (TARGET_OS STREQUAL "freebsd")
list(APPEND sources_os
  freebsd/gfx_joystick.c
)
elseif (TARGET_OS STREQUAL "linux")
list(APPEND sources_os
  linux/gfx_driver_fbdev.c
  linux/gfx_joystick.c
)
elseif (TARGET_OS STREQUAL "netbsd")
list(APPEND sources_os
  netbsd/io_mouse.c
  netbsd/io_multikey.c
  netbsd/io_serial.c
  netbsd/sys_fmem.c
  netbsd/sys_getexename.c
  netbsd/sys_getexepath.c
)
elseif (TARGET_OS STREQUAL "openbsd")
list(APPEND sources_os
  openbsd/gfx_joystick.c
)
elseif (TARGET_OS STREQUAL "solaris")
list(APPEND sources_os
  solaris/sys_getexename.c
  solaris/sys_getexepath.c
)
elseif (TARGET_OS STREQUAL "xbox")
list(APPEND sources_os
  xbox/gfx_driver.c
)
endif()

if ("${TARGET_OS}" MATCHES "^(darwin|freebsd|linux|netbsd|openbsd|solaris)$")
list(APPEND sources_os
  unix/gfx_driver_opengl_x11.c
  unix/gfx_driver_x11.c
  unix/gfx_unix.c
  unix/gfx_x11.c
  unix/gfx_x11_icon_stub.c
)
endif()



target_sources(gfxlib2
  PRIVATE
    ${sources}
    ${headers_priv}
    ${sources_os}
    ${sources_arch}
  #PUBLIC
    ${headers}
)


source_group(${TARGET_OS} FILES ${sources_os})
source_group(${TARGET_ARCH} FILES ${sources_arch})



#Set target properties
target_include_directories(gfxlib2
    PUBLIC
        $<INSTALL_INTERFACE:.>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/.>
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/.
)

#target_compile_features(jsonutils PRIVATE cxx_auto_type)
#target_compile_options(jsonutils PRIVATE $<$<CXX_COMPILER_ID:GNU>:-Wall>)
#
#target_link_libraries(jsonutils
#    PUBLIC
#        Boost::boost RapidJSON::RapidJSON
#    PRIVATE
#        Boost::regex
#)
#
###############################################
## Installation instructions
#
#include(GNUInstallDirs)
#set(INSTALL_CONFIGDIR ${CMAKE_INSTALL_LIBDIR}/cmake/JSONUtils)
#
#install(TARGETS jsonutils
#    EXPORT jsonutils-targets
#    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
#    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
#)
#
##This is required so that the exported target has the name JSONUtils and not jsonutils
#set_target_properties(jsonutils PROPERTIES EXPORT_NAME JSONUtils)
#
#install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
#
##Export the targets to a script
#install(EXPORT jsonutils-targets
#  FILE
#    JSONUtilsTargets.cmake
#  NAMESPACE
#    JSONUtils::
#  DESTINATION
#    ${INSTALL_CONFIGDIR}
#)
#
##Create a ConfigVersion.cmake file
#include(CMakePackageConfigHelpers)
#write_basic_package_version_file(
#    ${CMAKE_CURRENT_BINARY_DIR}/JSONUtilsConfigVersion.cmake
#    VERSION ${PROJECT_VERSION}
#    COMPATIBILITY AnyNewerVersion
#)
#
#configure_package_config_file(${CMAKE_CURRENT_LIST_DIR}/cmake/JSONUtilsConfig.cmake.in
#    ${CMAKE_CURRENT_BINARY_DIR}/JSONUtilsConfig.cmake
#    INSTALL_DESTINATION ${INSTALL_CONFIGDIR}
#)
#
##Install the config, configversion and custom find modules
#install(FILES
#    ${CMAKE_CURRENT_LIST_DIR}/cmake/FindRapidJSON.cmake
#    ${CMAKE_CURRENT_BINARY_DIR}/JSONUtilsConfig.cmake
#    ${CMAKE_CURRENT_BINARY_DIR}/JSONUtilsConfigVersion.cmake
#    DESTINATION ${INSTALL_CONFIGDIR}
#)
#
###############################################
### Exporting from the build tree
#configure_file(${CMAKE_CURRENT_LIST_DIR}/cmake/FindRapidJSON.cmake
#    ${CMAKE_CURRENT_BINARY_DIR}/FindRapidJSON.cmake
#    COPYONLY)
#
#export(EXPORT jsonutils-targets FILE ${CMAKE_CURRENT_BINARY_DIR}/JSONUtilsTargets.cmake NAMESPACE JSONUtils::)
#
##Register package in user's package registry
#export(PACKAGE JSONUtils)
#
