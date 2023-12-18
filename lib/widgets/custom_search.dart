import 'package:dogbreeds_app/model/dog.dart';
import 'package:dogbreeds_app/bloc/dog_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class CustomSearch extends StatefulWidget {
  final List<Dog> doglist;
  final String value;
  const CustomSearch({super.key, required this.doglist, required this.value});

  @override
  State<CustomSearch> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    textController.text = widget.value;
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dogBloc = BlocProvider.of<DogBloc>(context);

    return TextField(
      scrollPadding: const EdgeInsets.all(0),
      maxLines: 5,
      autofocus: true,
      controller: textController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: "Search",
        filled: true,
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onSubmitted: (value) {
        List<Dog> filteredList = filterDogList();
        dogBloc.add(FilterDogListEvent(
          filteredDoglist: filteredList,
          value: value,
        ));
      },
    );
  }

  List<Dog> filterDogList() {
    Box<Dog> dogBox = Hive.box<Dog>("dogs");

    List<Dog> mainDogList = dogBox.values.toList();

    List<Dog> filteredDogList = mainDogList
        .where((dog) => dog.breed.keys
            .toList()[0]
            .toString()
            .toLowerCase()
            .contains(textController.text.toLowerCase()))
        .toList();

    return filteredDogList;
  }
}
