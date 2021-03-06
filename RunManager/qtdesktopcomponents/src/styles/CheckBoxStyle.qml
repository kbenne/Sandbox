/****************************************************************************
**
** Copyright (C) 2012 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the Qt Components project.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Digia Plc and its Subsidiary(-ies) nor the names
**     of its contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/
import QtQuick 2.0
import QtDesktop 1.0

/*!
    \qmltype CheckBoxStyle
    \inqmlmodule QtDesktop.Styles 1.0
    \brief CheckBoxStyle is doing bla...bla...
*/

Item {
    implicitWidth: 100
    implicitHeight: 20

    property Component indicator: Rectangle {
        height:20
        width: 20
        gradient: Gradient{
            GradientStop{color: control.pressed ? "lightgray" : "white" ; position: 0}
            GradientStop{color: control.pressed ? "lightgray" : "lightgray" ; position: 1}
        }
        radius:4
        border.color: "#aaa"
        Rectangle {
            height:20
            width: 20
            visible: control.checked
            gradient: Gradient{
                GradientStop{color: "darkgray" ; position: 1}
                GradientStop{color: "lightgray" ; position: 0}
            }
            radius:2
            anchors.margins: 5
            anchors.fill: parent
            border.color: "gray"
        }
    }

    Loader {
        id: indicatorLoader
        sourceComponent: indicator
    }

    Text {
        anchors.left: parent.left
        anchors.leftMargin: 24
        anchors.verticalCenter: parent.verticalCenter
        text: control.text
        renderType: Text.NativeRendering
    }
}
