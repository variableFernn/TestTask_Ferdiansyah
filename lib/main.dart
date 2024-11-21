import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_tasknew/controller/pegawai_controller.dart';
import 'package:test_tasknew/controller/region_controller.dart';
import 'package:test_tasknew/pages/form_add_pegawai.dart';
import 'package:test_tasknew/pages/form_page.dart';
import 'package:test_tasknew/pages/list_pegawai.dart';
import 'package:test_tasknew/service/pegawai_service.dart';
import 'package:test_tasknew/service/region_service.dart';

void main() {
  Get.put(PegawaiService());
  Get.put(RegionService());
  Get.put(PegawaiController());
  Get.put(RegionController());
  Get.put(PegawaiListView());
  // Get.put(PegawaiFormView());
  Get.put(FormPage());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PegawaiListView(),
    );
  }
}

