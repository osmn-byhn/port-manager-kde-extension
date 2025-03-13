import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.kirigami 2.15 as Kirigami

PlasmoidItem {
    id: root
    width: 300
    height: 400

    Kirigami.Theme.colorSet: Kirigami.Theme.View
    Kirigami.Theme.inherit: false

    ListModel {
        id: portModel
    }

    function refreshPorts() {
        plasmoid.nativeInterface.getPortList()
    }

    function killProcess(pid) {
        plasmoid.nativeInterface.terminateProcess(pid)
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        ListView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: portModel
            delegate: RowLayout {
                spacing: 10
                Text { text: "Port: " + model.port }
                Button {
                    text: "X"
                    onClicked: killProcess(model.pid)
                }
            }
        }
        Button {
            text: "Yenile"
            Layout.fillWidth: true
            onClicked: refreshPorts()
        }
    }
}
