 #
 # Copyright (C) 2016 TATA ELXSI
 # Copyright (C) 2016 Metrological
 # All rights reserved.
 #
 # Redistribution and use in source and binary forms, with or without
 # modification, are permitted provided that the following conditions
 # are met:
 # 1. Redistributions of source code must retain the above copyright
 #    notice, this list of conditions and the following disclaimer.
 # 2. Redistributions in binary form must reproduce the above copyright
 #    notice, this list of conditions and the following disclaimer in the
 #    documentation and/or other materials provided with the distribution.
 #
 # THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 # "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 # LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 # PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 # HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 # SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 # LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 # DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 # THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 # (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 # OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #/
 #  OPENCDM_INCLUDE_DIR - The OpenCDM include directory
 #  OPENCDM_LIB - The libraries needed to use OpenCDM


#**************************************************************
#Find the OPENCDM LIBRARIES and INCLUDES
#
#************************************************************

find_package(PkgConfig)

pkg_check_modules(PC_OCDM ocdm)

if (PC_OCDM_FOUND)
    set(OPENCDM_DEFINITIONS ${PC_OCDM_CFLAGS_OTHER})
    set(OPENCDM_NAMES ${PC_OCDM_LIBRARIES})
    foreach (_library ${OPENCDM_NAMES})
        find_library(OPENCDM_LIBRARIES_${_library} ${_library}
            HINTS ${PC_OCDM_LIBDIR} ${PC_OCDM_LIBRARY_DIRS}
        )
        set(OPENCDM_LIBRARIES ${OPENCDM_LIBRARIES} ${OPENCDM_LIBRARIES_${_library}})
    endforeach ()

    set (OPENCDM_INCLUDE_DIRS ${OPENCDM_INCLUDE_DIRS} ${PC_OCDM_INCLUDEDIR} ${PC_OCDM_INCLUDE_DIRS})
endif ()

include(FindPackageHandleStandardArgs)
FIND_PACKAGE_HANDLE_STANDARD_ARGS(OPENCDM DEFAULT_MSG OPENCDM_DEFINITIONS OPENCDM_LIBRARIES OPENCDM_INCLUDE_DIRS)
mark_as_advanced(OPENCDM_DEFINITIONS OPENCDM_LIBRARIES OPENCDM_INCLUDE_DIRS)
