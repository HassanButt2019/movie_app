import 'package:http/http.dart' as http;


class MovieDataProvider
{

  final _upComingUrl = "https://api.themoviedb.org/3/movie/upcoming?api_key=c1e80fe769fd1c74e339f5e7349d0a56&language=en-US&page=";

  Future<http.Response> searchMovies({String query='Unknown'})async
  {
     String  searchUrl = "https://api.themoviedb.org/3/search/movie?api_key=c1e80fe769fd1c74e339f5e7349d0a56&query=$query";
    http.Response rawData = await http.get(Uri.parse(searchUrl));
    return rawData;
  }

  Future<http.Response> upComingMovies()async
  {
    http.Response rawData = await http.get(Uri.parse(_upComingUrl));
    return rawData;
  }

}

