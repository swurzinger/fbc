cmake_minimum_required(VERSION 3.10)
project(rtlib VERSION 1.0.5 LANGUAGES C ASM)

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


set(ENABLE_FFI "YES" CACHE BOOL "Enable libffi")
if (NOT ENABLE_FFI)
  add_compile_definitions(DISABLE_FFI)
endif()

set(ENABLE_MT "YES" CACHE BOOL "Enable thread-safety")
if (ENABLE_MT)
  add_compile_definitions(ENABLE_MT)
endif()


add_library(rtlib)

#Add an alias so that library can be used inside the build tree, e.g. when testing
add_library(FreeBasic::rtlib ALIAS rtlib)


#file(GLOB sources ${CMAKE_CURRENT_SOURCE_DIR}/*.c)
#file(GLOB headers ${CMAKE_CURRENT_SOURCE_DIR}/fb_*.h)
#file(GLOB headers_priv ${CMAKE_CURRENT_SOURCE_DIR}/*.h)
#list(REMOVE_ITEM headers_priv ${headers})
#file(GLOB sources_os ${CMAKE_CURRENT_SOURCE_DIR}/${TARGET_OS}/*.c)
#file(GLOB sources_arch ${CMAKE_CURRENT_SOURCE_DIR}/${TARGET_ARCH}/*.c)

