// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:dogbreeds_app/bloc/dog_bloc.dart';
import 'package:dogbreeds_app/ui/homepage.dart';
import 'package:dogbreeds_app/widgets/image.dart';
import 'package:dogbreeds_app/widgets/sayfa_gecisi.dart';

class BreedDetails extends StatelessWidget {
  final int index;
  const BreedDetails({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dogBloc = BlocProvider.of<DogBloc>(context);

    return BlocBuilder(
        bloc: dogBloc,
        builder: (context, DogState state) {
          if (state is DogLoadedState) {
            List subBreedList = state.dogList[index].breed.values.toList()[0];
            return Material(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              elevation: 12,
              child: Column(

                  //crossAxisAlignment: CrossAxisAlignment.,
                  children: [
                    Stack(children: [
                      Container(
                        height: MediaQuery.sizeOf(context).height / 2.5,
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  state.dogList[index].img),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Positioned(
                          top: 15,
                          right: 15,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(
                                  context,
                                  Routing(option: -1)
                                      .createPageRoute(const MyHomePage()));
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ))
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Breed",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                          fontSize: 27),
                    ),
                    const Divider(
                      thickness: 2,
                      endIndent: 25,
                      indent: 25,
                    ),
                    Text(state.dogList[index].breed.keys.toList()[0].toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17)),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Sub Breed",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                          fontSize: 27),
                    ),
                    const Divider(thickness: 2, endIndent: 25, indent: 25),
                    subBreedList.isEmpty
                        ? const Text('None',style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17),)
                        : Column(
                            children: subBreedList
                                .map((e) => Text(e.toString(),style:const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17) ,))
                                .toList()),
                    const Expanded(child: SizedBox()),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                Routing(
                                        sayfa: BreedDetails(
                                          index: index,
                                        ),
                                        option: 1)
                                    .createPageRoute(DogImage(index: index)));
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 80, vertical: 12),
                            child: Text("Generate",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 25)),
                          )),
                    )
                  ]),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
