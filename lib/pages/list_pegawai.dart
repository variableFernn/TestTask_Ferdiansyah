import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_tasknew/controller/pegawai_controller.dart';
import 'package:test_tasknew/model/model_pegawai.dart';
import 'package:test_tasknew/pages/form_add_pegawai.dart';
import 'package:test_tasknew/pages/form_page.dart';

class PegawaiListView extends StatelessWidget {
  final PegawaiController _pegawaiController = Get.put(PegawaiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Pegawai'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _showPegawaiForm(null),
          )
        ],
      ),
      body: Obx(() {
        if (_pegawaiController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (_pegawaiController.errorMessage.isNotEmpty) {
          return Center(
            child: Text(_pegawaiController.errorMessage.value),
          );
        }

        return ListView.builder(
          itemCount: _pegawaiController.pegawaiList.length,
          itemBuilder: (context, index) {
            final pegawai = _pegawaiController.pegawaiList[index];
            return ListTile(
              title: Text(pegawai.nama),
              subtitle: Text('${pegawai.provinsiNama}, ${pegawai.kotaNama}, ${pegawai.kecamatanNama}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _showPegawaiForm(pegawai),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _confirmDelete(pegawai.id!),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  void _showPegawaiForm(PegawaiModel? pegawai) {
    Get.to(() => FormPage());
  }

  void _confirmDelete(String id) {
    Get.defaultDialog(
      title: 'Konfirmasi Hapus',
      content: Text('Apakah Anda yakin ingin menghapus pegawai ini?'),
      textConfirm: 'Hapus',
      textCancel: 'Batal',
      onConfirm: () {
        _pegawaiController.deletePegawai(id);
        Get.back(); // Close dialog
      },
    );
  }
}