import 'package:get/get.dart';

class JournAPI extends GetConnect {
  final String baseUrl;
  Map<String, String> headers;

  JournAPI({this.baseUrl = 'https://journapi.app/api', String token}) {
    assert(token != null || token.isNotEmpty);
    setToken(token);
  }

  setToken(String token) {
    headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<Response> getBullets() {
    return get('/bullets/', headers: headers);
  }

  Future<Response> getBulletById(String bulletId) {
    return get('/bullets/$bulletId', headers: headers);
  }

  Future<Response> createBullet() {
    return post('/bullets', {}, headers: headers);
  }

  Future<Response> updateBullet(String bulletId) {
    return patch('/bullets/$bulletId', {}, headers: headers);
  }

  Future<Response> deleteBullet(String bulletId) {
    return delete('/bullets/$bulletId', headers: headers);
  }
}
