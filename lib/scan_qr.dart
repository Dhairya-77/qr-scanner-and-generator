import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:super_clipboard/super_clipboard.dart';

class ScanQr extends StatefulWidget {
  const ScanQr({super.key});

  @override
  State<ScanQr> createState() => _ScanQrState();
}

class _ScanQrState extends State<ScanQr> {

  //global key
  final qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController? qrCtr;

  Barcode? barcode;

  final clipboardCtr= ClipboardWriter.instance;

  bool isFlashOn=false;
  bool isBackCam=true;

  @override
  void dispose() {
    qrCtr!.disposed;
    super.dispose();
  }

  @override
  void reassemble() async{
    super.reassemble();

    if(Platform.isAndroid){
      await qrCtr!.pauseCamera();
    }
    qrCtr!.resumeCamera();
  }

  void copyClipboard(String text) async {
    final item = DataWriterItem();
    item.add(Formats.plainText(text));
    await clipboardCtr.write([item]);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Copied to Clipboard:$text"))
    );
  }

  @override
  Widget build(BuildContext context) {

    QRView qrView= QRView(key: qrKey,
      onQRViewCreated: (QRViewController qrCtr){
        setState(() {
          this.qrCtr=qrCtr;
        });
        qrCtr.scannedDataStream.listen((barcode){
          setState(() {
            this.barcode=barcode;
          });

          if(barcode.code!=null){
            copyClipboard(barcode.code!);
          }

        });
      },
      overlay: QrScannerOverlayShape(
        borderRadius: 10,
        borderWidth: 10,
        borderLength: 20,
        borderColor: Colors.purple,
        cutOutSize: MediaQuery.of(context).size.width * 0.8
      ),
    );

    Positioned msg = Positioned(bottom:10,child: Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: Colors.white24),
      child: Text(
      barcode !=null ? '${barcode!.code}' : 'Scan QR'
      ),
    ));

    IconButton flash_tgl= IconButton(
      onPressed: () async {
        await qrCtr?.toggleFlash();
        setState(() {
          isFlashOn=!isFlashOn;
        });
      } ,
      icon: FutureBuilder<bool?>(
          future: qrCtr?.getFlashStatus(),
          builder: (context,snapshot){
            if(snapshot.data != null){
              return Icon(snapshot.data! ? Icons.flash_on  : Icons.flash_off);
            }
            else{
              return Container();
            }
          })
    );

    IconButton camera_tgl=IconButton(
        onPressed: () async {
          await qrCtr?.flipCamera();
          setState(() {
            isBackCam=!isBackCam;
          });
        },
        icon:FutureBuilder(
            future: qrCtr?.getCameraInfo(),
            builder: (context,snapshot){
              if(snapshot.data != null){
                return Icon(Icons.cameraswitch);
              }
              else{
                return Container();
              }
            })
    );


    Positioned quick_op = Positioned(top:10,child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: Colors.white24),
        child: Row(children: [flash_tgl,SizedBox(width: 10,),camera_tgl],)
      )
    );

    return Stack(alignment: Alignment.center,children: [qrView,quick_op,msg],);
  }
}