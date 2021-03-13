import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/src/bloc/scans_bloc.dart';
import 'package:qr_reader/src/models/scan_model.dart';
import 'package:qr_reader/src/providers/scan_provider.dart';
import 'package:qr_reader/utils/utils.dart' as utils;

class ScanButton extends StatefulWidget {
  const ScanButton({Key key}) : super(key: key);

  @override
  _ScanButtonState createState() => _ScanButtonState();
}

class _ScanButtonState extends State<ScanButton> {
  final scanBloc = ScansBloc();

  @override
  Widget build(BuildContext context) {
    final scanProvider = Provider.of<ScanProvider>(context);
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () {
        print('testetetetete');
        String barcodeScanRes = 'geo:49.468000, 17.115140';
        print(barcodeScanRes);
        if (barcodeScanRes == -1) {
          return;
        }

        final scan = ScanModel(valor: barcodeScanRes);
        
        scanProvider.createScan(barcodeScanRes);
        scanProvider.createScan('http://google.com');


        if (Platform.isIOS) {
          Future.delayed(Duration(milliseconds: 750), () {
            utils.launchURL(context, scan);
          });
        } else {
          utils.launchURL(context, scan);
        }
      },
      child: Icon(Icons.filter_center_focus),
    );
  }

  _scanQr(BuildContext context) async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#3D8BEF', 'Cancel', false, ScanMode.QR);
    return barcodeScanRes;
  }
}
