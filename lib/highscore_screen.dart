import 'package:flutter/material.dart';
import 'package:proyek_akhir_dicoding/model/leaderboard.dart';

class HighscoreScreen extends StatelessWidget {
  const HighscoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("LEADERBOARD"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView.builder(
              itemBuilder: (context, index) {
                leaderboard.sort(
                    (a, b) => a.totalPercobaan.compareTo(b.totalPercobaan));
                final Leaderboard player = leaderboard[index];
                return SizedBox(
                  height: 50,
                  child: Card(
                    child: Center(
                        child:
                            Text('${player.nama} - ${player.totalPercobaan}')),
                  ),
                );
              },
              itemCount: leaderboard.length,
            )));
  }
}
