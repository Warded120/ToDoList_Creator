import QtQuick
import QtQuick 6.3
import QtQuick.Controls
import QtQuick.Layouts 1.3
import QtQuick.Window

Window {
    id: rectangle
    width: 480
    height: 640
    visible: true
    title: qsTr("ToDoList")
    color: "#234567"

    property bool isopen: false

    Label{
        id:header
        height: 35
        width: 480
        text: qsTr("Goals:")
        horizontalAlignment: "AlignHCenter"
        verticalAlignment: "AlignVCenter"
        font.pointSize: 20

//        anchors.top: parent.bottom
//        anchors.topMargin: 0
//        anchors.left: parent.left
//        anchors.leftMargin: 190
    }

    Column{
        id: col
        width:400
        spacing: 10
        x: 40
        y:50
        Repeater{
            id: repeater
            model: ListModel{
                id:myListModel

                ListElement{
                    name: "Set a goal"
                }

                function addgoal() {
                    return{
                        "name":inputvar.text
                    }
                }
            }
            Rectangle{
                id: task
                width:400
                height: 75
                color:"#345678"
                radius: 30
                anchors.left: col.left
                anchors.leftMargin: 0

                CheckBox{
                    id:checkbox
                    height: 25
                    text: name
                    anchors.left:parent.left
                    anchors.leftMargin: 15
                    anchors.top:parent.top
                    anchors.topMargin: 25
                    font.pointSize: 14
                }

                RoundButton{
                    id: del
                    height: 35
                    width: 100
                    enabled: checkbox.checked

                    anchors.top:parent.top
                    anchors.topMargin: 20
                    anchors.right: parent.right
                    anchors.rightMargin: 15

                    text: qsTr("delete")

                    Connections{
                        target:del
                        onClicked: myListModel.remove(index)
                    }
                }


            }
        }
    }

    Rectangle{
        id:pop_up
        width: 400
        height: 150
        color: "#345678"
        radius: 30
        visible: rectangle.isopen

        anchors.bottom: add_cancel.top
        anchors.bottomMargin: 25
        anchors.left: parent.left
        anchors.leftMargin: 40
        anchors.right: parent.right
        anchors.rightMargin: 40

        TextField{
            id:inputvar
            width:350
            height: 75
            font.pointSize: 14
            horizontalAlignment: "AlignHCenter"
            placeholderText: qsTr("Enter a goal")

            anchors.top: pop_up.top
            anchors.topMargin: 10
            anchors.right: pop_up.right
            anchors.rightMargin: 25
        }

        RoundButton{
            id:add
            width:150
            text: qsTr("Add")

            anchors.left: pop_up.left
            anchors.leftMargin: 40
            anchors.bottom:  pop_up.bottom
            anchors.bottomMargin: 10


            Connections {
                target: add
                onClicked: rectangle.isopen = false
            }
            Connections {
                target: add
                onClicked: inputvar.text = ""
            }
            Connections {
                target: add
                onClicked: myListModel.append(myListModel.addgoal())
            }
        }
        RoundButton{
            id:cancel
            width:150
            text: qsTr("Cancel")

            anchors.right: pop_up.right
            anchors.rightMargin: 40
            anchors.bottom:  pop_up.bottom
            anchors.bottomMargin: 10

            Connections {
                target: cancel
                onClicked: rectangle.isopen = false
            }
            Connections {
                target: cancel
                onClicked: inputvar.text = ""
            }
        }
    }

    RoundButton {
        id: add_cancel
        text: qsTr("Create a task")
        width: 430

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 25

        anchors.horizontalCenter: parent.horizontalCenter

        Connections {
            target: add_cancel
            onClicked: rectangle.isopen = !rectangle.isopen
        }
    }
}
