import QtQuick 2.5

Item {
    id: root

    Image {
        width: 80
        height: 80
        anchors { top: parent.top; topMargin: parent.height * 0.14; left: parent.left; leftMargin: parent.width * 0.08; }
        source: weatherModel.currentWeather.weather_codition_icon_id === "" ?
                    "images/icons/IconTemplate@02d.png" :
                    "images/icons/" + weatherModel.currentWeather.weather_codition_icon_id + ".svg"
    }

    Column {
        height: 100
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.3 - 30
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: degree.paintedWidth/2
            spacing: 0
            Text {
                font.pixelSize: 48
                color: "white"
                text: weatherCommon.roundup(weatherCommon.convertToCurrentScale(weatherModel.currentWeather.temp))
            }
            Text {
                id: degree
                font.pixelSize: 48
                color: "white"
                text: "\u00B0"
            }

        }
        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            color: "white"
            //opacity: 0.5
            width: 24
            height: 2
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 18
            color: "white"
            opacity: 0.5
            text: weatherModel.currentWeather.weather_codition_description
        }
    }
    Item {
        id: details
        anchors.bottom: parent.bottom
        width: parent.width
        height: 160
        Row {
            id: row
            width: parent.width
            spacing: 0
            anchors.top: parent.top

            Text {
                width: parent.width/2
                font.pixelSize: 12
                color: "#999999"
                text: Qt.formatDate(weatherModel.currentWeather.timestamp, "dddd, MMM d")
                horizontalAlignment: Text.AlignHCenter
            }

            Text {
                width: parent.width/2
                font.pixelSize: 12
                color: "#999999"
                text: weatherModel.cityName.toLowerCase() + ", " + weatherModel.countryID.toLowerCase()
                horizontalAlignment: Text.AlignHCenter
            }
        }
        Item {
            id: subdetails
            anchors.bottom: parent.bottom
            width: parent.width
            anchors.top: row.bottom
            property int showdetailsindex: -1
            ListView {
                id: view
                model: weatherDailyModel
                visible: subdetails.showdetailsindex === -1
                anchors.fill: parent
                anchors.margins: 10
                clip: true
                interactive: true
                focus: true
                orientation: ListView.Horizontal
                highlightFollowsCurrentItem: true

                delegate: WeatherDelegate {
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (index >= 0 && index < weatherModel.daysNumber) {
                                subdetails.showdetailsindex = index
                                filteredWeatherModel.setWeatherDateIndex(index)
                            }
                        }
                    }
                }
            }
            WeatherGraph {
                anchors.fill: parent
                visible: subdetails.showdetailsindex !== -1
            }
        }
    }
}

