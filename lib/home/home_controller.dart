import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:journapi/provider.dart';

class HomeController extends GetxController {
  JournAPI api;
  final store = GetStorage();
  final bullets = {}.obs;

  final newBulletController = TextEditingController();
  final newDate = DateTime.now().obs;

  @override
  void onInit() {
    api = JournAPI(token: store.read('TOKEN'));
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    api.getBullets().then((Response response) {
      bullets.clear();
      bullets.addAll(response.body['data']);

      print(bullets);
    });
  }
}
