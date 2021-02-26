import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:journapi/provider.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();
  final store = GetStorage();
  JournAPI api;
  RxBool hasAPIKey = false.obs;
  RxBool validAPIKey = false.obs;
  TextEditingController tokenEditingController = TextEditingController();

  @override
  void onReady() {
    super.onReady();
    String token = store.read('TOKEN');

    if (token == null) {
      Get.offAndToNamed('/login');
    } else {
      validateToken(token).then((isOK) {
        if (isOK) {
          Get.offAndToNamed('/home');
        } else {
          Get.offAndToNamed('/login');
        }
      });
    }

    // Triggered when APIKEY changed
    store.listenKey('TOKEN', (token) {
      if (token == null) {
        Get.offAndToNamed('/login');
      } else {
        api = JournAPI(token: token);
        Get.offAndToNamed('/home');
      }
    });
  }

  Future<bool> validateToken(token) {
    JournAPI loginTestAPIClient = JournAPI(token: token);

    return loginTestAPIClient.getBullets().then((Response response) async {
      if (response.isOk) {
        if (api == null) {
          api = JournAPI(token: token);
        }
        api.setToken(token);
        await store.write('TOKEN', token);
      }
      return response.isOk;
    });
  }
}
