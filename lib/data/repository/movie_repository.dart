
import 'package:assignment2/data/data_provider/movie_data_provider.dart';
import 'package:assignment2/data/models/movie.dart';
import 'package:http/http.dart' as http;


import 'dart:convert';


class MovieReposiotry
{
  final MovieDataProvider _provider = MovieDataProvider();
  Future<List<Movie>>  searchMovies({String query='Unknown' }) async
  {
    http.Response rawData = await _provider.searchMovies(query:query);
    final json = jsonDecode(rawData.body) ;
    List<Movie> data = [];
    if(json != null) {
      data = json["results"].map<Movie>((model) => Movie.fromJson(model)).toList();
    }

    return data;
  }

  Future<List<Movie>>  upComingMovies() async
  {
    http.Response rawData = await _provider.upComingMovies();
    final json = jsonDecode(rawData.body) ;
    List<Movie> data = json["results"].map<Movie>((model) => Movie.fromJson(model)).toList();
    return data;
  }

}