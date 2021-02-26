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
    fetchBullets();
  }

  Future deleteBullet(int bulletId) {
    return api.deleteBullet(bulletId).then((value) {
      fetchBullets();
    });
  }

  Future updateBullet(int bulletId, String bullet, DateTime publishedAt) {
    return api.updateBullet(bulletId, bullet, publishedAt).then((value) {
      fetchBullets();
    });
  }

  Future fetchBullets() {
    return api.getBullets().then((Response response) {
      bullets.clear();
      bullets.addAll(response.body['data']);
    });
  }

  Future createBullet(String bullet, DateTime publishedAt) {
    return api.createBullet(bullet, publishedAt).then((value) {
      fetchBullets();
    });
  }

  void signout() {
    store.remove('TOKEN');
  }
}
