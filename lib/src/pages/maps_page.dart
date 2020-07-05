import 'package:flutter/material.dart';
import 'package:qr_reader/src/bloc/scans_bloc.dart';
import 'package:qr_reader/src/models/scan_model.dart';
import 'package:qr_reader/utils/utils.dart' as utils;

class MapPage extends StatelessWidget {
  final scanBloc = ScansBloc();

  @override
  Widget build(BuildContext context) {
    scanBloc.getScans();
    return StreamBuilder<List<ScanModel>>(
        stream: scanBloc.scansStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final scans = snapshot.data;
          if (scans.length == 0) {
            return Center(
              child: Text('No Data'),
            );
          }
          return ListView.builder(
            itemCount: scans.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: UniqueKey(),
                background: Container(color: Colors.red),
                child: ListTile(
                  leading: Icon(Icons.cloud_queue),
                  title: Text(scans[index].valor),
                  subtitle: Text('ID: ${scans[index].id}'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    utils.launchURL(context, scans[index]);
                  },
                ),
                onDismissed: (direction) {
                  scanBloc.deleteScanById(scans[index].id);
                },
              );
            },
          );
        });
  }
}
