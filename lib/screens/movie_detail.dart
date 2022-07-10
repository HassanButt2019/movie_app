import 'package:assignment2/bloc/movie_bloc/events/get_similar_movies.dart';
import 'package:assignment2/bloc/movie_bloc/movie_bloc.dart';
import 'package:assignment2/data/models/movie.dart';
import 'package:assignment2/data/repository/movie_repository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetail extends StatelessWidget {
  Movie? movie;
  MovieDetail({this.movie});
  double? height;
  double? width;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.red, Colors.black, Colors.black]),
      ),
      child: Scaffold(
          backgroundColor: Colors.black,
          body: BlocProvider(
            create: (BuildContext context) =>
                MovieBloc(RepositoryProvider.of<MovieReposiotry>(context))
                  ..add(GetSimilarMovies(id: movie!.id.toString())),
            child: ListView(children: [
              Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(children: <Widget>[
                        MovieImage(),
                        ContainerGradient(),
                        BackArrowButton(context),
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                MovieTitle(),
                                MovieInformation(),
                              ],
                            ),
                          ),
                        ),
                      ]
                      ),
                      MovieOverview(),
                       Padding(
                         padding: const EdgeInsets.only(left:15.0,top: 10),
                         child: Text(
                         "Vote Count : ${ movie!.vote_count.toString()}",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                       ),
                      Padding(
                        padding: const EdgeInsets.only(left:15.0,top: 10),
                        child: Text(
                          "Popularity : ${ movie!.popularity.toString()}",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ]),
          )),
    );
  }



  Center LoadingState() {
    return const Center(
                    child: CircularProgressIndicator(),
                  );
  }

  Positioned BackArrowButton(BuildContext context) {
    return Positioned.fill(
                          child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                        ),
                      )
    );
  }

  Widget MovieImage() {
    return SizedBox(
      width: double.infinity,

      height: 400,
      child: CachedNetworkImage(
        fit: BoxFit.fill,
        imageUrl:   "https://image.tmdb.org/t/p/w500/${movie!.poster_path!}",
        progressIndicatorBuilder: (context, url, downloadProgress) =>
            CircularProgressIndicator(value: downloadProgress.progress),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    );
  }

  Container ContainerGradient() {
    return Container(
      height: 400,
      decoration: BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Colors.grey.withOpacity(0.0),
                Colors.black,
              ],
              stops: const [
                0.0,
                1.0
              ])),
    );
  }

  Row MovieInformation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          DateTime.parse(movie!.release_date!).toUtc().year.toString(),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        const Text(
          "-",
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          movie!.adult! == "false" ? "18+" : "13+",
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ],
    );
  }

  Text MovieTitle() {
    return Text(
      movie!.title!,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 50),
    );
  }

  Widget MovieOverview() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        movie!.overview!,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
