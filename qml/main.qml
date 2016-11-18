import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.0
import "."

ApplicationWindow {
    visible: true
    width: 280
    height: 480
    title: qsTr("tempsQML")
    property alias backgr: swipeView.background

    //store items, pushed to StackView
    property Item itemSettings: null
    property Item itemMain: null

    StackView {
        id: swipeView
        padding: 0
        anchors.fill: parent
        initialItem: mainComponent
        popEnter: Transition {
            PropertyAnimation { property: "opacity"; from: 0; to: 1; duration: 800 }
        }
        popExit: Transition {
            PropertyAnimation { property: "opacity"; from: 1; to: 0; duration: 800 }
        }
        pushEnter: Transition {
            PropertyAnimation { property: "opacity"; from: 0; to: 1; duration: 800 }
        }
        pushExit: Transition {
            PropertyAnimation { property: "opacity"; from: 1; to: 0; duration: 800 }
        }

        background: WaiwedItem {
            onSettingsClicked: {
                if (swipeView.currentItem === itemSettings) {
                    backgr.yPage = 300
                    swipeView.pop()
                } else {
                    backgr.yPage = 100
                    itemSettings = swipeView.push(settings)
                }
            }
        }
    }
    Component {
        id: settings
        SettingsPage {
        }
    }
    Component {
        id: mainComponent
        MainPage {
        }
    }

    Component.onCompleted: {
        browserCoordinate.requestCoordinates()
    }
}
