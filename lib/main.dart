import 'package:dogbreeds_app/model/dog.dart';

import 'package:dogbreeds_app/bloc/dog_bloc.dart';
import 'package:dogbreeds_app/ui/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(DogAdapter());
  await Hive.openBox<Dog>("dogs");
  //DogApiClient().getDogList();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DogBloc>(
      create: (context) => DogBloc(),
      child: MaterialApp(
        theme: ThemeData(useMaterial3: false),
        title: 'Dog Breeds',
        debugShowCheckedModeBanner: false,
        //theme: ThemeData(),
        home: const MyHomePage(),
      ),
    );
  }
}
