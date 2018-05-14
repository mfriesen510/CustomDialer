# CustomDialer
This is a Dial Visualisation with a minimum on 0 and Maximum on 180 Degree.

Desctiption
----------
To keep this Custom Dialer as dynamic as possible, i started to generate the Propertys minValue and maxValue. Both Values will be compared with the Property dialValue and set the angle for the Dialer Transition. 

The title can be every Translated String and will shown above the Dialer.

The color Property can be set to any Value and will affect the Dialer Canvas and the shown Text.

I set the Background to Transparent because i want not to overload the Property Section.

Changelog
----------
v0.0.1: First Version to generate a Custom Dialer for everyone.

Call Example
----------
```QML
CustomDialer {
    id: frequencyDial
    anchors.centerIn: parent

    title: qsTr("Frequency:")

    dialValue: frequency //Property from Class

    minValue: 0
    maxValue: 1250

    color: dialerColor //Customized Color for the Dialer
}
```

Background / Motivation
----------
After many invalid Searchresults with Google to find a Custom Dialer vor QT/QML, i decided to create my own one.

This is my First Try to get Active in GitHub. Please lead me to any Issues or License Problems. Thank You.

Screenshot
----------
![Custom Dialer Screenshot][dialer]

License
----------
GPLv3

[dialer]: https://github.com/mfriesen510/CustomDialer/blob/Commit-CustomDialer/Dial.png
