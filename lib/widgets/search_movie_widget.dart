




import 'package:assignment2/data/models/movie.dart';
import 'package:assignment2/screens/movie_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SearchedMovieWidget extends StatelessWidget {
  const SearchedMovieWidget({Key? key,required this.movie}) : super(key: key);
 final Movie movie;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) =>
                MovieDetail(
                  movie: movie,))
        );
      },
      leading: CircleAvatar(
        backgroundColor: Colors.purple,
        child:  CachedNetworkImage(
          imageUrl:   "https://image.tmdb.org/t/p/w500/${movie.poster_path!}"   ,
          progressIndicatorBuilder: (context, url, downloadProgress) =>
              CircularProgressIndicator(value: downloadProgress.progress),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
      title: Text(movie.title.toString(),style: const TextStyle(fontWeight: FontWeight.bold ,color: Colors.white),),
      subtitle: Text(movie.release_date.toString(),style:const TextStyle(fontWeight: FontWeight.bold ,color: Colors.white),),
      trailing: Text(movie.popularity.toString() ,style:const TextStyle(fontWeight: FontWeight.bold ,color: Colors.white),),
    );
  }
}
