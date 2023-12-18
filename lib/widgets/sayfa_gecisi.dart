import 'package:dogbreeds_app/ui/homepage.dart';
import 'package:flutter/material.dart';

class Routing {
  Widget? result;
  double option;
  Widget? sayfa;
  Routing({required this.option, this.sayfa});

  PageRouteBuilder createPageRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, option);
        const end = Offset.zero;
        const curve = Curves.easeInOutQuart;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        var slideTransition = SlideTransition(
          position: offsetAnimation,
          child: child,
        );

        if (option == 1) {
          if (sayfa == null) {
            result = Stack(
              children: [
                const MyHomePage(),
                Positioned(
                    top: 80,
                    left: 20,
                    right: 20,
                    bottom: 80,
                    child: slideTransition),
              ],
            );
          } else {
            result = Stack(
              children: [
                const MyHomePage(),
                Positioned(
                    top: 80, left: 20, right: 20, bottom: 80, child: sayfa!),
                Positioned(
                    top: (MediaQuery.sizeOf(context).height / 2) - (250 / 2),
                    left: (MediaQuery.sizeOf(context).width / 2) - (250 / 2),
                    child: slideTransition)
              ],
            );
          }
        } else {
          if (sayfa == null) {
            result = slideTransition;
          } else {
            result = Stack(
              children: [
                const MyHomePage(),
                Positioned(
                    top: 80,
                    left: 20,
                    right: 20,
                    bottom: 80,
                    child: slideTransition),
              ],
            );
          }
        }
        return result!;
      },
    );
  }
}
