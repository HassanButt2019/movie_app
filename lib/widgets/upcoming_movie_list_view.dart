
import 'package:assignment2/bloc/movie_bloc/movie_bloc.dart';
import 'package:assignment2/data/models/movie.dart';
import 'package:assignment2/screens/movie_detail.dart';
import 'package:assignment2/widgets/movie_component_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class UpcomingMovieListView extends StatefulWidget {
  String? title;


  UpcomingMovieListView({this.title });

  @override
  _UpcomingMovieListViewState createState() => _UpcomingMovieListViewState();
}

class _UpcomingMovieListViewState extends State<UpcomingMovieListView> {
  double?width;
  double?height;
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                width: width,
                height:height!,
                child: StreamBuilder<List<Movie>>(
                  initialData:BlocProvider.of<MovieBloc>(context).upComingmovies,
                  builder: (context, snapshot) {
                    if(BlocProvider.of<MovieBloc>(context).isUpdate) {
                      return CircularProgressIndicator();

                    }
                    if(snapshot.data!.isNotEmpty) {
                      return   GridView.builder(
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 150,
                              childAspectRatio: 0.5,
                              crossAxisSpacing: 30,
                              mainAxisSpacing: 30),
                          itemCount:snapshot.data!.length,
                          itemBuilder: (BuildContext ctx, index) {
                            var movies = BlocProvider.of<MovieBloc>(context).upComingmovies;
                            return Padding(
                              padding:
                              const EdgeInsets.all(8.0),
                              child: MovieImageWidget(
                                movie: snapshot.data![index],
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          MovieDetail(
                                            movie: movies![index],))

                                  );
                                },
                              ),
                            );
                          }
                      );

                    }

                    if (snapshot.hasData){
                      return const Align(
                        alignment: Alignment.centerRight,
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Container();
                  }
                ),
              ),

        //    if(  BlocProvider.of<MovieBloc>(context).isUpdate) CircularProgressIndicator()
            ],


    );
  }
}

//1 stream builder vs future builder
// when to use stream or future builder
