import bb.cascades 1.0

Page {
    Container {
        layout: DockLayout {

        }

        ImageView {
            imageSource: "asset:///images/background.jpg"
            horizontalAlignment: HorizontalAlignment.Fill
            verticalAlignment: VerticalAlignment.Fill
        }

        Container {
            horizontalAlignment: HorizontalAlignment.Center
            verticalAlignment: VerticalAlignment.Center
            bottomPadding: 70.0

            ImageView {
                imageSource: "asset:///images/logo.gif"
                horizontalAlignment: HorizontalAlignment.Center
            }

            Label {
                // Localized text with the dynamic translation and locale updates support
                text: qsTr("scan the ISBN code to search the NLB catalogue") + Retranslate.onLocaleOrLanguageChanged
                textStyle.base: SystemDefaults.TextStyles.TitleText
                multiline: true
                textStyle.textAlign: TextAlign.Center
                preferredWidth: 540.0
                topMargin: 110.0
                textStyle.color: Color.Black
            }
        }

        Label {
            id: isbn
            text: "isbn #"
            visible: true
            horizontalAlignment: HorizontalAlignment.Center
        }
    }

    actions: [
        ActionItem {
            title: "Scan"
            imageSource: "asset:///images/barcode_zoom.jpg"
            ActionBar.placement: ActionBarPlacement.OnBar
            onTriggered: {
                var sheet = sheetDefinition.createObject();
                sheet.open();
            }
            attachedObjects: ComponentDefinition {
                id: sheetDefinition
                source: "scan.qml"
            }
        }
    ]
    actionBarAutoHideBehavior: ActionBarAutoHideBehavior.Disabled

    onCreationCompleted: {
        Qt.isbn = isbn;
    }
}
