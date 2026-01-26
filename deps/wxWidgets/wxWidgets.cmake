set(_wx_toolkit "")
if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    set(_gtk_ver 2)
    if (DEP_WX_GTK3)
        set(_gtk_ver 3)
    endif ()
    set(_wx_toolkit "-DwxBUILD_TOOLKIT=gtk${_gtk_ver}")
    set(_wx_private_font "-DwxUSE_PRIVATE_FONTS=1")
    set(_wx_egl "-DwxUSE_GLCANVAS_EGL=OFF")
else ()
    set(_wx_egl "")
endif()

if (MSVC)
    set(_wx_edge "-DwxUSE_WEBVIEW_EDGE=ON")
else ()
    set(_wx_edge "-DwxUSE_WEBVIEW_EDGE=OFF")
endif ()

set(_patch_cmd bash ${CMAKE_CURRENT_LIST_DIR}/apply_cotire_patch.sh)

bambustudio_add_cmake_project(wxWidgets
    GIT_REPOSITORY "https://github.com/bambulab/wxWidgets"
    GIT_TAG master
    DEPENDS ${PNG_PKG} ${ZLIB_PKG} ${EXPAT_PKG} ${TIFF_PKG} ${JPEG_PKG}
    PATCH_COMMAND ${_patch_cmd}
    CMAKE_ARGS
        -DCMAKE_POLICY_VERSION_MINIMUM=3.5
        -DCMAKE_TRY_COMPILE_PLATFORM_VARIABLES=CMAKE_POLICY_VERSION_MINIMUM
        -DwxBUILD_PRECOMP=ON
        ${_wx_toolkit}
        "-DCMAKE_DEBUG_POSTFIX:STRING="
        -DwxBUILD_DEBUG_LEVEL=0
        -DwxBUILD_SAMPLES=OFF
        -DwxBUILD_SHARED=OFF
        -DwxUSE_MEDIACTRL=ON
        -DwxUSE_DETECT_SM=OFF
        -DwxUSE_UNICODE=ON
        ${_wx_private_font}
        -DwxUSE_OPENGL=ON
        -DwxUSE_WEBVIEW=ON
        ${_wx_edge}
        -DwxUSE_WEBVIEW_IE=OFF
        -DwxUSE_REGEX=builtin
        -DwxUSE_LIBMSPACK=OFF
        -DwxUSE_LIBSDL=OFF
        -DwxUSE_XTEST=OFF
        -DwxUSE_STC=OFF
        -DwxUSE_AUI=ON
        -DwxUSE_LIBPNG=sys
        -DwxUSE_ZLIB=sys
        -DwxUSE_LIBJPEG=sys
        -DwxUSE_LIBTIFF=sys
        -DwxUSE_EXPAT=sys
        ${_wx_egl}
)

if (MSVC)
    add_debug_dep(dep_wxWidgets)
endif ()
