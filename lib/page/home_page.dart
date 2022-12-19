import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed('/success1'),
                child: const Text('Success Page 1'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed('/success2'),
                child: const Text('Success Page 2'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed('/success3'),
                child: const Text('Success Page 3'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).push(PageRouteBuilder(
                  //     pageBuilder: (context, animation, anotherAnimation) {
                  //       return ReturnPage();
                  //     },
                  //     transitionDuration: Duration(milliseconds: 2000),
                  //     transitionsBuilder: (context, animation, anotherAnimation, child) {
                  //       animation = CurvedAnimation(curve: curveList[index], parent: animation);
                  //       return RotationTransition(
                  //         turns: animation,
                  //         child: child,
                  //       );
                  //     }));
                  Navigator.of(context).pushNamed('/success4');
                },
                child: const Text('Success Page 4'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
