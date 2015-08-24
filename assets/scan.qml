import bb.cascades 1.0
import bb.cascades.multimedia 1.0
import bb.multimedia 1.0

Sheet {
    id: scanSheet

    content: Page {
        id: scan

        Container {
            layout: DockLayout {

            }

            Camera {
                id: camera
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill

                onCameraOpened: {
                    // Apply some settings after the camera was opened successfully
                    getSettings(cameraSettings);
                    cameraSettings.focusMode = CameraFocusMode.ContinuousAuto;
                    cameraSettings.shootingMode = CameraShootingMode.Stabilization;
                    applySettings(cameraSettings);

                    // Start the view finder as it is needed by the barcode detector
                    camera.startViewfinder();
                }

                attachedObjects: [
                    BarcodeDetector {
                        id: barcodeDetector
                        camera: camera
                        formats: BarcodeFormat.Ean13
                        onDetected: {
                            if (Qt.isbn.text != data) {
                                Qt.isbn.text = data;
                                scannedSound.play();
                                scanSheet.close();
                            }
                        }
                    },
                    CameraSettings {
                        id: cameraSettings
                    },
                    SystemSound {
                        id: scannedSound
                        sound: SystemSound.GeneralNotification
                    }
                ]
            }

            // The overlay image
            ImageView {
                horizontalAlignment: HorizontalAlignment.Fill
                verticalAlignment: VerticalAlignment.Fill
                imageSource: "asset:///images/overlay.png"
            }
        }
    }

    onOpened: {
        camera.open();
    }

    onClosed: {
        camera.close();
        scanSheet.destroy();
    }
}
