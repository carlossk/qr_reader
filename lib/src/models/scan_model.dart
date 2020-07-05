import 'package:latlong/latlong.dart';

class ScanModel {
  int id;
  String tipo;
  String valor;

  ScanModel({
    this.id,
    this.tipo,
    this.valor,
  }) {
    if (valor.contains(':')) {
      tipo = valor.split(':')[0].trim();
    } else {
      tipo = 'unknown';
    }
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => new ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
      };
  LatLng getLatLang() {
    final latLang = valor.substring(4).split(',');
    final lat = double.parse(latLang[0]);
    final lang = double.parse(latLang[1]);
    return LatLng(lat, lang);
  }
}
