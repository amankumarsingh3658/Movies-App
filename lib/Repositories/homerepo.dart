import 'package:flutter/material.dart';
import 'package:mvvm_/Data/Network/baseapiservices.dart';
import 'package:mvvm_/Data/Network/networkapiservices.dart';
import 'package:mvvm_/Models/movielistmodel.dart';
import 'package:mvvm_/Resources/appurls.dart';

class HomeRepo {
  BaseApiServices _apiServices = NetworkApiService();

  Future<MovieListModel> moviesApi() async{
    try {
      dynamic response = await _apiServices.getGetApiResponse(AppUrl.moviesList);
      return response = MovieListModel.fromJson(response);
    } catch (e) {
      throw e.toString();
    }
  }
}