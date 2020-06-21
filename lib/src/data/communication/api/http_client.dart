import 'package:allthenews/src/data/communication/api/request.dart';
import 'package:allthenews/src/domain/authorization/api_key_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

abstract class _Constants {
  static const logPrintWidthSize = 300;
  static const apiKeyParam = "api-key";
}

class HttpClient {
  final Dio _dio = Dio();
  final String _baseUrl;
  final ApiKeyRepository _apiKeyRepository;

  HttpClient(
    this._baseUrl,
    this._apiKeyRepository,
  ) {
    _dio.options.baseUrl = _baseUrl;

    _dio.interceptors
      ..add(
        InterceptorsWrapper(onRequest: _onRequest),
      )
      ..add(
        PrettyDioLogger(
          requestHeader: kDebugMode,
          requestBody: kDebugMode,
          responseHeader: kDebugMode,
          responseBody: kDebugMode,
          maxWidth: _Constants.logPrintWidthSize,
        ),
      );
  }

  void _onRequest(RequestOptions options) async {
    var apiKey = await _apiKeyRepository.getKey();
    options.queryParameters = {_Constants.apiKeyParam: apiKey.value};
  }

  Future<dynamic> get(Request request) async {
    return await _dio.get<dynamic>(request.path, queryParameters: request.queryParameters);
  }
}