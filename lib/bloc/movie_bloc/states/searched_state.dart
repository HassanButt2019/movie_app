import 'package:assignment2/data/models/movie.dart';

import 'movie_state.dart';

class SearchLoadedMovie extends MovieState
{

  List<Movie>? searchMovies;


  SearchLoadedMovie copyWith({
    List<Movie>? searchMovies

  })=>SearchLoadedMovie(searchMovies: searchMovies ??this.searchMovies);


  SearchLoadedMovie({this.searchMovies  });
  @override
  // TODO: implement props
  List<Object?> get props => [searchMovies];

}