import 'package:assignment2/data/models/movie.dart';
import 'package:assignment2/screens/movie_detail.dart';
import 'package:assignment2/widgets/circular_movie_list_view.dart';
import 'package:flutter/material.dart';

class SimilarMovieWidget extends StatelessWidget {
  double? width;
  double? height;
  String? title;

  List<Movie> movies;
  SimilarMovieWidget({ this.title ,  required this.movies});

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.0, top: 10),
          child: Text(
            title!,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        Container(
          width: width,
          height: height! * 0.25,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularListView(movie: movies[index],  onTap:  (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MovieDetail(movie:  movies[index],)));
                  })
                );
              }),
        ),
      ],
    );
  }
}
