// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';

final Dio dio = Dio(
  BaseOptions(
    baseUrl: 'https://68f060070b966ad50032b145.mockapi.io/poli',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ),
);

class ApiClient {
  // GET request
  Future<Response> get(String path) async {
    try {
      final response = await dio.get(Uri.encodeFull(path));
      return response;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  // POST request
  Future<Response> post(String path, dynamic data) async {
    try {
      final response = await dio.post(Uri.encodeFull(path), data: data);
      return response;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  // PUT request
  Future<Response> put(String path, dynamic data) async {
    try {
      final response = await dio.put(Uri.encodeFull(path), data: data);
      return response;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }

  // DELETE request
  Future<Response> delete(String path) async {
    try {
      final response = await dio.delete(Uri.encodeFull(path));
      return response;
    } on DioException catch (e) {
      throw Exception(e.message);
    }
  }
}
