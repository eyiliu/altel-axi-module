cmake_minimum_required(VERSION 3.0.0 FATAL_ERROR)

project(driver VERSION 0.1.0 LANGUAGES C)
set(CMAKE_C_STANDARD 99)

# Generate the Kbuild file through cmake.
set( DRIVER_FILE hello.ko )
set( KERNEL_DIR "/lib/modules/${CMAKE_SYSTEM_VERSION}/build" )
set( KBUILD_CMD ${CMAKE_MAKE_PROGRAM} -C ${KERNEL_DIR} modules M=${CMAKE_CURRENT_SOURCE_DIR})

add_custom_command( OUTPUT ${DRIVER_FILE}
                    COMMAND ${KBUILD_CMD}
                    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
                    DEPENDS hello.c Kbuild VERBATIM )

add_custom_target( driver ALL DEPENDS ${DRIVER_FILE} )