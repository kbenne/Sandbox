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

#include "qtsplitterbase.h"

/*!
    \qmltype Splitter
    \instantiates QtSplitterBase
    \inqmlmodule QtDesktop 1.0
    \brief Splitter is doing bla...bla...
*/

QtSplitterBase::QtSplitterBase(QQuickItem *parent)
    : QQuickItem(parent)
{
}

QtSplitterAttached *QtSplitterBase::qmlAttachedProperties(QObject *object)
{
    return new QtSplitterAttached(object);
}

void QtSplitterAttached::setExpanding(bool expanding)
{
    m_expanding = expanding;
    emit expandingChanged(expanding);
}

void QtSplitterAttached::setMaximumWidth(qreal width)
{
    m_maximumWidth = width;
    emit maximumWidthChanged(width);
}

void QtSplitterAttached::setMinimumWidth(qreal width)
{
    m_minimumWidth = width;
    emit minimumWidthChanged(width);
}

void QtSplitterAttached::setMaximumHeight(qreal height)
{
    m_maximumHeight = height;
    emit maximumHeightChanged(height);
}

void QtSplitterAttached::setMinimumHeight(qreal height)
{
    m_minimumHeight = height;
    emit minimumHeightChanged(height);
}

QtSplitterAttached::QtSplitterAttached(QObject *object)
    : QObject(object),
      m_minimumWidth(-1),
      m_maximumWidth(-1),
      m_minimumHeight(-1),
      m_maximumHeight(-1),
      m_percentageSize(-1),
      m_itemIndex(-1),
      m_expanding(false)
{
}
