import 'dart:async';

import 'package:qr_reader/src/bloc/validators.dart';
import 'package:qr_reader/src/models/scan_model.dart';
import 'package:qr_reader/src/providers/db_provider.dart';

class ScansBloc with Validators{
  static final ScansBloc _singleton = ScansBloc._internal();

  factory ScansBloc() {
    return _singleton;
  }

  ScansBloc._internal() {
    getScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansController.stream.transform(geoValid);
  Stream<List<ScanModel>> get scansStreamHttp => _scansController.stream.transform(httpValid);

  dispose() {
    _scansController?.close();
  }

  getScans() async {
    _scansController.sink.add(await DBProvider.db.getScans());
  }

  deleteScanById(int id) async {
    await DBProvider.db.deleteScan(id);
    getScans();
  }

  deleteScans() async {
    await DBProvider.db.deleteScanAll();
    getScans();
  }

  addScan(ScanModel scan) async {
    await DBProvider.db.createScan(scan);
    getScans();
  }
  
}
