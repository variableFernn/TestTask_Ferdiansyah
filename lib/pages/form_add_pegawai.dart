// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:test_tasknew/controller/pegawai_controller.dart';
// import 'package:test_tasknew/controller/region_controller.dart';
// import 'package:test_tasknew/model/model_pegawai.dart';
// import 'package:test_tasknew/model/model_region.dart';
//
// class PegawaiFormView extends StatelessWidget {
//   final PegawaiModel? pegawai;
//   final PegawaiController _pegawaiController = Get.find<PegawaiController>();
//   final RegionController _regionController = Get.put(RegionController());
//
//   PegawaiFormView({Key? key, this.pegawai}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // Populate form with existing data if editing
//     if (pegawai != null) {
//       _regionController.selectedProvinsi.value = ProvinsiModel(
//           id: pegawai!.provinsiId,
//           nama: pegawai!.provinsiNama
//       );
//       _regionController.fetchKotaList(pegawai!.provinsiId);
//       _regionController.selectedKota.value = KotaModel(
//           id: pegawai!.kotaId,
//           provinsiId: pegawai!.provinsiId,
//           nama: pegawai!.kotaNama
//       );
//       _regionController.fetchKecamatanList(pegawai!.kotaId);
//       _regionController.selectedKecamatan.value = KecamatanModel(
//           id: pegawai!.kecamatanId,
//           kotaId: pegawai!.kotaId,
//           nama: pegawai!.kecamatanNama
//       );
//     }
//
//     final TextEditingController namaController = TextEditingController(
//         text: pegawai?.nama ?? ''
//     );
//     final TextEditingController jalanController = TextEditingController(
//         text: pegawai?.jalan ?? ''
//     );
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(pegawai == null ? 'Tambah Pegawai' : 'Edit Pegawai'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: namaController,
//               decoration: InputDecoration(
//                 labelText: 'Nama Pegawai',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: jalanController,
//               decoration: InputDecoration(
//                 labelText: 'Alamat Jalan',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 16),
//
//             // Provinsi Dropdown
//             Obx(() {
//               if (_regionController.isLoading.value) {
//                 return Center(child: CircularProgressIndicator());
//               }
//               return DropdownButtonFormField<ProvinsiModel>(
//                 decoration: InputDecoration(
//                   labelText: 'Provinsi',
//                   border: OutlineInputBorder(),
//                 ),
//                 value: _regionController.selectedProvinsi.value,
//                 items: _regionController.provinsiList.map((provinsi) {
//                   return DropdownMenuItem(
//                     value: provinsi,
//                     child: Text(provinsi.nama),
//                   );
//                 }).toList(),
//                 onChanged: (selectedProvinsi) {
//                   _regionController.selectedProvinsi.value = selectedProvinsi;
//                   _regionController.fetchKotaList(selectedProvinsi!.id);
//                   _regionController.selectedKota.value = null;
//                   _regionController.selectedKecamatan.value = null;
//                 },
//               );
//             }),
//             SizedBox(height: 16),
//
//             // Kota Dropdown
//             Obx(() {
//               return DropdownButtonFormField<KotaModel>(
//                 decoration: InputDecoration(
//                   labelText: 'Kota/Kabupaten',
//                   border: OutlineInputBorder(),
//                 ),
//                 value: _regionController.selectedKota.value,
//                 items: _regionController.kotaList.map((kota) {
//                   return DropdownMenuItem(
//                     value: kota,
//                     child: Text(kota.nama),
//                   );
//                 }).toList(),
//                 onChanged: (selectedKota) {
//                   _regionController.selectedKota.value = selectedKota;
//                   _regionController.fetchKecamatanList(selectedKota!.id);
//                   _regionController.selectedKecamatan.value = null;
//                 },
//               );
//             }),
//             SizedBox(height: 16),
//
//             // Kecamatan Dropdown
//             Obx(() {
//               return DropdownButtonFormField<KecamatanModel>(
//                 decoration: InputDecoration(
//                   labelText: 'Kecamatan',
//                   border: OutlineInputBorder(),
//                 ),
//                 value: _regionController.selectedKecamatan.value,
//                 items: _regionController.kecamatanList.map((kecamatan) {
//                   return DropdownMenuItem(
//                     value: kecamatan,
//                     child: Text(kecamatan.nama),
//                   );
//                 }).toList(),
//                 onChanged: (selectedKecamatan) {
//                   _regionController.selectedKecamatan.value = selectedKecamatan;
//                 },
//               );
//             }),
//             SizedBox(height: 24),
//
//             ElevatedButton(
//               onPressed: () {
//                 // Validation
//                 if (namaController.text.isEmpty) {
//                   Get.snackbar('Error', 'Nama Pegawai harus diisi');
//                   return;
//                 }
//
//                 if (_regionController.selectedProvinsi.value == null ||
//                     _regionController.selectedKota.value == null ||
//                     _regionController.selectedKecamatan.value == null) {
//                   Get.snackbar('Error', 'Silakan pilih wilayah lengkap');
//                   return;
//                 }
//
//                 // Prepare Pegawai Model
//                 final newPegawai = PegawaiModel(
//                   id: pegawai?.id, // Use existing ID if editing
//                   nama: namaController.text,
//                   jalan: jalanController.text,
//                   provinsiId: _regionController.selectedProvinsi.value!.id,
//                   provinsiNama: _regionController.selectedProvinsi.value!.nama,
//                   kotaId: _regionController.selectedKota.value!.id,
//                   kotaNama: _regionController.selectedKota.value!.nama,
//                   kecamatanId: _regionController.selectedKecamatan.value!.id,
//                   kecamatanNama: _regionController.selectedKecamatan.value!.nama,
//                 );
//
//                 // Add or Update
//                 if (pegawai == null) {
//                   _pegawaiController.addPegawai(newPegawai);
//                 } else {
//                   _pegawaiController.updatePegawai(newPegawai);
//                 }
//               },
//               child: Text(pegawai == null ? 'Tambah Pegawai' : 'Update Pegawai'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }