part of 'dog_bloc.dart';

@immutable
abstract class DogState {
  const DogState();
}

class DogBreedLoadingState extends DogState {}

class DogLoadedState extends DogState {
  List<Dog> dogList;
  String value = '';

  DogLoadedState({required this.dogList,required this.value});
}
