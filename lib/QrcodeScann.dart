import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QrCodeScan extends StatefulWidget {
  @override
  _QrCodeScanState createState() => _QrCodeScanState();
}

class _QrCodeScanState extends State<QrCodeScan> {
  String result = "Silahkan Klik MULAI SCANN";
  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission denied";
        });
      } else {
        setState(() {
          result = "Unkown error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "Kamu Belum Melakukan Scann";
      });
    }catch(e){
      setState(() {
        result = "Unkown error $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text("Aplikasi QR Code Scanner Sederhana"),
        ),

        body:Center(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(2),
                  child: Image.asset('assets/qrcode.jpg', fit: BoxFit.fitWidth,) ,
                ),
                Text(
                  result,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ), textAlign: TextAlign.center,
                ),
                new SizedBox(
                  height: 20.0,),
                new SizedBox(
                  child: new RaisedButton(
                    onPressed: () {
                      _scanQR();
                    },
                    textColor: Colors.white,
                    color: Colors.black,
                    child: Text('MULAI SCANN', style: TextStyle(fontSize: 20)),
                  ),
                )

              ],
            )

        )

    );
  }
}