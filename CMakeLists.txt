cmake_minimum_required(VERSION 3.16)
project(hyprlua VERSION 0.0.2 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
add_compile_options(-Wall -Wextra -Wno-unused-parameter)
find_package(PkgConfig REQUIRED)
pkg_check_modules(PIXMAN  REQUIRED IMPORTED_TARGET pixman-1)
pkg_check_modules(HYPRLAND REQUIRED IMPORTED_TARGET hyprland)
pkg_check_modules(LUA     REQUIRED IMPORTED_TARGET lua5.4)
find_package(Threads REQUIRED)
add_library(hyprlua SHARED
  src/main.cpp
  src/globals.cpp
  src/watcher.cpp
  src/utils.cpp
  src/lua/runtime.cpp
  src/lua/monitors.cpp
  src/lua/keybinds.cpp
)
target_include_directories(hyprlua PRIVATE
  src/
  /usr/include/libdrm
)
target_link_libraries(hyprlua PRIVATE
  PkgConfig::PIXMAN
  PkgConfig::LUA
  PkgConfig::HYPRLAND
  Threads::Threads
)
set_target_properties(hyprlua PROPERTIES
  VERSION   ${PROJECT_VERSION}
  SOVERSION ${PROJECT_VERSION_MAJOR}
)
target_compile_definitions(hyprlua PRIVATE
  HYPRLUA_VERSION="${PROJECT_VERSION}"
)
include(GNUInstallDirs)
install(TARGETS hyprlua
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}/hyprland/plugins
)
install(DIRECTORY runtime/modules/
  DESTINATION ${CMAKE_INSTALL_DATADIR}/hyprlua/modules
  FILES_MATCHING PATTERN "*.lua"
)
install(DIRECTORY runtime/libs/
  DESTINATION ${CMAKE_INSTALL_DATADIR}/hyprlua/libs
  FILES_MATCHING PATTERN "*.lua"
)
