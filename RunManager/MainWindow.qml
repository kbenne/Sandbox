import QtQuick 2.0
import QtDesktop 1.0

Rectangle {
  id: mainWindow

  width: 800
  height: 500

  Column {

    Button { 
      text: "Push Me" 
      width: 100
    }

    Button { 
      text: "Push Me" 
      width: 100
    }

    ComboBox {
      width: 100
      height: 27
      model: ListModel {
        ListElement { text: "one" }
        ListElement { text: "two" }
        ListElement { text: "three" }
      }
    }
  }
  
}

