


import 'movie_event.dart';

class GetSimilarMovies extends MovieEvent
{
  final String id;
  GetSimilarMovies({required this.id});
  @override
  // TODO: implement props
  List<Object?> get props => [id];

}