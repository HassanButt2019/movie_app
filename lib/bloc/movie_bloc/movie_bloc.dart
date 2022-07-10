import 'package:assignment2/bloc/movie_bloc/events/get_movie.dart';
import 'package:assignment2/bloc/movie_bloc/events/movie_event.dart';
import 'package:assignment2/bloc/movie_bloc/events/search_movie.dart';
import 'package:assignment2/bloc/movie_bloc/states/movie_failure.dart';
import 'package:assignment2/bloc/movie_bloc/states/movie_initial.dart';
import 'package:assignment2/data/models/movie.dart';
import 'package:assignment2/data/repository/movie_repository.dart';
import 'package:bloc/bloc.dart';
import 'states/movie_loaded.dart';
import 'states/movie_state.dart';
import 'states/searched_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieReposiotry reposiotry = MovieReposiotry();
  List<Movie>?  upComingmovies = [];

  List<Movie>?  searchedMovies = [];

  bool isUpdate = false;


  MovieBloc(this.reposiotry) : super(InitialMovie()){
    on<RequestMovie>(_onRequestMovie);
    on<SearchMovie>(_onSearchMovie);

  }


  void clearMovies()
  {
    searchedMovies!.clear();
  }


  void _onRequestMovie(
      RequestMovie event,
      Emitter<MovieState> emit,
      ) async {
    try {
      upComingmovies = await reposiotry.upComingMovies();
      emit(LoadedMovie(upcomingMovies:upComingmovies , ));

    } catch (e) {
      emit( FailureMovie(error: e.toString()));
  }
  }

  void _onSearchMovie(
      SearchMovie event,
      Emitter<MovieState> emit,
      ) async {
    try {
      searchedMovies = await reposiotry.searchMovies(query: event.query!);
      emit( SearchLoadedMovie().copyWith(searchMovies: searchedMovies));
    } catch (e) {
      emit( FailureMovie(error: e.toString()));
    }
  }
}

//1)
//2)