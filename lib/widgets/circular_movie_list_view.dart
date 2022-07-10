





import 'package:assignment2/data/models/movie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircularListView extends StatelessWidget {

  Movie? movie;
  double?width;
  double?height;
  var onTap;
  CircularListView({this.movie , this.onTap,});
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return InkWell(
      onTap:onTap,
      child: Column(
          children:[
            _imageWidget(),
            SizedBox(
              height: 10,
            ),
            _titleWidget(),
          ]),
    );
  }

  Center _titleWidget() => Center(child: Text(movie!.title! , textAlign: TextAlign.center , maxLines: 4 ,style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.normal),));

  Widget _imageWidget() {
    return SizedBox(
            height: height!*0.12,
            width: width!*0.2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: CachedNetworkImage(
                imageUrl: "https://image.tmdb.org/t/p/w500/${movie!.poster_path!}" ,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          );
  }
}
