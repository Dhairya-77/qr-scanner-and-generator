import 'dart:io';
import 'package:flutter/material.dart';

//add qr_code_scanner_plus dependency in pubspec.yaml
//then import below package for qr scanning functionality
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

//add q  super_clipboard: ^0.8.24 dependency in pubspec.yaml
//then import below package for text copy to clipboard  functionality
import 'package:super_clipboard/super_clipboard.dart';

//stateful widget
class ScanQr extends StatefulWidget {
  const ScanQr({super.key});

  @override
  State<ScanQr> createState() => _ScanQrState();
}

class _ScanQrState extends State<ScanQr> {

  //global key for unique qr identity
  final qrKey = GlobalKey(debugLabel: 'QR');

  //qr view controller for controlling camera
  QRViewController? qrCtr;

  //barcode which gets after scanning the qr
  Barcode? barcode;

  //clipboard controller for handling copying in clipboard
  final clipboardCtr= ClipboardWriter.instance;

  //boolean variables for check flash is on/off and back cam is enable or front cam
  bool isFlashOn=false;
  bool isBackCam=true;

  //used to destroy qr controller when it is not need
  @override
  void dispose() {
    qrCtr?.disposed;
    super.dispose();
  }

  //after hot reload camara not stuck that's why it used
  @override
  void reassemble() async{
    super.reassemble();

    if(Platform.isAndroid){
      await qrCtr!.pauseCamera();
    }
    qrCtr!.resumeCamera();
  }

  //handling the clipboard
  void copyClipboard(String text) async {
    final item = DataWriterItem();
    item.add(Formats.plainText(text));
    await clipboardCtr.write([item]);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Copied to Clipboard:$text"))
    );
  }

  //
  @override
  Widget build(BuildContext context) {

    //qr view using this you can scan qrcode by camera(camera interface for qr code scanning)
    QRView qrView= QRView(key: qrKey,

      //initialize Qr controller
      onQRViewCreated: (QRViewController qrCtr){
        setState(() {
          this.qrCtr=qrCtr;
        });

        //after scanning the qr,store data in barcode variable
        qrCtr.scannedDataStream.listen((barcode){
          setState(() {
            this.barcode=barcode;
          });

          // if barcode variable is not it copies in clipboard
          if(barcode.code!=null){
            copyClipboard(barcode.code!);
          }

        });
      },
      //center part customizations
      overlay: QrScannerOverlayShape(
        borderRadius: 10,
        borderWidth: 10,
        borderLength: 20,
        borderColor: Colors.purple,
        cutOutSize: MediaQuery.of(context).size.width * 0.8
      ),
    );

    //bottom message box
    Positioned msg = Positioned(bottom:10,child: Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: Colors.white24),
      child: Text(
      barcode !=null ? '${barcode!.code}' : 'Scan QR'
      ),
    ));

    //flash icon button
    IconButton flash_tgl= IconButton(
      onPressed: () async {
        if (qrCtr != null) {
          await qrCtr!.toggleFlash();
          bool? flashStatus = await qrCtr!.getFlashStatus();
          setState(() {
            isFlashOn = flashStatus ?? false;
          });
        }
      } ,
      icon: Icon(isFlashOn ? Icons.flash_on : Icons.flash_off)
    );

    //switch camera icon button
    IconButton camera_tgl=IconButton(
        onPressed: () async {
          if (qrCtr != null) {
            await qrCtr!.flipCamera();
            setState(() {
              isBackCam = !isBackCam;
            });
          }
        },
        icon: Icon(Icons.cameraswitch)
    );

    //top icon(flash toggle/camera toggles) box
    Positioned quick_op = Positioned(top:10,child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: Colors.white24),
        child: Row(children: [flash_tgl,SizedBox(width: 10,),camera_tgl],)
      )
    );

    //returning childes in stack widget
    //(qrview must be first if not the top or bottom box will not showup )
    return Stack(alignment: Alignment.center,children: [qrView,quick_op,msg],);
  }
}