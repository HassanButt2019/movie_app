
import 'package:assignment2/data/models/movie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MovieImageWidget extends StatelessWidget {

  Movie? movie;
  double?width;
  double?height;
  double?heigthProvided;
  double?widthProvided;
  var onTap;
  MovieImageWidget({this.movie , this.onTap,this.heigthProvided,this.widthProvided});
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return InkWell(
      onTap:onTap,
      child: SizedBox(
        height:height! * 0.25,
        width: width! *0.25,
        child:
          Column(
              mainAxisSize: MainAxisSize.min,
              children:[
                Container(
                  width: 200,
                  height: 150,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: CachedNetworkImage(
                    imageUrl:   "https://image.tmdb.org/t/p/w500/${movie!.poster_path!}"   ,
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        CircularProgressIndicator(value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>const Icon(Icons.error),
                  ),
                ),
               const SizedBox(
                  height: 10,
                ),

                Center(child: Text(movie!.title! , textAlign: TextAlign.center , maxLines: 4,overflow: TextOverflow.ellipsis,style: const TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),)),
              ]),
      ),
    );
  }
}