list(APPEND sources 
  array_boundchk.c
  array_clear.c
  array_clearobj.c
  array_core.c
  array_destructobj.c
  array_destructstr.c
  array_erase.c
  array_eraseobj.c
  array_erasestr.c
  array_lbound.c
  array_redim.c
  array_redimpresv.c
  array_redimpresv_obj.c
  array_redimto.c
  array_redim_obj.c
  array_resetdesc.c
  array_setdesc.c
  array_tmpdesc.c
  array_ubound.c
  con_input.c
  con_lineinp.c
  con_lineinp_wstr.c
  con_locate.c
  con_pos.c
  con_print_raw.c
  con_print_raw_wstr.c
  con_print_tty.c
  con_print_tty_wstr.c
  con_readline.c
  data.c
  data_readbool.c
  data_readbyte.c
  data_readdouble.c
  data_readint.c
  data_readlong.c
  data_readshort.c
  data_readsingle.c
  data_readstr.c
  data_readubyte.c
  data_readuint.c
  data_readulong.c
  data_readushort.c
  data_readwstr.c
  dev_com.c
  dev_com_test.c
  dev_cons_open.c
  dev_err_open.c
  dev_file_close.c
  dev_file_encod_open.c
  dev_file_encod_read.c
  dev_file_encod_readline.c
  dev_file_encod_readline_wstr.c
  dev_file_encod_read_core.c
  dev_file_encod_read_wstr.c
  dev_file_encod_write.c
  dev_file_encod_write_wstr.c
  dev_file_eof.c
  dev_file_flush.c
  dev_file_lock.c
  dev_file_open.c
  dev_file_read.c
  dev_file_readline.c
  dev_file_readline_wstr.c
  dev_file_read_wstr.c
  dev_file_seek.c
  dev_file_size.c
  dev_file_tell.c
  dev_file_unlock.c
  dev_file_write.c
  dev_file_write_wstr.c
  dev_lpt.c
  dev_lpt_close.c
  dev_lpt_test.c
  dev_lpt_write.c
  dev_lpt_write_wstr.c
  dev_pipe_close.c
  dev_pipe_open.c
  dev_scrn.c
  dev_scrn_close.c
  dev_scrn_eof.c
  dev_scrn_init.c
  dev_scrn_read.c
  dev_scrn_readline.c
  dev_scrn_readline_wstr.c
  dev_scrn_read_wstr.c
  dev_scrn_write.c
  dev_scrn_write_wstr.c
  dev_stdio_close.c
  error.c
  error_assert.c
  error_assert_wstr.c
  error_getset.c
  error_message.c
  error_ptrchk.c
  file_attr.c
  file_close.c
  file_copy_crt.c
  file_datetime.c
  file_dir64.c
  file_dirnext.c
  file_dirnext64.c
  file_encod.c
  file_eof.c
  file_exists.c
  file_free.c
  file_get.c
  file_getarray.c
  file_getstr.c
  file_get_wstr.c
  file_hconvpath.c
  file_inputstr.c
  file_input_bool.c
  file_input_byte.c
  file_input_file.c
  file_input_float.c
  file_input_int.c
  file_input_longint.c
  file_input_short.c
  file_input_str.c
  file_input_tok.c
  file_input_tok_wstr.c
  file_input_ubyte.c
  file_input_uint.c
  file_input_ulongint.c
  file_input_ushort.c
  file_input_wstr.c
  file_kill.c
  file_len.c
  file_lineinp.c
  file_lineinp_wstr.c
  file_loc.c
  file_lock.c
  file_open.c
  file_opencom.c
  file_opencons.c
  file_openencod.c
  file_openerr.c
  file_openlpt.c
  file_openpipe.c
  file_openscrn.c
  file_openshort.c
  file_print.c
  file_print_wstr.c
  file_put.c
  file_putarray.c
  file_putback.c
  file_putback_wstr.c
  file_putstr.c
  file_put_wstr.c
  file_reset.c
  file_resetex.c
  file_seek.c
  file_size.c
  file_tell.c
  file_winputstr.c
  gosub.c
  hook_cls.c
  hook_color.c
  hook_getmouse.c
  hook_getmouse64.c
  hook_getsize.c
  hook_getx.c
  hook_getxy.c
  hook_gety.c
  hook_inkey.c
  hook_isredir.c
  hook_lineinp.c
  hook_lineinp_wstr.c
  hook_locate_ex.c
  hook_multikey.c
  hook_pageset.c
  hook_pcopy.c
  hook_ports.c
  hook_printstr.c
  hook_print_wstr.c
  hook_readstr.c
  hook_readxy.c
  hook_setmouse.c
  hook_sleep.c
  hook_view_update.c
  hook_width.c
  init.c
  intl_get.c
  intl_getdateformat.c
  intl_getmonthname.c
  intl_getset.c
  intl_gettimeformat.c
  intl_getweekdayname.c
  io_hinkey.c
  io_lpos.c
  io_lprintusg.c
  io_lprintvoid.c
  io_lprint_bool.c
  io_lprint_byte.c
  io_lprint_fix.c
  io_lprint_fp.c
  io_lprint_int.c
  io_lprint_longint.c
  io_lprint_short.c
  io_lprint_str.c
  io_lprint_wstr.c
  io_print.c
  io_printpad.c
  io_printpad_wstr.c
  io_printusg.c
  io_printvoid.c
  io_printvoid_wstr.c
  io_print_bool.c
  io_print_byte.c
  io_print_fix.c
  io_print_fp.c
  io_print_int.c
  io_print_longint.c
  io_print_short.c
  io_print_wstr.c
  io_setpos.c
  io_spc.c
  io_view.c
  io_viewhlp.c
  io_widthdev.c
  io_widthfile.c
  io_writebool.c
  io_writebyte.c
  io_writefloat.c
  io_writeint.c
  io_writelongint.c
  io_writeshort.c
  io_writestr.c
  io_writevoid.c
  io_write_wstr.c
  legacy_strw_lcase.c
  legacy_strw_ucase.c
  legacy_str_lcase.c
  legacy_str_ucase.c
  list.c
  listdyn.c
  math_cvn.c
  math_fix.c
  math_frac.c
  math_log10.c
  math_rnd.c
  math_sgn.c
  mem_copyclear.c
  oop_istypeof.c
  oop_object.c
  oop_object_copyctor.c
  qb_file_open.c
  qb_inkey.c
  qb_sleep.c
  qb_str_convto.c
  qb_str_convto_flt.c
  qb_str_convto_lng.c
  scancodes.c
  signals.c
  strw_alloc.c
  strw_asc.c
  strw_assign.c
  strw_bin.c
  strw_bin_lng.c
  strw_bin_ptr.c
  strw_chr.c
  strw_comp.c
  strw_concat.c
  strw_concatassign.c
  strw_convassign.c
  strw_convconcat.c
  strw_convfrom.c
  strw_convfrom_bool.c
  strw_convfrom_int.c
  strw_convfrom_lng.c
  strw_convfrom_rad.c
  strw_convfrom_radlng.c
  strw_convfrom_str.c
  strw_convfrom_uint.c
  strw_convfrom_ulng.c
  strw_convto.c
  strw_convto_bool.c
  strw_convto_flt.c
  strw_convto_lng.c
  strw_convto_str.c
  strw_del.c
  strw_fill.c
  strw_ftoa.c
  strw_hex.c
  strw_hex_lng.c
  strw_hex_ptr.c
  strw_instr.c
  strw_instrany.c
  strw_instrrev.c
  strw_instrrevany.c
  strw_lcase.c
  strw_left.c
  strw_len.c
  strw_ltrim.c
  strw_ltrimany.c
  strw_ltrimex.c
  strw_mid.c
  strw_midassign.c
  strw_oct.c
  strw_oct_lng.c
  strw_oct_ptr.c
  strw_right.c
  strw_rtrim.c
  strw_rtrimany.c
  strw_rtrimex.c
  strw_set.c
  strw_space.c
  strw_trim.c
  strw_trimany.c
  strw_trimex.c
  strw_ucase.c
  str_asc.c
  str_assign.c
  str_base.c
  str_bin.c
  str_bin_lng.c
  str_bin_ptr.c
  str_chr.c
  str_comp.c
  str_concat.c
  str_concatassign.c
  str_convfrom.c
  str_convfrom_bool.c
  str_convfrom_int.c
  str_convfrom_lng.c
  str_convfrom_rad.c
  str_convfrom_radlng.c
  str_convfrom_uint.c
  str_convfrom_ulng.c
  str_convto.c
  str_convto_bool.c
  str_convto_flt.c
  str_convto_lng.c
  str_core.c
  str_cvmk.c
  str_del.c
  str_fill.c
  str_format.c
  str_ftoa.c
  str_hex.c
  str_hex_lng.c
  str_hex_ptr.c
  str_hskip.c
  str_instr.c
  str_instrany.c
  str_instrrev.c
  str_instrrevany.c
  str_lcase.c
  str_left.c
  str_len.c
  str_ltrim.c
  str_ltrimany.c
  str_ltrimex.c
  str_mid.c
  str_midassign.c
  str_misc.c
  str_oct.c
  str_oct_lng.c
  str_oct_ptr.c
  str_right.c
  str_rtrim.c
  str_rtrimany.c
  str_rtrimex.c
  str_set.c
  str_tempdescf.c
  str_tempdescv.c
  str_tempdescz.c
  str_tempres.c
  str_trim.c
  str_trimany.c
  str_trimex.c
  str_ucase.c
  swap_mem.c
  swap_str.c
  swap_wstr.c
  sys_cdir.c
  sys_chain.c
  sys_chdir.c
  sys_cmd.c
  sys_environ.c
  sys_exec.c
  sys_exepath.c
  sys_mkdir.c
  sys_parseargs.c
  sys_rmdir.c
  sys_run.c
  sys_shell.c
  thread_call.c
  thread_ctx.c
  time_core.c
  time_date.c
  time_dateadd.c
  time_datediff.c
  time_datepart.c
  time_dateserial.c
  time_dateset.c
  time_datevalue.c
  time_decodeserdate.c
  time_decodesertime.c
  time_isdate.c
  time_monthname.c
  time_now.c
  time_parsedate.c
  time_parsedatetime.c
  time_parsetime.c
  time_sleep.c
  time_sleepex.c
  time_time.c
  time_timeserial.c
  time_timeset.c
  time_timevalue.c
  time_week.c
  time_weekdayname.c
  utf_convfrom_char.c
  utf_convfrom_wchar.c
  utf_convto_char.c
  utf_convto_wchar.c
  utf_core.c
  vfs_open.c
)

