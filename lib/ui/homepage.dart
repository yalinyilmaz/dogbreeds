import 'package:cached_network_image/cached_network_image.dart';
import 'package:dogbreeds_app/widgets/bottombar.dart';
import 'package:dogbreeds_app/ui/breed_details.dart';
import 'package:dogbreeds_app/widgets/custom_search.dart';
import 'package:dogbreeds_app/model/dog.dart';
import 'package:dogbreeds_app/bloc/dog_bloc.dart';
import 'package:dogbreeds_app/widgets/sayfa_gecisi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DogBloc>(context).add(FetchDogEvent());
  }

  @override
  Widget build(BuildContext context) {
    final dogBloc = BlocProvider.of<DogBloc>(context);

    return BlocBuilder(
        bloc: dogBloc,
        builder: (context, DogState state) {
          if (state is DogBreedLoadingState) {
            return Scaffold(
              body: Center(
                child: Column(
                  children: [
                    Image.asset("assets/images/dogs.png"),
                    const Text(
                      "Dogs Loading..",
                      style: TextStyle(fontSize: 34),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is DogLoadedState) {
            List<Dog> gelenDogList = state.dogList;
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  "Dog Breeds",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
                elevation: 0,
                backgroundColor: Colors.transparent,
              ),
              body: Stack(children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemCount: gelenDogList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    Routing(option: 1)
                                        .createPageRoute(BreedDetails(
                                      index: index,
                                    )));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            gelenDogList[index].img),
                                        fit: BoxFit.cover),
                                    color: Colors.amber,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 9,
                            left: 9,
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(.4),
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  child: Text(
                                    gelenDogList[index]
                                        .breed
                                        .keys
                                        .toList()[0]
                                        .toString(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                )),
                          ),
                        ]);
                      }),
                ),
                Positioned(
                    bottom: 18,
                    left: 12,
                    right: 12,
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            barrierColor: Colors.transparent,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16)),
                            ),
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            context: context,
                            builder: (context) {
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  DraggableScrollableSheet(
                                      initialChildSize: 0.5,
                                      maxChildSize: 0.9,
                                      minChildSize: 0.49,
                                      snap: true,
                                      expand: false,
                                      builder: (_, controller) => ListView(
                                              controller: controller,
                                              physics:
                                                  const ClampingScrollPhysics(),
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: CustomSearch(
                                                    doglist: gelenDogList,
                                                    value: state.value,
                                                  ),
                                                )
                                              ])),
                                  Positioned(
                                    top: 12,
                                    child: IgnorePointer(
                                      child: Container(
                                        height: 6,
                                        width: 36,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            });
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 66,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            state.value == '' ? 'Search' : state.value,
                            style: TextStyle(
                                color: state.value == ''
                                    ? Colors.grey
                                    : Colors.black,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ))
              ]),
              bottomNavigationBar: const BottomBar(),
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
