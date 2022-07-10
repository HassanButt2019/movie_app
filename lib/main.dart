import 'package:assignment2/bloc/movie_bloc/movie_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repository/movie_repository.dart';
import 'screens/movie_list.dart';

void main() {
  runApp(RepositoryProvider(
      create: (_)=>MovieReposiotry(),
      child: BlocProvider(
          create: (__) =>
              MovieBloc(RepositoryProvider.of<MovieReposiotry>(__)),
          child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MovieList(),
    );
  }
}