list(APPEND headers_priv 
  con_print_raw_uni.h
  con_print_tty_uni.h
  dev_com_private.h
  io_serial_private.h
)

list(APPEND headers
  fb.h
  fb_array.h
  fb_config.h
  fb_console.h
  fb_data.h
  fb_datetime.h
  fb_device.h
  fb_error.h
  fb_file.h
  fb_gfx_private.h
  fb_hook.h
  fb_legacy.h
  fb_math.h
  fb_oop.h
  fb_print.h
  fb_printer.h
  fb_private_hdynload.h
  fb_private_thread.h
  fb_serial.h
  fb_string.h
  fb_system.h
  fb_thread.h
  fb_unicode.h
)

if (TARGET_ARCH STREQUAL "x86")
list(APPEND sources_arch
  x86/cpudetect.s
)
endif()


if ("${TARGET_OS}" MATCHES "^(win32|cygwin)$")
list(APPEND sources_os
  win32/drv_intl_get.c
  win32/drv_intl_getdateformat.c
  win32/drv_intl_getmonthname.c
  win32/drv_intl_gettimeformat.c
  win32/drv_intl_getweekdayname.c
  win32/file_copy.c
  win32/file_dir.c
  win32/file_hlock.c
  win32/file_hreset.c
  win32/hdynload.c
  win32/hinit.c
  win32/intl_core.c
  win32/io_cls.c
  win32/io_color.c
  win32/io_gethnd.c
  win32/io_getsize.c
  win32/io_getx.c
  win32/io_getxy.c
  win32/io_gety.c
  win32/io_inkey.c
  win32/io_input.c
  win32/io_isredir.c
  win32/io_locate.c
  win32/io_maxrow.c
  win32/io_mouse.c
  win32/io_multikey.c
  win32/io_pageset.c
  win32/io_pcopy.c
  win32/io_printbuff.c
  win32/io_printbuff_wstr.c
  win32/io_printer.c
  win32/io_readstr.c
  win32/io_readxy.c
  win32/io_screensize.c
  win32/io_scroll.c
  win32/io_serial.c
  win32/io_viewupdate.c
  win32/io_width.c
  win32/io_window.c
  win32/sys_beep.c
  win32/sys_delay.c
  win32/sys_dylib.c
  win32/sys_execex.c
  win32/sys_fmem.c
  win32/sys_getcwd.c
  win32/sys_getexename.c
  win32/sys_getexepath.c
  win32/sys_getshortpath.c
  win32/sys_hshell.c
  win32/sys_portio.c
  win32/thread_cond.c
  win32/thread_core.c
  win32/thread_detach.c
  win32/thread_mutex.c
  win32/time_setdate.c
  win32/time_settime.c
  win32/time_timer.c
)
elseif (TARGET_OS STREQUAL "dos")
list(APPEND sources_os
  dos/drv_intl.c
  dos/drv_intl_data.c
  dos/drv_intl_get.c
  dos/drv_intl_getdateformat.c
  dos/drv_intl_getmonthname.c
  dos/drv_intl_gettimeformat.c
  dos/drv_intl_getweekdayname.c
  dos/farmemset.c
  dos/file_copy.c
  dos/file_dir.c
  dos/file_hlock.c
  dos/file_hreset.c
  dos/hinit.c
  dos/io_cls.c
  dos/io_color.c
  dos/io_getsize.c
  dos/io_getx.c
  dos/io_getxy.c
  dos/io_gety.c
  dos/io_inkey.c
  dos/io_input.c
  dos/io_isredir.c
  dos/io_locate.c
  dos/io_maxrow.c
  dos/io_mouse.c
  dos/io_multikey.c
  dos/io_pageset.c
  dos/io_pcopy.c
  dos/io_printbuff.c
  dos/io_printbuff_wstr.c
  dos/io_printer.c
  dos/io_readstr.c
  dos/io_readxy.c
  dos/io_scroll.c
  dos/io_serial.c
  dos/io_viewupdate.c
  dos/io_width.c
  dos/sys_beep.c
  dos/sys_delay.c
  dos/sys_dylib.c
  dos/sys_execex.c
  dos/sys_fmem.c
  dos/sys_getcwd.c
  dos/sys_getexename.c
  dos/sys_getexepath.c
  dos/sys_getshortpath.c
  dos/sys_hshell.c
  dos/sys_isr.c
  dos/sys_portio.c
  dos/thread_cond.c
  dos/thread_core.c
  dos/thread_mutex.c
  dos/time_setdate.c
  dos/time_settime.c
  dos/time_timer.c
)
elseif (TARGET_OS STREQUAL "darwin")
list(APPEND sources_os
  darwin/sys_getexename.c
  darwin/sys_getexepath.c
)
elseif (TARGET_OS STREQUAL "freebsd")
list(APPEND sources_os
  freebsd/io_mouse.c
  freebsd/io_multikey.c
  freebsd/io_serial.c
  freebsd/sys_fmem.c
  freebsd/sys_getexename.c
  freebsd/sys_getexepath.c
)
elseif (TARGET_OS STREQUAL "linux")
list(APPEND sources_os
  linux/io_mouse.c
  linux/io_multikey.c
  linux/io_serial.c
  linux/sys_fmem.c
  linux/sys_getexename.c
  linux/sys_getexepath.c
  linux/sys_portio.c
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
  openbsd/io_mouse.c
  openbsd/io_multikey.c
  openbsd/io_serial.c
  openbsd/swprintf_stub.c
  openbsd/sys_fmem.c
  openbsd/sys_getexename.c
  openbsd/sys_getexepath.c
)
elseif (TARGET_OS STREQUAL "solaris")
list(APPEND sources_os
  solaris/sys_getexename.c
  solaris/sys_getexepath.c
)
elseif (TARGET_OS STREQUAL "xbox")
list(APPEND sources_os
  xbox/drv_intl_get.c
  xbox/drv_intl_getdateformat.c
  xbox/drv_intl_getmonthname.c
  xbox/drv_intl_gettimeformat.c
  xbox/drv_intl_getweekdayname.c
  xbox/file_copy.c
  xbox/file_dir.c
  xbox/file_hlock.c
  xbox/file_hreset.c
  xbox/hinit.c
  xbox/io_cls.c
  xbox/io_color.c
  xbox/io_getsize.c
  xbox/io_getx.c
  xbox/io_getxy.c
  xbox/io_gety.c
  xbox/io_inkey.c
  xbox/io_isredir.c
  xbox/io_locate.c
  xbox/io_maxrow.c
  xbox/io_mouse.c
  xbox/io_multikey.c
  xbox/io_pageset.c
  xbox/io_pcopy.c
  xbox/io_printbuff.c
  xbox/io_printbuff_wstr.c
  xbox/io_printer.c
  xbox/io_readstr.c
  xbox/io_readxy.c
  xbox/io_scroll.c
  xbox/io_serial.c
  xbox/io_viewupdate.c
  xbox/io_width.c
  xbox/sys_beep.c
  xbox/sys_delay.c
  xbox/sys_dylib.c
  xbox/sys_execex.c
  xbox/sys_fmem.c
  xbox/sys_getcwd.c
  xbox/sys_getexename.c
  xbox/sys_getexepath.c
  xbox/sys_hshell.c
  xbox/thread_cond.c
  xbox/thread_core.c
  xbox/thread_detach.c
  xbox/thread_mutex.c
  xbox/time_setdate.c
  xbox/time_settime.c
  xbox/time_timer.c
)
endif()

