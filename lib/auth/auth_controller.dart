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
  TextEditingController baseEditingController =
      TextEditingController(text: 'https://journapi.app/api');

  @override
  void onReady() async {
    super.onReady();
    String token = store.read('TOKEN');
    String baseURL = store.read('URL');

    if (baseURL == null) {
      await store.write('URL', 'https://journapi.app/api');
    }

    if (token == null) {
      Get.offAndToNamed('/login');
    } else {
      validateToken(baseURL, token).then((isOK) {
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
        api = JournAPI(baseUrl: store.read('URL'), token: token);
        Get.offAndToNamed('/home');
      }
    });
  }

  Future<bool> validateToken(String url, String token) {
    JournAPI loginTestAPIClient = JournAPI(baseUrl: url, token: token);

    return loginTestAPIClient.getBullets().then((Response response) async {
      if (response.isOk) {
        if (api == null) {
          api = JournAPI(baseUrl: url, token: token);
        }
        api.setToken(token);
        await store.write('URL', url);
        await store.write('TOKEN', token);
      }
      return response.isOk;
    });
  }
}
