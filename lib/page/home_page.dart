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
            ],
          ),
        ),
      ),
    );
  }
}
