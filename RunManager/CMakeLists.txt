project(RunManager)

cmake_minimum_required(VERSION 2.8)

find_package(Qt5Quick)
find_package(Qt5Widgets)
find_package(Qt5Declarative)
set(CMAKE_AUTOMOC ON)
ADD_DEFINITIONS( -DQT_VERSION=0x050000 )

set( qml_desktop_plugin_src
  qtdesktopcomponents/src/qtdesktop/qdesktopitem.h 
  qtdesktopcomponents/src/qtdesktop/qdesktopitem.cpp 
  qtdesktopcomponents/src/qtdesktop/qfiledialogitem.h 
  qtdesktopcomponents/src/qtdesktop/qfiledialogitem.cpp 
  qtdesktopcomponents/src/qtdesktop/qquickcomponentsprivate.h 
  qtdesktopcomponents/src/qtdesktop/qquickcomponentsprivate.cpp 
  qtdesktopcomponents/src/qtdesktop/qquicklayout.h 
  qtdesktopcomponents/src/qtdesktop/qquicklayout.cpp 
  qtdesktopcomponents/src/qtdesktop/qquicklayoutengine_p.h 
  qtdesktopcomponents/src/qtdesktop/qquicklayoutengine.cpp 
  qtdesktopcomponents/src/qtdesktop/qquicklinearlayout.h 
  qtdesktopcomponents/src/qtdesktop/qquicklinearlayout.cpp 
  qtdesktopcomponents/src/qtdesktop/qrangemodel.h 
  qtdesktopcomponents/src/qtdesktop/qrangemodel_p.h 
  qtdesktopcomponents/src/qtdesktop/qrangemodel.cpp 
  qtdesktopcomponents/src/qtdesktop/qstyleitem.h 
  qtdesktopcomponents/src/qtdesktop/qstyleitem.cpp 
  qtdesktopcomponents/src/qtdesktop/qstyleplugin.h 
  qtdesktopcomponents/src/qtdesktop/qstyleplugin.cpp 
  qtdesktopcomponents/src/qtdesktop/qtmenu.h 
  qtdesktopcomponents/src/qtdesktop/qtmenu.cpp 
  qtdesktopcomponents/src/qtdesktop/qtmenubar.h 
  qtdesktopcomponents/src/qtdesktop/qtmenubar.cpp 
  qtdesktopcomponents/src/qtdesktop/qtmenuitem.h 
  qtdesktopcomponents/src/qtdesktop/qtmenuitem.cpp 
  qtdesktopcomponents/src/qtdesktop/qtsplitterbase.h 
  qtdesktopcomponents/src/qtdesktop/qtsplitterbase.cpp 
  qtdesktopcomponents/src/qtdesktop/qwheelarea.h
  qtdesktopcomponents/src/qtdesktop/qwheelarea.cpp
)

add_library( styleplugin SHARED ${qml_desktop_plugin_src} )

set( qml_plugin_install_prefix ${CMAKE_BINARY_DIR}/RunManager.app/Contents/MacOS )

set_property( TARGET styleplugin 
              PROPERTY RUNTIME_OUTPUT_DIRECTORY ${qml_plugin_install_prefix}/QtDesktop/plugin 
)

set_property( TARGET styleplugin 
              PROPERTY LIBRARY_OUTPUT_DIRECTORY ${qml_plugin_install_prefix}/QtDesktop/plugin
)

set_property( TARGET styleplugin 
              PROPERTY COMPILE_DEFINITIONS QT_PLUGIN=1;QT_NO_DEBUG=1;QT_SHARED=1
)

qt5_use_modules(styleplugin Quick Widgets Declarative)

if( APPLE )
  find_library(CARBON NAMES Carbon)
  target_link_libraries( styleplugin ${CARBON} )
endif()

# Install files under qtdesktopcomponents/src/qtdesktop
# to QtDesktop

