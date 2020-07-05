import 'dart:async';

import 'package:qr_reader/src/models/scan_model.dart';

class Validators {
  final geoValid =
      StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
          handleData: (scans, sink) {
    final geoScans = scans.where((element) => element.tipo == 'geo').toList();
    sink.add(geoScans);
  });
  final httpValid =
      StreamTransformer<List<ScanModel>, List<ScanModel>>.fromHandlers(
          handleData: (scans, sink) {
    final httpScans = scans.where((element) => element.tipo != 'geo').toList();
    sink.add(httpScans);
  });
}
