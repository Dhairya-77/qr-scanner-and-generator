import 'package:flutter/material.dart';

//add qr_flutter dependency in pubspec/yaml
//then import below package
import 'package:qr_flutter/qr_flutter.dart';

//stateful widget
class GenerateQr extends StatefulWidget {
  const GenerateQr({super.key});

  @override
  State<GenerateQr> createState() => _GenerateQrState();
}

class _GenerateQrState extends State<GenerateQr> {

  //used for extracting user input text from
  TextEditingController textCtr=TextEditingController();
  //storing textField text into qrData
  String qrData="";

  @override
  Widget build(BuildContext context) {

    //textField decoration
    InputDecoration decoration = InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(27)),
        labelText: "Enter Text",
        hintText: "https://www.google.com",
        suffixIcon: IconButton(
            onPressed: (){
              //setState for update changing input text
              setState(() {
                qrData=textCtr.text.trim();
              });
            }, icon: Icon(Icons.check_outlined))
    );

    //widget for user input
    TextField enteredText = TextField(controller: textCtr,decoration:decoration,);

    //widget for qr image generation
    QrImageView qrImg= QrImageView(
      data: qrData,
      version: QrVersions.auto,
      size: 200,
      errorCorrectionLevel: QrErrorCorrectLevel.H,);

    //widget for show child widget in column format
    Column column=Column(mainAxisAlignment:MainAxisAlignment.center,children: [qrImg,enteredText],);

    //returning center widget which contains all child widgets
    return Center(
        child: ConstrainedBox(constraints: BoxConstraints(maxWidth: 500),
            child: Padding(padding: EdgeInsets.all(30),child: column,)));
  }
}