import 'movie_event.dart';

class SearchMovie extends MovieEvent
{
  final String? query;
  SearchMovie({required this.query});


  @override

  List<Object?> get props => [query];

}