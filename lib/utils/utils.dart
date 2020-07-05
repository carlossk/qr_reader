import 'package:qr_reader/src/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

launchURL(BuildContext context, ScanModel scan) async {
  print(scan.tipo);
  if (scan.tipo != 'geo') {
    if (await canLaunch(scan.valor)) {
      await launch(scan.valor);
    } else {
      throw 'Could not launch ${scan.valor}';
    }
  } else {
    Navigator.pushNamed(context, 'map', arguments: scan);
  }
}
