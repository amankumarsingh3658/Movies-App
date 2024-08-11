import 'package:mvvm_/Data/Network/baseapiservices.dart';
import 'package:mvvm_/Data/Network/networkapiservices.dart';
import 'package:mvvm_/Resources/appurls.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> loginApi(dynamic data) async{
    try {
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.loginUrl, data);
      return response;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<dynamic> signUpApi(dynamic data)async {
    try {
      dynamic response = await _apiServices.getPostApiResponse(AppUrl.registerUrl, data);
      return response;
    } catch (e) {
      e.toString();
    }
  }
}