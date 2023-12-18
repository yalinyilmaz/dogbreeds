import 'package:cached_network_image/cached_network_image.dart';
import 'package:dogbreeds_app/ui/breed_details.dart';
import 'package:dogbreeds_app/bloc/dog_bloc.dart';
import 'package:dogbreeds_app/widgets/sayfa_gecisi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DogImage extends StatelessWidget {
 final int index;
  const DogImage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final dogBloc = BlocProvider.of<DogBloc>(context);

    return BlocBuilder(
        bloc: dogBloc,
        builder: (context, DogState state) {
          if (state is DogLoadedState) {
            return Column(
              children: [
                Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            state.dogList[index].img),
                        fit: BoxFit.fill),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(
                        context,
                        Routing(option: -1).createPageRoute(BreedDetails(
                          index: index,
                        )));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      //shape: BoxShape.rectangle
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),
                  ),
                )
              ],
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
