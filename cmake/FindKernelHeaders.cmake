# Find the kernel release
execute_process(
        COMMAND uname -r
        OUTPUT_VARIABLE KERNEL_RELEASE
        OUTPUT_STRIP_TRAILING_WHITESPACE
)


set(KERNEL_TARGET_ARCH arm)

# Find the headers
find_path(KERNELHEADERS_DIR
        include/linux/user.h
        PATHS /usr/src/kernels/${KERNEL_RELEASE}
        )

message(STATUS "Kernel release: ${KERNEL_RELEASE}")
message(STATUS "Kernel headers: ${KERNELHEADERS_DIR}")

if (KERNELHEADERS_DIR)
    set(KERNELHEADERS_INCLUDE_DIRS
            ${KERNELHEADERS_DIR}/arch/${KERNEL_TARGET_ARCH}/include
            ${KERNELHEADERS_DIR}/include
            CACHE PATH "Kernel headers include dirs"
            )
    set(KERNELHEADERS_FOUND 1 CACHE STRING "Set to 1 if kernel headers were found")
else (KERNELHEADERS_DIR)
    set(KERNELHEADERS_FOUND 0 CACHE STRING "Set to 1 if kernel headers were found")
endif (KERNELHEADERS_DIR)


message(AUTHOR_WARNING "KERNEL_TARGET_ARCH = ${KERNEL_TARGET_ARCH}")

message("KERNELHEADERS_INCLUDE_DIRS = ${KERNELHEADERS_INCLUDE_DIRS}")
message("KERNELHEADERS_DIR = ${KERNELHEADERS_DIR}")

mark_as_advanced(KERNELHEADERS_FOUND)
