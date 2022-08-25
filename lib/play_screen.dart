import 'package:flutter/material.dart';
import "dart:math";

import 'package:proyek_akhir_dicoding/model/leaderboard.dart';

const TextStyle customTextStyle = TextStyle(fontSize: 40);
const TextStyle buttonText = TextStyle(fontSize: 20);
const Size buttonSize = Size(120, 50);

class PlayScreen extends StatefulWidget {
  const PlayScreen({Key? key}) : super(key: key);

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  String nama = "Udin";
  int totalPercobaan = 0;
  final List<int> angka = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  List<int> soal = [];
  List<int> jawaban = [];
  bool hintButton = false;
  int posisiBenar = 0;
  int angkaBenar = 0;

  // TextEditingController _textFieldController = TextEditingController();

  randomSoal() {
    var rnd = Random();
    do {
      int hasilRandom = rnd.nextInt(9) + 1;
      if (!soal.contains(hasilRandom)) {
        setState(() {
          soal.add(hasilRandom);
        });
      }
    } while (soal.length < 4);
  }

  cekAngkaBenar() {
    for (int i = 0; i < jawaban.length; i++) {
      if (soal.contains(jawaban[i])) {
        setState(() {
          angkaBenar++;
        });
      }
    }
  }

  cekPosisiAngka() {
    int i = 0; // Counter Soal
    int j = 0; // Counter Jawaban
    while (j < jawaban.length) {
      if (soal[i] == jawaban[j]) {
        setState(() {
          posisiBenar++;
        });
      }
      i++;
      j++;
    }
  }

  showAlertDialog(BuildContext context, String message) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(message),
      content: null,
      actions: null,
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showInputDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title:
          const Text("Selamat Anda Berhasil! Silahkan Masukkan Nama Anda ..."),
      content: TextField(
        onChanged: (value) {
          setState(() {
            nama = value;
          });
        },
        // controller: _textFieldController,
        decoration: const InputDecoration(hintText: "Contoh: Udin"),
      ),
      actions: [
        TextButton(
          child: const Text('OK'),
          onPressed: () {
            setState(() {
              leaderboard
                  .add(Leaderboard(nama: nama, totalPercobaan: totalPercobaan));
              Navigator.popUntil(context, ModalRoute.withName("/"));
            });
          },
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    randomSoal();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xff222222),
        title: Text('Total Percobaan : $totalPercobaan', style: buttonText),
      ),
      body: Column(
        children: [
          Container(
            height: (screenHeight - AppBar().preferredSize.height) / 3,
            width: screenWidth,
            color: Colors.white54,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    jawaban.isNotEmpty
                        ? Text(style: customTextStyle, '${jawaban[0]} ')
                        : Text(style: customTextStyle, '_ '),
                    jawaban.length > 1
                        ? Text(style: customTextStyle, '${jawaban[1]} ')
                        : Text(style: customTextStyle, '_ '),
                    jawaban.length > 2
                        ? Text(style: customTextStyle, '${jawaban[2]} ')
                        : Text(style: customTextStyle, '_ '),
                    jawaban.length > 3
                        ? Text(style: customTextStyle, '${jawaban[3]}')
                        : Text(style: customTextStyle, '_'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              totalPercobaan++;
                              if (soal.join("") == jawaban.join("")) {
                                showInputDialog(context);
                              } else {
                                cekAngkaBenar();
                                cekPosisiAngka();
                                showAlertDialog(context,
                                    '$angkaBenar Angka Benar, $posisiBenar Posisi Benar');
                                setState(() {
                                  angkaBenar = 0;
                                  posisiBenar = 0;
                                });
                                jawaban.clear();
                              }
                            });
                          },
                          style:
                              ElevatedButton.styleFrom(minimumSize: buttonSize),
                          child: const Text("ENTER", style: buttonText)),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          jawaban.clear();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.lightGreen, minimumSize: buttonSize),
                      child: const Text("RESET JAWABAN", style: buttonText)),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      hintButton = !hintButton;
                      Future.delayed(
                          const Duration(milliseconds: 500),
                          () => setState(() {
                                hintButton = false;
                              }));
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrange, minimumSize: buttonSize),
                  child: hintButton
                      ? Text(soal.join(" "))
                      : const Text("CLICK ME FOR ANSWER!", style: buttonText),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: screenWidth / 24,
                mainAxisSpacing: screenWidth <= 600 ? screenHeight / 36 : screenHeight / 20,
                mainAxisExtent: screenHeight / 6,
              ),
              padding: const EdgeInsets.all(10),
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (jawaban.length == 4) {
                          showAlertDialog(context, 'Sudah Terdapat 4 Angka!');
                        } else if (jawaban.contains(angka[index])) {
                          showAlertDialog(
                              context, 'Tidak Boleh Ada Angka Kembar!');
                        } else {
                          jawaban.add(angka[index]);
                        }
                      });
                    },
                    child:
                        Text(angka[index].toString(), style: customTextStyle));
              },
            ),
          ),
        ],
      ),
    );
  }
}
