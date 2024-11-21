class PegawaiModel {
  String? id;
  String nama;
  String jalan;
  String provinsiId;
  String provinsiNama;
  String kotaId;
  String kotaNama;
  String kecamatanId;
  String kecamatanNama;

  PegawaiModel({
    this.id,
    required this.nama,
    required this.jalan,
    required this.provinsiId,
    required this.provinsiNama,
    required this.kotaId,
    required this.kotaNama,
    required this.kecamatanId,
    required this.kecamatanNama,
  });

  factory PegawaiModel.fromJson(Map<String, dynamic> json) => PegawaiModel(
    id: json['id']?.toString() ?? '',
    nama: json['nama'] ?? '',
    jalan: json['jalan'] ?? '',
    provinsiId: _parseId(json['provinsi']),
    provinsiNama: _parseName(json['provinsi']),
    kotaId: _parseId(json['kabupaten']),
    kotaNama: _parseName(json['kabupaten']),
    kecamatanId: _parseId(json['kecamatan']),
    kecamatanNama: _parseName(json['kecamatan']),
  );

  static String _parseId(dynamic data) {
    if (data == null) return '';
    if (data is Map) {
      return data['id']?.toString() ?? '';
    }
    return data?.toString() ?? '';
  }

  static String _parseName(dynamic data) {
    if (data == null) return '';
    if (data is Map) {
      return data['name'] ?? data['nama'] ?? '';
    }
    return '';
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nama': nama,
    'jalan': jalan,
    'provinsi': {
      'id': provinsiId,
      'name': provinsiNama,
    },
    'kabupaten': {
      'id': kotaId,
      'name': kotaNama,
    },
    'kecamatan': {
      'id': kecamatanId,
      'name': kecamatanNama,
    },
  };
}