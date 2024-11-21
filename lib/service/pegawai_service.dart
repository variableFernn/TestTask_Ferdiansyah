import 'package:get/get.dart';
import 'package:test_tasknew/model/model_pegawai.dart';

class PegawaiService extends GetConnect {
  static const baseURL = 'https://61601920faa03600179fb8d2.mockapi.io/pegawai';

  Future<List<PegawaiModel>> getPegawaiList() async {
    final response = await get(baseURL);
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return (response.body as List)
          .map((json) => PegawaiModel.fromJson(json))
          .toList();
    }
  }

  Future<PegawaiModel> getPegawai(String id) async {
    final response = await get('$baseURL/$id');
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      return PegawaiModel.fromJson(response.body);
    }
  }

  Future<Response> createPegawai(PegawaiModel pegawai) async {
    final response = await post(baseURL, pegawai.toJson());
    return response;
  }

  Future<Response> updatePegawai(PegawaiModel pegawai) async {
    final response = await put(
        '$baseURL/${pegawai.id}',
        pegawai.toJson()
    );
    return response;
  }

  Future<Response> deletePegawai(String id) async {
    final response = await delete('$baseUrl/$id');
    return response;
  }
}