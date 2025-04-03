import 'package:flutter/material.dart';

class GenerateQr extends StatefulWidget {
  const GenerateQr({super.key});

  @override
  State<GenerateQr> createState() => _GenerateQrState();
}

class _GenerateQrState extends State<GenerateQr> {
  TextEditingController textCtr=TextEditingController();
  @override
  Widget build(BuildContext context) {

    InputDecoration decoration = InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(27)),
        labelText: "Enter Text",
        hintText: "https://www.google.com",
        suffixIcon: IconButton(
            onPressed: (){}, icon: Icon(Icons.check_outlined))
    );


    TextField enteredText = TextField(controller: textCtr,decoration:decoration,);



    Column column=Column(mainAxisAlignment:MainAxisAlignment.center,children: [enteredText],);

    return Center(
        child: ConstrainedBox(constraints: BoxConstraints(maxWidth: 500),
            child: Padding(padding: EdgeInsets.all(30),child: column,)));
  }
}