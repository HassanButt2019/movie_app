import 'package:assignment2/bloc/movie_bloc/events/search_movie.dart';
import 'package:assignment2/bloc/movie_bloc/movie_bloc.dart';
import 'package:assignment2/bloc/movie_bloc/states/movie_failure.dart';
import 'package:assignment2/bloc/movie_bloc/states/movie_initial.dart';
import 'package:assignment2/bloc/movie_bloc/states/movie_loading.dart';
import 'package:assignment2/bloc/movie_bloc/states/movie_state.dart';
import 'package:assignment2/bloc/movie_bloc/states/searched_state.dart';
import 'package:assignment2/widgets/search_movie_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();
  @override
void initState() {
    // TODO: implement initState
    super.initState();
    controller.text = "";
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
            backgroundColor: Colors.red,
            title: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              child: Center(
                child: TextField(
                  onChanged: (String? value){
                    context.read<MovieBloc>().add(SearchMovie(query: controller.text));


                  },
                  controller: controller,
                  decoration: InputDecoration(
                      prefixIcon: IconButton(
                        onPressed: () {
                          context.read<MovieBloc>().add(SearchMovie(query: controller.text));
                        },
                        icon: Icon(
                          Icons.search_outlined,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: Colors.red,
                          size: 30,
                        ),
                        onPressed: () {
                          controller.clear();
                          context.read<MovieBloc>().clearMovies();

                        },
                      ),
                      hintText: 'Search...',
                      hintStyle: TextStyle(color: Colors.red),
                      border: InputBorder.none),
                ),
              ),
            )),
        body: BlocConsumer<MovieBloc, MovieState>(
          listener: (context, state) {
          },

            builder: (context, state) {

              if (state is InitialMovie) {
                return WelcomeWidget(size);
              }
              if (state is LoadingMovie) {
                return LoadingWidget(size);
              }

              if (state is SearchLoadedMovie) {
                return Container(
                    height: size.height,
                    width: size.width,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.black, Colors.black]),
                    ),
                    child:  ListView.builder(
                        itemCount: state.searchMovies!.length,
                        itemBuilder: (context, index) {
                          return SearchedMovieWidget(movie: state.searchMovies![index]);
                        })
                );
              }
              if (state is FailureMovie) {
                return Center(
                  child: Text(state.error.toString()),
                );
              }
              return Container();
            },
          ),
        );
  }

  Widget WelcomeWidget(Size size) {
    return Container(
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black, Colors.black]),
      ),
      child: Center(
        child: Text("No Movies , Please Search Movies",style: TextStyle(color: Colors.white , fontSize: 22 , fontWeight: FontWeight.bold),),
      ),
    );
  }

  Widget LoadedState(BuildContext context,SearchLoadedMovie state  ,Size size) {
    return Container();
  }

  Widget LoadingWidget(Size size) {
    return Container(
      height: size.height,
      width: size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black, Colors.black]),
      ),
      child: Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      ),
    );
  }
}
