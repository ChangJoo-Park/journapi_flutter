import 'package:date_format/date_format.dart';
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

  Future<Response> createBullet(String bullet, DateTime dateTime) {
    Map<String, String> data = {
      "bullet": bullet,
      "published_at":
          formatDate(dateTime, [yyyy, '-', mm, '-', dd, 'T', HH, ':', nn]),
    };

    print(data);
    return post('/bullets', data, headers: headers);
  }

  Future<Response> updateBullet(
      int bulletId, String bullet, DateTime dateTime) {
    Map<String, String> data = {
      "bullet": bullet,
      "published_at":
          formatDate(dateTime, [yyyy, '-', mm, '-', dd, 'T', HH, ':', nn]),
    };
    return patch('/bullets/$bulletId', data, headers: headers);
  }

  Future<Response> deleteBullet(int bulletId) {
    return delete('/bullets/$bulletId', headers: headers);
  }
}
