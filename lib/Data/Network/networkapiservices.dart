import 'dart:convert';
import 'dart:io';

import 'package:mvvm_/Data/Network/baseapiservices.dart';
import 'package:mvvm_/Data/app_exceptions.dart';
import 'package:http/http.dart' as http;

class NetworkApiService extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      http.Response response =
          await http.post(Uri.parse(url),body: data
          ).timeout(Duration(seconds: 10));
          responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
    return responseJson;
  }
}

dynamic returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      dynamic responseJson = jsonDecode(response.body);
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 404:
      throw UnAuthorisedException();
    default:
      throw FetchDataException(
          "Error Occured While Communicating With The Server" +
              "With Status Code" +
              response.statusCode.toString());
  }
}
