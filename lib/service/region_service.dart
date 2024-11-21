import 'package:get/get.dart';
import 'package:test_tasknew/model/model_region.dart';

class RegionService extends GetConnect {
  static const provinsiUrl = 'https://www.emsifa.com/api-wilayah-indonesia/api/provinces.json';
  static const kotaBaseUrl = 'https://www.emsifa.com/api-wilayah-indonesia/api/regencies/';
  static const kecamatanBaseUrl = 'https://www.emsifa.com/api-wilayah-indonesia/api/districts/';

  Future<List<ProvinsiModel>> getProvinsiList() async {
    final response = await get(provinsiUrl);
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return (response.body as List)
          .map((json) => ProvinsiModel.fromJson(json))
          .toList();
    }
  }

  Future<List<KotaModel>> getKotaList(String provinsiId) async {
    final response = await get('$kotaBaseUrl$provinsiId.json');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return (response.body as List)
          .map((json) => KotaModel.fromJson(json))
          .toList();
    }
  }

  Future<List<KecamatanModel>> getKecamatanList(String kotaId) async {
    final response = await get('$kecamatanBaseUrl$kotaId.json');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return (response.body as List)
          .map((json) => KecamatanModel.fromJson(json))
          .toList();
    }
  }
}
