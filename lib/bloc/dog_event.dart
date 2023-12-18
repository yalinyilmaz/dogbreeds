part of 'dog_bloc.dart';

@immutable
abstract class DogEvent {}

class FetchDogEvent extends DogEvent {}

class FilterDogListEvent extends DogEvent {
  List<Dog> filteredDoglist;
  String value;
  FilterDogListEvent({required this.filteredDoglist, required this.value});
}