file( GLOB FILES_TO_COPY 
  RELATIVE ${CMAKE_SOURCE_DIR}/qtdesktopcomponents/src/qtdesktop  
  ${CMAKE_SOURCE_DIR}/qtdesktopcomponents/src/qtdesktop/*.qml 
  ${CMAKE_SOURCE_DIR}/qtdesktopcomponents/src/qtdesktop/plugins.qmltypes 
  ${CMAKE_SOURCE_DIR}/qtdesktopcomponents/src/qtdesktop/qmldir 
) 

execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${qml_plugin_install_prefix}/QtDesktop )

foreach( f ${FILES_TO_COPY} )
  set( out_file "${CMAKE_BINARY_DIR}/QtDesktop/${f}" )
  set( in_file "${CMAKE_SOURCE_DIR}/qtdesktopcomponents/src/qtdesktop/${f}" )
  add_custom_command( OUTPUT ${out_file}
    COMMAND ${CMAKE_COMMAND} -E copy ${in_file} ${qml_plugin_install_prefix}/QtDesktop/
    DEPENDS ${in_file}
  )
  list( APPEND PLUGIN_BINARY_COPY_FILES ${out_file} )
endforeach()

# Install files under qtdesktopcomponents/src/qtdesktop/private
# to QtDesktop/private

file( GLOB FILES_TO_COPY 
  RELATIVE ${CMAKE_SOURCE_DIR}/qtdesktopcomponents/src/qtdesktop  
  ${CMAKE_SOURCE_DIR}/qtdesktopcomponents/src/qtdesktop/private/*.qml 
  ${CMAKE_SOURCE_DIR}/qtdesktopcomponents/src/qtdesktop/private/*.js
) 

execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${qml_plugin_install_prefix}/QtDesktop/private )

foreach( f ${FILES_TO_COPY} )
  set( out_file "${CMAKE_BINARY_DIR}/QtDesktop/${f}" )
  set( in_file "${CMAKE_SOURCE_DIR}/qtdesktopcomponents/src/qtdesktop/${f}" )
  add_custom_command( OUTPUT ${out_file}
    COMMAND ${CMAKE_COMMAND} -E copy ${in_file} ${qml_plugin_install_prefix}/QtDesktop/private/
    DEPENDS ${in_file}
  )
  list( APPEND PLUGIN_BINARY_COPY_FILES ${out_file} )
endforeach()

# Install files under qtdesktopcomponents/src/styles
# to QtDesktop/Styles

file( GLOB FILES_TO_COPY 
  RELATIVE ${CMAKE_SOURCE_DIR}/qtdesktopcomponents/src/styles  
  ${CMAKE_SOURCE_DIR}/qtdesktopcomponents/src/styles/*.qml 
  ${CMAKE_SOURCE_DIR}/qtdesktopcomponents/src/styles/*.js 
  ${CMAKE_SOURCE_DIR}/qtdesktopcomponents/src/styles/qmldir 
) 

execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${qml_plugin_install_prefix}/QtDesktop/Styles )

foreach( f ${FILES_TO_COPY} )
  set( out_file "${CMAKE_BINARY_DIR}/QtDesktop/Styles/${f}" )
  set( in_file "${CMAKE_SOURCE_DIR}/qtdesktopcomponents/src/styles/${f}" )
  add_custom_command( OUTPUT ${out_file}
    COMMAND ${CMAKE_COMMAND} -E copy ${in_file} ${qml_plugin_install_prefix}/QtDesktop/Styles/
    DEPENDS ${in_file}
  )
  list( APPEND PLUGIN_BINARY_COPY_FILES ${out_file} )
endforeach()

# Install files under qtdesktopcomponents/src/styles/Desktop
# to QtDesktop/Styles/Desktop

file( GLOB FILES_TO_COPY 
  RELATIVE ${CMAKE_SOURCE_DIR}/qtdesktopcomponents/src/styles  
  ${CMAKE_SOURCE_DIR}/qtdesktopcomponents/src/styles/Desktop/*.* ) 

execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${qml_plugin_install_prefix}/QtDesktop/Styles/Desktop )

foreach( f ${FILES_TO_COPY} )
  set( out_file "${CMAKE_BINARY_DIR}/QtDesktop/Styles/${f}" )
  set( in_file "${CMAKE_SOURCE_DIR}/qtdesktopcomponents/src/styles/${f}" )
  add_custom_command( OUTPUT ${out_file}
    COMMAND ${CMAKE_COMMAND} -E copy ${in_file} ${qml_plugin_install_prefix}/QtDesktop/Styles/Desktop
    DEPENDS ${in_file}
  )
  list( APPEND PLUGIN_BINARY_COPY_FILES ${out_file} )
endforeach()

# Install files under qtdesktopcomponents/src/styles/images
# to QtDesktop/Styles/images

file( GLOB FILES_TO_COPY 
  RELATIVE ${CMAKE_SOURCE_DIR}/qtdesktopcomponents/src/styles  
  ${CMAKE_SOURCE_DIR}/qtdesktopcomponents/src/styles/images/*.* ) 

execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory ${qml_plugin_install_prefix}/QtDesktop/Styles/images )

foreach( f ${FILES_TO_COPY} )
  set( out_file "${CMAKE_BINARY_DIR}/QtDesktop/Styles/${f}" )
  set( in_file "${CMAKE_SOURCE_DIR}/qtdesktopcomponents/src/styles/${f}" )
  add_custom_command( OUTPUT ${out_file}
    COMMAND ${CMAKE_COMMAND} -E copy ${in_file} ${qml_plugin_install_prefix}/QtDesktop/Styles/images
    DEPENDS ${in_file}
  )
  list( APPEND PLUGIN_BINARY_COPY_FILES ${out_file} )
endforeach()


# Build Application

set( run_manager_src
  main.cpp
)

add_executable( RunManager MACOSX_BUNDLE ${run_manager_src} ${PLUGIN_BINARY_COPY_FILES} )

qt5_use_modules( RunManager Quick Widgets)




