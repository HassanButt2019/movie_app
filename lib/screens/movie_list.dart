import 'package:assignment2/bloc/movie_bloc/events/get_movie.dart';
import 'package:assignment2/bloc/movie_bloc/movie_bloc.dart';
import 'package:assignment2/bloc/movie_bloc/states/movie_failure.dart';
import 'package:assignment2/bloc/movie_bloc/states/movie_initial.dart';
import 'package:assignment2/bloc/movie_bloc/states/movie_loaded.dart';
import 'package:assignment2/bloc/movie_bloc/states/movie_loading.dart';
import 'package:assignment2/data/models/movie.dart';
import 'package:assignment2/data/repository/movie_repository.dart';
import 'package:assignment2/widgets/upcoming_movie_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/movie_bloc/states/movie_state.dart';
import 'search_screen.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {

  Movie movie = Movie();
  double? width, height;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return BlocProvider(
            create: (_) =>
                MovieBloc(RepositoryProvider.of<MovieReposiotry>(context))
                  ..add(RequestMovie()),
            child: BlocConsumer<MovieBloc, MovieState>(
              listener: (context, state) {
                if (state is LoadingMovie) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("LOADING YOUR MOVIES"),
                    backgroundColor: Colors.red,
                  ));
                }
                if (state is LoadedMovie) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Loaded Your Movies"),
                    backgroundColor: Colors.grey,
                  ));
                }
              },
              builder: (context, state) {
                if (state is InitialMovie) {
                  return WelcomeWidget();
                }
                if (state is LoadingMovie) {
                  return LoadingWidget();
                }

                if (state is LoadedMovie) {
                  return LoadedState(context ,state);
                }
                if (state is FailureMovie) {
                  return Center(
                    child: Text(state.error.toString()),
                  );
                }
                return Container();
              },
            ));
  }

  Widget LoadedState(BuildContext context, state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        title: Center(child: const Text("Movie List")),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).push( MaterialPageRoute(builder: (context)=>
                SearchScreen()));
          }, icon: Icon(Icons.search ,size: 34,color: Colors.white, ))


        ],
      ),
      body: Container(
          height: height!,
          width: width!,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.black, Colors.black]),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UpcomingMovieListView(
                    title: "Upcomming - Movies"),
              ],
            ),
          )),
    );
  }


  Widget WelcomeWidget() {
    return Scaffold(
      body: Container(
        height: height!,
        width: width!,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.black, Colors.black]),
        ),
        child: Center(
          child: Text("Welcome To Movie Land"),
        ),
      ),
    );
  }

  Widget LoadingWidget() {
    return Scaffold(
      body: Container(
        height: height!,
        width: width!,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.black, Colors.black]),
        ),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

}


//1 same movie tile
//2 different lists
//3