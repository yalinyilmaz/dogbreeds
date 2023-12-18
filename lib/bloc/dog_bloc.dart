import 'package:flutter/material.dart';

import 'package:dogbreeds_app/model/dog.dart';
import 'package:dogbreeds_app/repository/dog_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dog_event.dart';
part 'dog_state.dart';

class DogBloc extends Bloc<DogEvent, DogState> {
  DogBloc() : super(DogBreedLoadingState()) {
    final DogRepository dogRepository = DogRepository();

    on<FetchDogEvent>((event, emit) async {
      //emit(DogBreedLoadingState());

      List<Dog> doglistt = await dogRepository.getDogList();

      emit(DogLoadedState(dogList: doglistt, value: ''));
    });

    on<FilterDogListEvent>(
      (event, emit) {
        List<Dog> filteredDogList = event.filteredDoglist;
        String value = event.value;

        emit(DogLoadedState(dogList: filteredDogList, value: value));
      },
    );
  }
}
