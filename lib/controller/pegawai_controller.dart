import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_tasknew/model/model_pegawai.dart';
import 'package:test_tasknew/service/pegawai_service.dart';

class PegawaiController extends GetxController {
  final PegawaiService pegawaiService = PegawaiService();

  // final RxList<PegawaiModel> pegawaiList = <PegawaiModel>[].obs;
  // final Rx<PegawaiModel?> selectedPegawai = Rx<PegawaiModel?>(null);
  //
  // final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  var selectedPegawai = ''.obs;
  var pegawaiList = <PegawaiModel>[].obs;
  var isLoading = false.obs;


  @override
  void onInit() {
    super.onInit();
    fetchPegawaiList();
  }

  Future<void> fetchPegawaiList() async {
    try {
      isLoading.value = true;
      pegawaiList.value = await pegawaiService.getPegawaiList();
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addPegawai(PegawaiModel pegawai) async {
    try {
      isLoading.value = true;
      await pegawaiService.createPegawai(pegawai);
      await fetchPegawaiList();
      Get.back(); // Close form/dialog
      Get.snackbar('Success', 'Pegawai added successfully');
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatePegawai(PegawaiModel pegawai) async {
    try {
      isLoading.value = true;
      await pegawaiService.updatePegawai(pegawai);
      await fetchPegawaiList();
      Get.back(); // Close form/dialog
      Get.snackbar('Success', 'Pegawai updated successfully');
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deletePegawai(String id) async {
    try {
      isLoading.value = true;
      await pegawaiService.deletePegawai(id);
      await fetchPegawaiList();
      Get.snackbar('Success', 'Pegawai deleted successfully');
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }
}