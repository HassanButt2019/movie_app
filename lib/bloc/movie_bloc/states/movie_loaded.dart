
import 'package:assignment2/bloc/movie_bloc/states/movie_state.dart';
import 'package:assignment2/data/models/movie.dart';

class LoadedMovie extends MovieState
{

  List<Movie>? upcomingMovies;

  LoadedMovie({this.upcomingMovies  });
  @override
  // TODO: implement props
  List<Object?> get props => [upcomingMovies];

}