import 'package:flutter/material.dart';
import 'package:mvvm_/Data/Response/api_response.dart';
import 'package:mvvm_/Models/movielistmodel.dart';
import 'package:mvvm_/Repositories/homerepo.dart';

class HomeViewModel with ChangeNotifier {
  final _myrepo = HomeRepo();

  ApiResponse<MovieListModel> movielistresponse = ApiResponse.loading();

  setMoviesList(ApiResponse<MovieListModel> response) {
    movielistresponse = response;
    notifyListeners();
  }

  Future<void> fetchMoviesListApi() async {
    setMoviesList(ApiResponse.loading());
    _myrepo.moviesApi().then((value) {
      setMoviesList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setMoviesList(ApiResponse.error(error.toString()));
      print(error.toString());
    });
  }
}
