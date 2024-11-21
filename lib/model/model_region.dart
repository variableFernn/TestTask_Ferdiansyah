class ProvinsiModel {
  String id;
  String nama;

  ProvinsiModel({
    required this.id,
    required this.nama,
  });

  factory ProvinsiModel.fromJson(Map<String, dynamic> json) => ProvinsiModel(
    id: json['id'],
    nama: json['nama'],
  );
}

class KotaModel {
  String id;
  String provinsiId;
  String nama;

  KotaModel({
    required this.id,
    required this.provinsiId,
    required this.nama,
  });

  factory KotaModel.fromJson(Map<String, dynamic> json) => KotaModel(
    id: json['id'],
    provinsiId: json['provinsi_id'],
    nama: json['nama'],
  );
}

class KecamatanModel {
  String id;
  String kotaId;
  String nama;

  KecamatanModel({
    required this.id,
    required this.kotaId,
    required this.nama,
  });

  factory KecamatanModel.fromJson(Map<String, dynamic> json) => KecamatanModel(
    id: json['id'],
    kotaId: json['kota_id'],
    nama: json['nama'],
  );
}