if ("${TARGET_OS}" MATCHES "^(darwin|freebsd|linux|netbsd|openbsd|solaris)$")
list(APPEND sources_os
  unix/drv_intl_get.c
  unix/drv_intl_getdateformat.c
  unix/drv_intl_getmonthname.c
  unix/drv_intl_gettimeformat.c
  unix/drv_intl_getweekdayname.c
  unix/file_copy.c
  unix/file_dir.c
  unix/file_hlock.c
  unix/file_hreset.c
  unix/hdynload.c
  unix/hinit.c
  unix/hinit_enable_vt100_escapes.c
  unix/io_cls.c
  unix/io_color.c
  unix/io_getsize.c
  unix/io_getx.c
  unix/io_getxy.c
  unix/io_gety.c
  unix/io_inkey.c
  unix/io_input.c
  unix/io_isredir.c
  unix/io_locate.c
  unix/io_maxrow.c
  unix/io_pageset.c
  unix/io_pcopy.c
  unix/io_printbuff.c
  unix/io_printbuff_wstr.c
  unix/io_printer.c
  unix/io_readstr.c
  unix/io_readxy.c
  unix/io_scroll.c
  unix/io_viewupdate.c
  unix/io_width.c
  unix/io_xfocus.c
  unix/scancodes_x11.c
  unix/sys_beep.c
  unix/sys_delay.c
  unix/sys_dylib.c
  unix/sys_execex.c
  unix/sys_getcwd.c
  unix/sys_hshell.c
  unix/thread_cond.c
  unix/thread_core.c
  unix/thread_detach.c
  unix/thread_mutex.c
  unix/time_setdate.c
  unix/time_settime.c
  unix/time_timer.c
)
endif()



target_sources(rtlib
  PRIVATE
    ${sources}
    ${headers_priv}
    ${sources_os}
    ${sources_arch}
  PUBLIC
    ${headers}
)

source_group(${TARGET_OS} FILES ${sources_os})
source_group(${TARGET_ARCH} FILES ${sources_arch})



##Set target properties
#target_include_directories(rtlib
#    PUBLIC
#        $<INSTALL_INTERFACE:.>
#        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/.>
#    PRIVATE
#        ${CMAKE_CURRENT_SOURCE_DIR}/.
#)

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
