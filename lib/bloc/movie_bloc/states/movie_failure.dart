


import 'movie_state.dart';

class FailureMovie extends MovieState
{
  final String error;
  FailureMovie({required this.error});
  @override
  // TODO: implement props
  List<Object?> get props => [error];

}