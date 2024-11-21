import 'package:get/get.dart';
import 'package:test_tasknew/model/model_region.dart';
import 'package:test_tasknew/service/region_service.dart';

class RegionController extends GetxController {
  final RegionService regionService = RegionService();

  final RxList<ProvinsiModel> provinsiList = <ProvinsiModel>[].obs;
  final RxList<KotaModel> kotaList = <KotaModel>[].obs;
  final RxList<KecamatanModel> kecamatanList = <KecamatanModel>[].obs;

  // final Rx<ProvinsiModel?> selectedProvinsi = Rx<ProvinsiModel?>(null);
  // final Rx<KotaModel?> selectedKota = Rx<KotaModel?>(null);
  // final Rx<KecamatanModel?> selectedKecamatan = Rx<KecamatanModel?>(null);
  var selectedProvinsi = ''.obs;
  var selectedKota = ''.obs;
  var selectedKecamatan = ''.obs;

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  void reset(){
    selectedProvinsi.value = '';
    selectedKota.value = '';
    selectedKecamatan.value = '';

    provinsiList.clear();
    kotaList.clear();
    kecamatanList.clear();
  }

  @override
  void onInit() {
    super.onInit();
    fetchProvinsiList();
  }

  Future<void> fetchProvinsiList() async {
    try {
      isLoading.value = true;
      final result = await regionService.getProvinsiList();

      if (result.isNotEmpty) {
        // Validasi bahwa tidak ada nilai null dalam data yang diterima
        provinsiList.value = result.where((item) => item.id.isNotEmpty && item.nama.isNotEmpty).toList();
      } else {
        Get.snackbar('Info', 'Daftar provinsi kosong.');
      }
    } catch (e) {
      errorMessage.value = 'Gagal memuat data provinsi: $e';
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> fetchKotaList(String provinsiId) async {
    // try {
    //   isLoading.value = true;
    //   kotaList.value = await regionService.getKotaList(provinsiId);
    //   selectedKota.value = null;
    //   selectedKecamatan.value = null;
    // } catch (e) {
    //   errorMessage.value = e.toString();
    // } finally {
    //   isLoading.value = false;
    // }
    try{
      kotaList.value = await regionService.getKotaList(provinsiId);
    }catch (e){
      print('Error $e');
    }
  }

  Future<void> fetchKecamatanList(String kotaId) async {
  //   try {
  //     isLoading.value = true;
  //     kecamatanList.value = await regionService.getKecamatanList(kotaId);
  //     selectedKecamatan.value = null;
  //   } catch (e) {
  //     errorMessage.value = e.toString();
  //   } finally {
  //   }
  //   isLoading.value = false;
    try{
      kecamatanList.value = await regionService.getKecamatanList(kotaId);
    }catch(e){
      print('$e');
    }
  }

  // Reset method to clear all selections
  // void resetSelections() {
  //   selectedProvinsi.value = null;
  //   selectedKota.value = null;
  //   selectedKecamatan.value = null;
  // }
  void clearKotaandBelow(){
    kotaList.clear();
    selectedKota.value = '';
    clearKecamatanandBelow();
  }

  void clearKecamatanandBelow(){
    kecamatanList.clear();
    selectedKecamatan.value = '';
  }
}


