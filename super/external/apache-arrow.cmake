# ~~~
# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ~~~

include(ExternalProject)
include(external/external-project-helpers)

if (NOT TARGET apache-arrow-project)
    set(GOOGLE_CLOUD_CPP_APACHE_ARROW_URL
        "https://www-us.apache.org/dist/arrow/arrow-0.15.0/apache-arrow-0.15.0.tar.gz"
    )
    set(GOOGLE_CLOUD_CPP_APACHE_ARROW_SHA256
        "d1072d8c4bf9166949f4b722a89350a88b7c8912f51642a5d52283448acdfd58")

    google_cloud_cpp_set_prefix_vars()

    set_external_project_build_parallel_level(PARALLEL)

    ExternalProject_Add(
        apache-arrow-project
        EXCLUDE_FROM_ALL ON
        PREFIX "${CMAKE_BINARY_DIR}/external/apache-arrow"
        INSTALL_DIR "${GOOGLE_CLOUD_CPP_EXTERNAL_PREFIX}"
        URL ${GOOGLE_CLOUD_CPP_APACHE_ARROW_URL}
        URL_HASH SHA256=${GOOGLE_CLOUD_CPP_APACHE_ARROW_SHA256}
        LIST_SEPARATOR |
        SOURCE_SUBDIR cpp
        CMAKE_ARGS -DCMAKE_PREFIX_PATH=${GOOGLE_CLOUD_CPP_PREFIX_PATH}
                   -DCMAKE_INSTALL_PATH=${GOOGLE_CLOUD_CPP_INSTALL_PATH}
                   -DCMAKE_INSTALL_RPATH=${GOOGLE_CLOUD_CPP_INSTALL_RPATH}
                   -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
        BUILD_COMMAND ${CMAKE_COMMAND} --build <BINARY_DIR> ${PARALLEL}
        LOG_DOWNLOAD ON
        LOG_CONFIGURE ON
        LOG_BUILD ON
        LOG_INSTALL ON)
endif ()
