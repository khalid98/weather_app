import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app/core/api/api_consumer.dart';

import 'package:weather_app/core/api/app_interceptors.dart';
import 'package:weather_app/core/api/end_points.dart';
import 'package:weather_app/core/api/status_code.dart';
import 'package:weather_app/core/error/exceptions.dart';

class DioConsumer implements ApiConsumer {
  static Dio? client;

  static init() {
    client = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        followRedirects: true,
        responseType: ResponseType.plain,
      ),
    );
    (client!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    client!.interceptors.add(AppIntercepters());
    if (kDebugMode) {
      client!.interceptors.add(LogInterceptor());
    }
  }

  @override
  Future get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
      await client!.get(path, queryParameters: queryParameters);
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future post(String path,
      {Map<String, dynamic>? body,
        bool formDataIsEnabled = false,
        Map<String, dynamic>? queryParameters,Map<String, dynamic>?headers}) async {
    try {
      print(body.toString());
      final response = await client!.post(path,
          queryParameters: queryParameters,
          options: Options(
              headers:headers
          ),
          data: formDataIsEnabled ? FormData.fromMap(body!) : body);

      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      print(error.response?.data.toString());
      _handleDioError(error);
    }
  }

  @override
  Future put(String path,
      {Map<String, dynamic>? body,
        Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
      await client!.put(path, queryParameters: queryParameters, data: body);
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future delete(String path,
      {Map<String, dynamic>? body,
        Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client!
          .delete(path, queryParameters: queryParameters, data: body);
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  dynamic _handleResponseAsJson(Response<dynamic> response) {
    final responseJson = jsonDecode(response.data.toString());
    return responseJson;
  }

  dynamic _handleDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw const FetchDataException();
      case DioErrorType.response:
        switch (error.response?.statusCode) {
          case StatusCode.badRequest:
            var decode = jsonDecode(error.response!.data);
            if (decode["message"] != null) {
              throw ServerException(decode["message"].toString());
            }
            throw const BadRequestException();
          case StatusCode.unauthorized:
          case StatusCode.forbidden:
          case StatusCode.UnprocessableContent:
            var decode = jsonDecode(error.response!.data);
            if (decode["message"] != null) {
              throw ServerException(decode["message"].toString());
            }
            throw const UnauthorizedException();
          case StatusCode.notFound:
            throw const NotFoundException();
          case StatusCode.confilct:
            throw const ConflictException();
          case StatusCode.internalServerError:
            throw const InternalServerErrorException();}
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        throw const NoInternetConnectionException();
      default:
        throw const ServerException("Something Went Wrong");
    }
  }
}
