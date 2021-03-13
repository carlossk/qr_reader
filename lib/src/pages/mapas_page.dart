import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/src/providers/scan_provider.dart';

class MapasPage extends StatelessWidget {
  const MapasPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanProvider = Provider.of<ScanProvider>(context);

    return ListView.builder(
        itemCount: scanProvider.scans.length,
        itemBuilder: (_, i) => ListTile(
            onTap: () {
              print('hola');
            },
            title: Text(scanProvider.scans[i].valor),
            subtitle: Text('ID: ${scanProvider.scans[i].id}'),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
            leading: Icon(
              Icons.map,
              color: Theme.of(context).primaryColor,
            )));
  }
}
