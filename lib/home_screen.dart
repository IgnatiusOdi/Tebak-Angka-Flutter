import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;
    Size customSize = Size(screenWidth / 2, 70);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('TEBAK KOMBINASI ANGKA',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 130,
                backgroundColor: Colors.blue,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ClipOval(child: Image.asset('images/ithurts.jpeg')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      minimumSize: customSize,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/play");
                    },
                    child: const Text("MULAI", style: TextStyle(fontSize: 28))),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      minimumSize: customSize,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, "/highscore");
                    },
                    child: const Text("HIGHSCORE",
                        style: TextStyle(fontSize: 28))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
