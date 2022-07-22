import 'package:dio/dio.dart';
import 'package:dio/src/response.dart' as dio_response;

import '../model/user.dart';

class UserServices {
  Future<List<User>> getAllUsers() async {
    dio_response.Response response;
    var dio = Dio();
    response = await dio.get('https://jsonplaceholder.typicode.com/users');
    return (response.data as List).map((e) => User.fromJson(e)).toList();
  }
}
