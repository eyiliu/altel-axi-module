cmake_minimum_required(VERSION 3.0.0 FATAL_ERROR)

project(driver VERSION 0.1.0 LANGUAGES C)
set(CMAKE_C_STANDARD 99)

# add_library(jippi hello.c)

#However, the file(GLOB...) allows for wildcard additions:
file(GLOB src *.c)

set( DRIVER_FILE hello.ko )
message("DRIVER_FILE is ${DRIVER_FILE}" )

set( KERNEL_DIR "/lib/modules/${CMAKE_SYSTEM_VERSION}/build" )
message("KERNEL_DIR is ${KERNEL_DIR}" )
message("CMAKE_CURRENT_SOURCE_DIR is ${CMAKE_CURRENT_SOURCE_DIR}" )
message("CMAKE_CURRENT_BINARY_DIR is ${CMAKE_CURRENT_BINARY_DIR}" )
message("src is ${src}" )


set( KBUILD_CMD ${CMAKE_MAKE_PROGRAM} -C ${KERNEL_DIR} M=${CMAKE_CURRENT_BINARY_DIR})
message("KBUILD_CMD is ${KBUILD_CMD}")

add_custom_command( OUTPUT ${DRIVER_FILE}
                    COMMAND ${KBUILD_CMD}
                    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
                    DEPENDS ${src} Kbuild VERBATIM )

add_custom_target( driver ALL DEPENDS ${DRIVER_FILE} )