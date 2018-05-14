import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 1.4

/*!
 \qmltype CustomDialer
 \ingroup Controle

 \brief This is a Dial Visualisation with a minimum on 0 and Maximum on 180 Degree.

 \image Dial.png
 */

Item {
    id: customDialRoot
    anchors.fill: parent

    //PUBLIC
    /*!
     \qmlproperty int minValue
     \brief Minimum Value of the Custom Dial. This Value is shown at 0°.
     */
    property int minValue: 0.0
    /*!
     \qmlproperty int maxValue
     \brief Maximum Value of the Custom Dial. This Value is shown at 180°.
     */
    property int maxValue: 0.0
    /*!
     \qmlproperty int dialValue
     */
    property int dialValue: 0.0
    /*!
     \qmlproperty alias titel
     */
    property alias title: customDialTitleText.text
    /*!
     \qmlproperty color color
     */
    property color color: "#AAAAAA"

    //PRIVATE
    /*!
     \qmlproperty double hCascade
     */
    readonly property double hCascade: height / 32
    /*!
     \qmlproperty double wCascade
     */
    readonly property double wCascade: width / 32
    /*!
     \qmlproperty double radius
     */
    readonly property double radius: 18 * hCascade;
    /*!
     \qmlproperty double centerX
     */
    readonly property double centerX: 16 * wCascade;
    /*!
     \qmlproperty double centerY
     */
    readonly property double centerY: 22 * hCascade;
    /*!
     \qmlproperty double dialerWidth
     */
    readonly property double dialerWidth: 2 * hCascade

    Rectangle {
        id: dialCanvasBackground
        anchors.fill: parent

        color: 'transparent'

        Canvas {
            id: dialCanvas
            antialiasing: true

            height: parent.height
            width: parent.width

            property int dialValue: customDialRoot.dialValue
            property double angle: 0.0

            onDialValueChanged: {
                if (customDialRoot.maxValue < customDialRoot.dialValue)
                {
                    angle = 180.0;
                }else if (customDialRoot.minValue > customDialRoot.dialValue || customDialRoot.maxValue == customDialRoot.minValue)
                {
                    angle = 0.0;
                }else
                {
                    angle = (180.0 / (customDialRoot.maxValue - customDialRoot.minValue)) * (customDialRoot.dialValue - customDialRoot.minValue)
                }
            }

            Behavior on angle {
                NumberAnimation {
                   property: "angle"
                   easing.type: Easing.InOutQuad
                   duration: animationDuration
               }
            }

            onHeightChanged: requestPaint()
            onWidthChanged: requestPaint()
            onAngleChanged: requestPaint()

            renderTarget: Canvas.FramebufferObject
            renderStrategy: Canvas.Cooperative

            onPaint: {
                var context = getContext("2d");
                context.clearRect(0,0,width, height);
                context.lineWidth = 1;
                context.strokeStyle = color
                context.fillStyle = color

                var degree;

                context.beginPath()
                context.arc(customDialRoot.centerX, customDialRoot.centerY, customDialRoot.radius, (2 * Math.PI + Math.PI / 64), (Math.PI - (Math.PI / 64)), true)
                context.stroke()
                context.restore()
                var x1, y1, x2, y2, length;

                context.beginPath()
                for (var i = 0; i <= 16; i++)
                {
                    degree = i * 360 / 32;

                    switch (i)
                    {
                        case 0:
                        case 4:
                        case 8:
                        case 12:
                        case 16:
                            length = 2 * customDialRoot.hCascade;
                            break;
                        case 2:
                        case 6:
                        case 10:
                        case 14:
                            length = customDialRoot.hCascade;
                            break;
                        default:
                            length = customDialRoot.hCascade / 2;
                            break;

                    }

                    x1 = customDialRoot.centerX + (customDialRoot.radius + length) * Math.cos((((degree) * Math.PI) / 180));
                    x2 = customDialRoot.centerX + (customDialRoot.radius - length) * Math.cos((((degree) * Math.PI) / 180));
                    y1 = customDialRoot.centerY - (customDialRoot.radius + length) * Math.sin((((degree) * Math.PI) / 180));
                    y2 = customDialRoot.centerY - (customDialRoot.radius - length) * Math.sin((((degree) * Math.PI) / 180));

                    context.moveTo(x1, y1);
                    context.lineTo(x2, y2);
                }
                context.stroke();
                context.restore()

                context.beginPath();
                var x, y;

                context.moveTo(centerX, centerY);
                x = centerX - (dialerWidth * Math.cos((((angle - 45) * Math.PI) / 180)))
                y = centerY - (dialerWidth * Math.sin((((angle - 45) * Math.PI) / 180)))
                context.lineTo(x, y);
                x = centerX - radius * Math.cos((((angle) * Math.PI) / 180));
                y = centerY - radius * Math.sin((((angle) * Math.PI) / 180));
                context.lineTo(x, y);
                x = centerX - (dialerWidth * Math.cos((((angle + 45) * Math.PI) / 180)))
                y = centerY - (dialerWidth * Math.sin((((angle + 45) * Math.PI) / 180)))
                context.lineTo(x, y);
                context.fill();
                context.stroke();
                context.restore();
            }
        }

    }

    Text {
        id: minValueText
        x: centerX - radius - (0.5 * wCascade) - width
        y: 18 * hCascade
        width: 4 * wCascade
        height: 4 * hCascade

        text: customDialRoot.minValue

        font.family: 'Verdana'
        font.pixelSize: 3 * height / 4

        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter

        color: customDialRoot.color

    }

    Text {
        id: minMaxHalfValueText
        x: centerX - (0.5 * wCascade) - width
        y: 0 * hCascade
        width: 4 * wCascade
        height: 4 * hCascade

        text: (customDialRoot.maxValue - customDialRoot.minValue) / 2

        font.family: 'Verdana'
        font.pixelSize: 3 * height / 4

        horizontalAlignment: Text.AlignRight
        verticalAlignment: Text.AlignVCenter

        color: customDialRoot.color

    }

    Text {
        id: maxValueText
        x: centerX + radius + (0.5 * wCascade)
        y: 18 * hCascade
        width: 4 * wCascade
        height: 4 * hCascade

        text: customDialRoot.maxValue

        font.family: 'Verdana'
        font.pixelSize: 3 * height / 4

        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter

        color: customDialRoot.color

    }

    Rectangle {
        id: customDialValueBackground

        x: 0 * wCascade
        y: 24 * hCascade
        width: 32 * wCascade
        height: 8 * hCascade

        color: 'transparent'

        RowLayout {
            id: customDialValueLayout
            anchors.fill: parent

            spacing: parent.height

            Rectangle {
                id: customDialTitleBackground
                Layout.preferredHeight: parent.height
                Layout.preferredWidth: parent.width / 2
                Layout.fillWidth: true

                color: 'transparent'

                Text {
                    id: customDialTitleText
                    anchors.fill: parent

                    font.family: 'Verdana'
                    font.pixelSize: parent.height / 2

                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter

                    color: customDialRoot.color

                }
            }

            Rectangle {
                id: customDialValueTextBackground
                Layout.preferredHeight: parent.height
                Layout.preferredWidth: parent.width / 2
                Layout.fillWidth: true

                color: 'transparent'

                Text {
                    id: customDialValueText
                    height: parent.height
                    width: parent.width

                    text: customDialRoot.dialValue.toString()

                    font.family: 'Verdana'
                    font.pixelSize: parent.height / 2

                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter

                    color: customDialRoot.color
                }
            }
        }
    }
}
