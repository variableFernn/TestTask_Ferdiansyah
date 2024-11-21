import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_tasknew/controller/pegawai_controller.dart';
import 'package:test_tasknew/controller/region_controller.dart';
import 'package:test_tasknew/model/model_pegawai.dart';
import 'package:test_tasknew/model/model_region.dart';

class FormPage extends StatelessWidget {
  const FormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pegawaiController = Get.find<PegawaiController>();
    final regionController = Get.find<RegionController>();

    final TextEditingController namaController = TextEditingController();
    final TextEditingController jalanController = TextEditingController();

    if (pegawaiController.selectedPegawai.isNotEmpty) {
      var pegawai = pegawaiController.pegawaiList.firstWhere(
              (item) => item.id == pegawaiController.selectedPegawai.value);
      namaController.text = pegawai.nama;
      jalanController.text = pegawai.jalan;

      regionController.selectedProvinsi.value = pegawai.provinsiId ?? '';
      regionController.selectedKota.value = pegawai.kotaId ?? '';
      regionController.selectedKecamatan.value = pegawai.kecamatanId ?? '';

      regionController.fetchProvinsiList();
      regionController.fetchKotaList(pegawai.provinsiId ?? '');
      regionController.fetchKecamatanList(pegawai.kotaId ?? '');
    } else {
      regionController.reset();
    }

    return Scaffold(
      appBar: AppBar(),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              TextField(
                controller: namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Pegawai',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: jalanController,
                decoration: const InputDecoration(
                  labelText: 'Alamat Jalan',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              _buildDropDown(
                hint: 'Pilih Provinsi',
                items: regionController.provinsiList,
                value: regionController.selectedProvinsi.value,
                onChanged: (value) {
                  if (value != null) {
                    regionController.selectedProvinsi.value = value;
                    regionController.clearKotaandBelow();
                    regionController.fetchKotaList(value);
                  } else {
                    regionController.reset();
                  }
                },
              ),
              const SizedBox(height: 16),
              _buildDropDown(

                hint: 'Pilih Kota',
                items: regionController.kotaList,
                value: regionController.selectedKota.value,
                onChanged: (value) {
                  if (value != null) {
                    regionController.selectedKota.value = value;
                    regionController.clearKecamatanandBelow();
                    regionController.fetchKecamatanList(value);
                  }
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // if (namaController.text.isEmpty ||
                  //     jalanController.text.isEmpty ||
                  //     regionController.selectedProvinsi.value.isEmpty ||
                  //     regionController.selectedKota.value.isEmpty ||
                  //     regionController.selectedKecamatan.value.isEmpty) {
                  //   Get.snackbar('Error', 'Lengkapi semua field!');
                  //   return;
                  // }
                  //
                  // PegawaiModel pegawai = PegawaiModel(
                  //
                  //   nama: namaController.text,
                  //   jalan: jalanController.text,
                  //   provinsiId: regionController.selectedProvinsi.value,
                  //   kotaId: regionController.selectedKota.value,
                  //   kecamatanId: regionController.selectedKecamatan.value,
                  //
                  // );
                  //
                  // if (pegawaiController.selectedPegawai.isEmpty) {
                  //   pegawaiController.addPegawai(pegawai);
                  //   pegawaiController.fetchPegawaiList();
                  // } else {
                  //   pegawaiController.updatePegawai(pegawai);
                  // }
                },
                child: Text(
                  pegawaiController.selectedPegawai.isEmpty
                      ? 'Tambah Pegawai'
                      : 'Update Pegawai',
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDropDown<T>({
    required String hint,
    required List<T> items,
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return Obx(() {
      final validValue = items.any((item) => (item as dynamic).id == value) ? value : null;
      return DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: hint,
          border: OutlineInputBorder(),
        ),
        value: validValue, // Mengizinkan null untuk nilai awal
        items: items.map((item) {
          final model = item as dynamic;
          return DropdownMenuItem<String>(
            value: model.id,
            child: Text(model.nama), // Menampilkan nama
          );
        }).toList(),
        onChanged: onChanged,
      );
    });
  }

}
