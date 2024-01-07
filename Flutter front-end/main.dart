import 'dart:math';

import 'package:mysheetapp2/Player.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'main.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Herend Városi Teke Klub Live'),
    );
  }

}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<ResultData> fetchData() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:5002/results'));

    if (response.statusCode == 200) {
      print('Kakker: ${response.statusCode}');
      addTableElements(ResultData.fromJson(json.decode(response.body)));
      return ResultData.fromJson(json.decode(response.body));
    } else {
      print('HTTP status code: ${response.statusCode}');
      print('HTTP response: ${response.body}');
      throw Exception('Failed to load data');
    }
  }

  var rows = <TableRow>[];
  var myRowDataList = <List<Player>>[];


  var Hazai1JatekosSzett1 = 0;
  var Hazai1JatekosSzett2 = 0;
  var Hazai1JatekosSzett3 = 0;
  var Hazai1JatekosSzett4 = 0;

  int totalHomeScore = 0;
  int totalAwayScore = 0;

  addTableElements(ResultData data) {
    myRowDataList = [];
    print(data.end_results);
    myRowDataList.add([
      Player(
        playerName: "Játékosok:",
        playerScore1: 1,
        playerScore2: 2,
        playerScore3: 3,
        playerScore4: 4,
        isSum: true,
      ),
      Player(
        playerName: "Játékosok:",
        playerScore1: 1,
        playerScore2: 2,
        playerScore3: 3,
        playerScore4: 4,
        isSum: true,
      )
    ]);



    bool usingTempResultsForSet1 = data.end_results!.length == 0;
    bool usingTempResultsForSet2 = data.end_results!.length == 1;
    bool usingTempResultsForSet3 = data.end_results!.length == 2;
    bool usingTempResultsForSet4 = data.end_results!.length == 3;
    bool usingTempResultsForSet5 = data.end_results!.length == 4;
    bool usingTempResultsForSet6 = data.end_results!.length == 5;
    bool usingTempResultsForSet7 = data.end_results!.length == 6;
    bool usingTempResultsForSet8 = data.end_results!.length == 7;
    bool usingTempResultsForSet9 = data.end_results!.length == 8;
    bool usingTempResultsForSet10 = data.end_results!.length == 9;
    bool usingTempResultsForSet11 = data.end_results!.length == 10;
    bool usingTempResultsForSet12 = data.end_results!.length == 11;





    if (data.end_results!.length > 0 && data.end_results?[0] != null) {
      var score = int.tryParse(data.end_results?[0][0]);
      Hazai1JatekosSzett1 = score ?? 0;
    } else if (data.end_results!.length == 0) {
      var score = int.tryParse(data.temp_results?[0][0]);
      Hazai1JatekosSzett1 = score ?? 0;
    }
    if (data.end_results!.length > 1 && data.end_results?[1] != null) {
      var score = int.tryParse(data.end_results?[1][0]);
      Hazai1JatekosSzett2 = score ?? 0;
    } else if (data.end_results!.length == 1) {
      var score = int.tryParse(data.temp_results?[0][0]);
      Hazai1JatekosSzett2 = score ?? 0;
    }
    if (data.end_results!.length > 2 && data.end_results![2] != null) {
      var score = int.tryParse(data.end_results?[2][0]);
      Hazai1JatekosSzett3 = score ?? 0;
    } else if (data.end_results!.length == 2) {
      var score = int.tryParse(data.temp_results?[0][0]);
      Hazai1JatekosSzett3 = score ?? 0;
    }
    if (data.end_results!.length > 3 && data.end_results?[3] != null) {
      var score = int.tryParse(data.end_results?[3][0]);
      Hazai1JatekosSzett4 = score ?? 0;
    } else if (data.end_results!.length == 3) {
      var score = int.tryParse(data.temp_results?[0][0]);
      Hazai1JatekosSzett4 = score ?? 0;
    }

    var Vendeg1JatekosSzett1 = 0;
    var Vendeg1JatekosSzett2 = 0;
    var Vendeg1JatekosSzett3 = 0;
    var Vendeg1JatekosSzett4 = 0;

    if (data.end_results!.length > 0 && data.end_results?[0] != null) {
      var score = int.tryParse(data.end_results?[0][1]);
      Vendeg1JatekosSzett1 = score ?? 0;
    } else if (data.end_results!.length == 0) {
      var score = int.tryParse(data.temp_results?[0][1]);
      Vendeg1JatekosSzett1 = score ?? 0;
    }
    if (data.end_results!.length > 1 && data.end_results?[1] != null) {
      var score = int.tryParse(data.end_results?[1][1]);
      Vendeg1JatekosSzett2 = score ?? 0;
    } else if (data.end_results!.length == 1) {
      var score = int.tryParse(data.temp_results?[0][1]);
      Vendeg1JatekosSzett2 = score ?? 0;
    }
    if (data.end_results!.length > 2 && data.end_results![2] != null) {
      var score = int.tryParse(data.end_results?[2][1]);
      Vendeg1JatekosSzett3 = score ?? 0;
    } else if (data.end_results!.length == 2) {
      var score = int.tryParse(data.temp_results?[0][1]);
      Vendeg1JatekosSzett3 = score ?? 0;
    }
    if (data.end_results!.length > 3 && data.end_results?[3] != null) {
      var score = int.tryParse(data.end_results?[3][1]);
      Vendeg1JatekosSzett4 = score ?? 0;
    } else if (data.end_results!.length == 3) {
      var score = int.tryParse(data.temp_results?[0][1]);
      Vendeg1JatekosSzett4 = score ?? 0;
    }

    //2.páros
    var Hazai2JatekosSzett1 = 0;
    var Hazai2JatekosSzett2 = 0;
    var Hazai2JatekosSzett3 = 0;
    var Hazai2JatekosSzett4 = 0;

    if (data.end_results!.length > 0 && data.end_results?[0] != null) {
      var score = int.tryParse(data.end_results?[0][2]); // Assuming index for Hazai2 is 2
      Hazai2JatekosSzett1 = score ?? 0;
    } else if (data.end_results!.length == 0) {
      var score = int.tryParse(data.temp_results?[0][2]); // Assuming index for Hazai2 is 2
      Hazai2JatekosSzett1 = score ?? 0;
    }
    if (data.end_results!.length > 1 && data.end_results?[1] != null) {
      var score = int.tryParse(data.end_results?[1][2]); // Assuming index for Hazai2 is 2
      Hazai2JatekosSzett2 = score ?? 0;
    } else if (data.end_results!.length == 1) {
      var score = int.tryParse(data.temp_results?[0][2]); // Assuming index for Hazai2 is 2
      Hazai2JatekosSzett2 = score ?? 0;
    }
    if (data.end_results!.length > 2 && data.end_results![2] != null) {
      var score = int.tryParse(data.end_results?[2][2]); // Assuming index for Hazai2 is 2
      Hazai2JatekosSzett3 = score ?? 0;
    } else if (data.end_results!.length == 2) {
      var score = int.tryParse(data.temp_results?[0][2]); // Assuming index for Hazai2 is 2
      Hazai2JatekosSzett3 = score ?? 0;
    }
    if (data.end_results!.length > 3 && data.end_results?[3] != null) {
      var score = int.tryParse(data.end_results?[3][2]); // Assuming index for Hazai2 is 2
      Hazai2JatekosSzett4 = score ?? 0;
    } else if (data.end_results!.length == 3) {
      var score = int.tryParse(data.temp_results?[0][2]); // Assuming index for Hazai2 is 2
      Hazai2JatekosSzett4 = score ?? 0;
    }

    var Vendeg2JatekosSzett1 = 0;
    var Vendeg2JatekosSzett2 = 0;
    var Vendeg2JatekosSzett3 = 0;
    var Vendeg2JatekosSzett4 = 0;

    if (data.end_results!.length > 0 && data.end_results?[0] != null) {
      var score = int.tryParse(data.end_results?[0][3]); // Assuming index for Vendeg2 is 3
      Vendeg2JatekosSzett1 = score ?? 0;
    } else if (data.end_results!.length == 0) {
      var score = int.tryParse(data.temp_results?[0][3]); // Assuming index for Vendeg2 is 3
      Vendeg2JatekosSzett1 = score ?? 0;
    }
    if (data.end_results!.length > 1 && data.end_results?[1] != null) {
      var score = int.tryParse(data.end_results?[1][3]); // Assuming index for Vendeg2 is 3
      Vendeg2JatekosSzett2 = score ?? 0;
    } else if (data.end_results!.length == 1) {
      var score = int.tryParse(data.temp_results?[0][3]); // Assuming index for Vendeg2 is 3
      Vendeg2JatekosSzett2 = score ?? 0;
    }
    if (data.end_results!.length > 2 && data.end_results![2] != null) {
      var score = int.tryParse(data.end_results?[2][3]); // Assuming index for Vendeg2 is 3
      Vendeg2JatekosSzett3 = score ?? 0;
    } else if (data.end_results!.length == 2) {
      var score = int.tryParse(data.temp_results?[0][3]); // Assuming index for Vendeg2 is 3
      Vendeg2JatekosSzett3 = score ?? 0;
    }
    if (data.end_results!.length > 3 && data.end_results?[3] != null) {
      var score = int.tryParse(data.end_results?[3][3]); // Assuming index for Vendeg2 is 3
      Vendeg2JatekosSzett4 = score ?? 0;
    } else if (data.end_results!.length == 3) {
      var score = int.tryParse(data.temp_results?[0][3]); // Assuming index for Vendeg2 is 3
      Vendeg2JatekosSzett4 = score ?? 0;
    }


// A validEndResultsSize logikáját úgy kell módosítani, hogy csak akkor legyen igaz, ha az end_results mérete 5 és 8 között van.
    bool validEndResultsSize = data.end_results!.length >= 5 && data.end_results!.length <= 8;

// Harmadik játékos eredményeinek kezelése
    var Hazai3JatekosSzett1 = validEndResultsSize ? int.tryParse(data.end_results![4][0] ?? '0') : (data.end_results!.length == 4 ? int.tryParse(data.temp_results?[0][0] ?? '0') : 0);
    var Vendeg3JatekosSzett1 = validEndResultsSize ? int.tryParse(data.end_results![4][1] ?? '0') : (data.end_results!.length == 4 ? int.tryParse(data.temp_results?[0][1] ?? '0') : 0);
    var Hazai3JatekosSzett2 = validEndResultsSize && data.end_results!.length > 5 ? int.tryParse(data.end_results![5][0] ?? '0') : (data.end_results!.length == 4 ? int.tryParse(data.temp_results?[0][0] ?? '0') : 0);
    var Vendeg3JatekosSzett2 = validEndResultsSize && data.end_results!.length > 5 ? int.tryParse(data.end_results![5][1] ?? '0') : (data.end_results!.length == 4 ? int.tryParse(data.temp_results?[0][1] ?? '0') : 0);
    var Hazai3JatekosSzett3 = validEndResultsSize && data.end_results!.length > 6 ? int.tryParse(data.end_results![6][0] ?? '0') : (data.end_results!.length == 4 ? int.tryParse(data.temp_results?[0][0] ?? '0') : 0);
    var Vendeg3JatekosSzett3 = validEndResultsSize && data.end_results!.length > 6 ? int.tryParse(data.end_results![6][1] ?? '0') : (data.end_results!.length == 4 ? int.tryParse(data.temp_results?[0][1] ?? '0') : 0);
    var Hazai3JatekosSzett4 = validEndResultsSize && data.end_results!.length > 7 ? int.tryParse(data.end_results![7][0] ?? '0') : (data.end_results!.length == 4 ? int.tryParse(data.temp_results?[0][0] ?? '0') : 0);
    var Vendeg3JatekosSzett4 = validEndResultsSize && data.end_results!.length > 7 ? int.tryParse(data.end_results![7][1] ?? '0') : (data.end_results!.length == 4 ? int.tryParse(data.temp_results?[0][1] ?? '0') : 0);

// Negyedik játékos eredményeinek kezelése
    var Hazai4JatekosSzett1 = validEndResultsSize ? int.tryParse(data.end_results![4][2] ?? '0') : (data.end_results!.length == 4 ? int.tryParse(data.temp_results?[0][2] ?? '0') : 0);
    var Vendeg4JatekosSzett1 = validEndResultsSize ? int.tryParse(data.end_results![4][3] ?? '0') : (data.end_results!.length == 4 ? int.tryParse(data.temp_results?[0][3] ?? '0') : 0);
    var Hazai4JatekosSzett2 = validEndResultsSize && data.end_results!.length > 5 ? int.tryParse(data.end_results![5][2] ?? '0') : (data.end_results!.length == 4 ? int.tryParse(data.temp_results?[0][2] ?? '0') : 0);
    var Vendeg4JatekosSzett2 = validEndResultsSize && data.end_results!.length > 5 ? int.tryParse(data.end_results![5][3] ?? '0') : (data.end_results!.length == 4 ? int.tryParse(data.temp_results?[0][3] ?? '0') : 0);
    var Hazai4JatekosSzett3 = validEndResultsSize && data.end_results!.length > 6 ? int.tryParse(data.end_results![6][2] ?? '0') : (data.end_results!.length == 4 ? int.tryParse(data.temp_results?[0][2] ?? '0') : 0);
    var Vendeg4JatekosSzett3 = validEndResultsSize && data.end_results!.length > 6 ? int.tryParse(data.end_results![6][3] ?? '0') : (data.end_results!.length == 4 ? int.tryParse(data.temp_results?[0][3] ?? '0') : 0);
    var Hazai4JatekosSzett4 = validEndResultsSize && data.end_results!.length > 7 ? int.tryParse(data.end_results![7][2] ?? '0') : (data.end_results!.length == 4 ? int.tryParse(data.temp_results?[0][2] ?? '0') : 0);
    var Vendeg4JatekosSzett4 = validEndResultsSize && data.end_results!.length > 7 ? int.tryParse(data.end_results![7][3] ?? '0') : (data.end_results!.length == 4 ? int.tryParse(data.temp_results?[0][3] ?? '0') : 0);



    bool isEndResultsSizeExactlyEight = data.end_results!.length == 8;

// Ötödik játékos eredményeinek kezelése
    var Hazai5JatekosSzett1 = isEndResultsSizeExactlyEight ? int.tryParse(data.temp_results?[0][4] ?? '0') : (data.end_results!.length > 8 ? int.tryParse(data.end_results![8][0]) ?? 0 : 0);
    var Vendeg5JatekosSzett1 = isEndResultsSizeExactlyEight ? int.tryParse(data.temp_results?[0][5] ?? '0') : (data.end_results!.length > 8 ? int.tryParse(data.end_results![8][1]) ?? 0 : 0);
    var Hazai5JatekosSzett2 = isEndResultsSizeExactlyEight ? int.tryParse(data.temp_results?[1][4] ?? '0') : (data.end_results!.length > 8 ? int.tryParse(data.end_results![9][0]) ?? 0 : 0);
    var Vendeg5JatekosSzett2 = isEndResultsSizeExactlyEight ? int.tryParse(data.temp_results?[1][5] ?? '0') : (data.end_results!.length > 8 ? int.tryParse(data.end_results![9][1]) ?? 0 : 0);
    var Hazai5JatekosSzett3 = isEndResultsSizeExactlyEight ? int.tryParse(data.temp_results?[2][4] ?? '0') : (data.end_results!.length > 8 ? int.tryParse(data.end_results![10][0]) ?? 0 : 0);
    var Vendeg5JatekosSzett3 = isEndResultsSizeExactlyEight ? int.tryParse(data.temp_results?[2][5] ?? '0') : (data.end_results!.length > 8 ? int.tryParse(data.end_results![10][1]) ?? 0 : 0);
    var Hazai5JatekosSzett4 = isEndResultsSizeExactlyEight ? int.tryParse(data.temp_results?[3][4] ?? '0') : (data.end_results!.length > 8 ? int.tryParse(data.end_results![11][0]) ?? 0 : 0);
    var Vendeg5JatekosSzett4 = isEndResultsSizeExactlyEight ? int.tryParse(data.temp_results?[3][5] ?? '0') : (data.end_results!.length > 8 ? int.tryParse(data.end_results![11][1]) ?? 0 : 0);

// Hatodik játékos eredményeinek kezelése
    var Hazai6JatekosSzett1 = isEndResultsSizeExactlyEight ? int.tryParse(data.temp_results?[0][6] ?? '0') : (data.end_results!.length > 8 ? int.tryParse(data.end_results![8][2]) ?? 0 : 0);
    var Vendeg6JatekosSzett1 = isEndResultsSizeExactlyEight ? int.tryParse(data.temp_results?[0][7] ?? '0') : (data.end_results!.length > 8 ? int.tryParse(data.end_results![8][3]) ?? 0 : 0);
    var Hazai6JatekosSzett2 = isEndResultsSizeExactlyEight ? int.tryParse(data.temp_results?[1][6] ?? '0') : (data.end_results!.length > 8 ? int.tryParse(data.end_results![9][2]) ?? 0 : 0);
    var Vendeg6JatekosSzett2 = isEndResultsSizeExactlyEight ? int.tryParse(data.temp_results?[1][7] ?? '0') : (data.end_results!.length > 8 ? int.tryParse(data.end_results![9][3]) ?? 0 : 0);
    var Hazai6JatekosSzett3 = isEndResultsSizeExactlyEight ? int.tryParse(data.temp_results?[2][6] ?? '0') : (data.end_results!.length > 8 ? int.tryParse(data.end_results![10][2]) ?? 0 : 0);
    var Vendeg6JatekosSzett3 = isEndResultsSizeExactlyEight ? int.tryParse(data.temp_results?[2][7] ?? '0') : (data.end_results!.length > 8 ? int.tryParse(data.end_results![10][3]) ?? 0 : 0);
    var Hazai6JatekosSzett4 = isEndResultsSizeExactlyEight ? int.tryParse(data.temp_results?[3][6] ?? '0') : (data.end_results!.length > 8 ? int.tryParse(data.end_results![11][2]) ?? 0 : 0);
    var Vendeg6JatekosSzett4 = isEndResultsSizeExactlyEight ? int.tryParse(data.temp_results?[3][7] ?? '0') : (data.end_results!.length > 8 ? int.tryParse(data.end_results![11][3]) ?? 0 : 0);




    myRowDataList.add([
      Player(
        playerName: "Etlinger András",
        playerScore1: Hazai1JatekosSzett1,
        playerScore2: Hazai1JatekosSzett2,
        playerScore3: Hazai1JatekosSzett3,
        playerScore4: Hazai1JatekosSzett4,
      ),
      Player(
        playerName: "Első Vendég",
        playerScore1: Vendeg1JatekosSzett1,
        playerScore2: Vendeg1JatekosSzett2,
        playerScore3: Vendeg1JatekosSzett3,
        playerScore4: Vendeg1JatekosSzett4,
      )
    ]);
    myRowDataList.add([
      Player(
        playerName: "Senek Gábor",
        playerScore1: Hazai2JatekosSzett1,
        playerScore2: Hazai2JatekosSzett2,
        playerScore3: Hazai2JatekosSzett3,
        playerScore4: Hazai2JatekosSzett4,
      ),
      Player(
        playerName: "Második Vendég",
        playerScore1: Vendeg2JatekosSzett1,
        playerScore2: Vendeg2JatekosSzett2,
        playerScore3: Vendeg2JatekosSzett3,
        playerScore4: Vendeg2JatekosSzett4,
      )
    ]);

    myRowDataList.add([
      Player(
        playerName: "Kis Dávid",
        playerScore1: Hazai3JatekosSzett1 ?? 0,
        playerScore2: Hazai3JatekosSzett2 ?? 0,
        playerScore3: Hazai3JatekosSzett3 ?? 0,
        playerScore4: Hazai3JatekosSzett4 ?? 0, // Negyedik szett eredménye
      ),
      Player(
        playerName: "Harmadik Vendég",
        playerScore1: Vendeg3JatekosSzett1 ?? 0,
        playerScore2: Vendeg3JatekosSzett2 ?? 0,
        playerScore3: Vendeg3JatekosSzett3 ?? 0,
        playerScore4: Vendeg3JatekosSzett4 ?? 0, // Negyedik szett eredménye
      ),
    ]);

    myRowDataList.add([
      Player(
        playerName: "Panyi Tamás",
        playerScore1: Hazai4JatekosSzett1 ?? 0,
        playerScore2: Hazai4JatekosSzett2 ?? 0,
        playerScore3: Hazai4JatekosSzett3 ?? 0,
        playerScore4: Hazai4JatekosSzett4 ?? 0, // Negyedik szett eredménye
      ),
      Player(
        playerName: "Negyedik Vendég",
        playerScore1: Vendeg4JatekosSzett1 ?? 0,
        playerScore2: Vendeg4JatekosSzett2 ?? 0,
        playerScore3: Vendeg4JatekosSzett3 ?? 0,
        playerScore4: Vendeg4JatekosSzett4 ?? 0, // Negyedik szett eredménye
      ),
    ]);

// Ötödik játékos hozzáadása a myRowDataList-hez
    myRowDataList.add([
      Player(
        playerName: "Hegyi Dávid",
        playerScore1: Hazai5JatekosSzett1 ?? 0,
        playerScore2: Hazai5JatekosSzett2 ?? 0,
        playerScore3: Hazai5JatekosSzett3 ?? 0,
        playerScore4: Hazai5JatekosSzett4 ?? 0,
      ),
      Player(
        playerName: "Ötödik Vendég",
        playerScore1: Vendeg5JatekosSzett1 ?? 0,
        playerScore2: Vendeg5JatekosSzett2 ?? 0,
        playerScore3: Vendeg5JatekosSzett3 ?? 0,
        playerScore4: Vendeg5JatekosSzett4 ?? 0,
      ),
    ]);

// Hatodik játékos hozzáadása a myRowDataList-hez
    myRowDataList.add([
      Player(
        playerName: "Fódi Gábor",
        playerScore1: Hazai6JatekosSzett1 ?? 0,
        playerScore2: Hazai6JatekosSzett2 ?? 0,
        playerScore3: Hazai6JatekosSzett3 ?? 0,
        playerScore4: Hazai6JatekosSzett4 ?? 0,
      ),
      Player(
        playerName: "Hatodik Vendég",
        playerScore1: Vendeg6JatekosSzett1 ?? 0,
        playerScore2: Vendeg6JatekosSzett2 ?? 0,
        playerScore3: Vendeg6JatekosSzett3 ?? 0,
        playerScore4: Vendeg6JatekosSzett4 ?? 0,
      ),
    ]);



// Ezután, amikor hozzáadod az adatokat a myRowDataList-hez, már rendelkezésre állnak a megfelelő listák.
// Itt az 'end_results' lista minden második elemét (0, 2, 4, ...) használjuk a hazai játékosokhoz,
// és minden második plusz egy elemét (1, 3, 5, ...) a vendég játékosokhoz.
    int rowIndex = 0; // Számláló a sorok indexelésére
    int secondrowIndex = -1;

    for (var rowData in myRowDataList) {


      rowIndex++;
      secondrowIndex++;// Növeljük a rowIndex értékét az aktuális sor elején

      // Itt csak azokat az elemeket állítjuk be, amelyeknél a piros háttér szükséges.
      Color setColorForSet(int setNumber, int playerIndex) {
        // Ellenőrizzük, hogy a sor száma és a szett száma alapján szükséges-e a piros háttér.
        bool isRed = false;
        if ((setNumber >= 1 && setNumber <= 4 && (rowIndex == 2 || rowIndex == 3)) ||
            (setNumber >= 5 && setNumber <= 8 && (rowIndex == 4 || rowIndex == 5)) ||
            (setNumber >= 9 && setNumber <= 12 && (rowIndex == 6 || rowIndex == 7))) {
          // Ha ezek a feltételek teljesülnek, használjuk a logikát a 'usingTempResultsForSetX' változókra.
          switch (setNumber) { // A megfelelő szett változók alapján döntünk
            case 1:
              isRed = usingTempResultsForSet1 && (playerIndex == 0 || playerIndex == 1);
              break;
            case 2:
              isRed = usingTempResultsForSet2 && (playerIndex == 0 || playerIndex == 1);
              break;
            case 3:
              isRed = usingTempResultsForSet3 && (playerIndex == 0 || playerIndex == 1);
              break;
            case 4:
              isRed = usingTempResultsForSet4 && (playerIndex == 0 || playerIndex == 1);
              break;
            case 5:
              isRed = usingTempResultsForSet5 && (playerIndex == 0 || playerIndex == 1);
              break;
            case 6:
              isRed = usingTempResultsForSet6 && (playerIndex == 0 || playerIndex == 1);
              break;
            case 7:
              isRed = usingTempResultsForSet7 && (playerIndex == 0 || playerIndex == 1);
              break;
            case 8:
              isRed = usingTempResultsForSet8 && (playerIndex == 0 || playerIndex == 1);
              break;
            case 9:
              isRed = usingTempResultsForSet9 && (playerIndex == 0 || playerIndex == 1);
              break;
            case 10:
              isRed = usingTempResultsForSet10 && (playerIndex == 0 || playerIndex == 1);
              break;
            case 11:
              isRed = usingTempResultsForSet11 && (playerIndex == 0 || playerIndex == 1);
              break;
            case 12:
              isRed = usingTempResultsForSet12 && (playerIndex == 0 || playerIndex == 1);
              break;
            default:
              isRed = false; // Ha a szett száma nem egyezik meg, nincs piros háttér
              break;
          }
        }
        return isRed ? Colors.orange : Colors.white; // Piros, ha a feltétel igaz, egyébként fehér.
      }

      TableCell createComparisonCell(int homeScore, int awayScore, int setNumber, int playerIndex, int rowIndex, String setText) {
        // A cella színét alapértelmezetten fehérre állítjuk, vagy a setColorForSet által adott színre, ha nem fehér
        Color cellColor = setColorForSet(setNumber, playerIndex);

        // Ellenőrizzük, hogy a setColorForSet fehér színt adott-e vissza, és ha igen, akkor hasonlítsuk össze a pontszámokat
        if (cellColor == Colors.white) {
          // Csak a második és harmadik sorokra alkalmazzuk a vizsgálatot
          if (secondrowIndex == 1 || secondrowIndex == 2 || secondrowIndex == 3 || secondrowIndex == 4 || secondrowIndex == 5 || secondrowIndex == 6) { // Ha a második vagy harmadik sorban vagyunk
            cellColor = homeScore > awayScore ? Colors.green // Hazai nagyobb, zöld
                : homeScore < awayScore ? Colors.red // Vendég nagyobb, piros
                : Colors.white60; // Egyenlő, sárga
          }
        }

        // Készítsük el a TableCell-t a számított színnel
        return TableCell(
          verticalAlignment: TableCellVerticalAlignment.top,
          child: Container(
            height: 32,
            width: 32,
            color: cellColor, // Itt alkalmazzuk a kiszámított színt
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (rowData[0].isSum)
                  Text(setText)
                else
                  Text(homeScore.toString()),
              ],
            ),
          ),
        );
      }


      rows.add(
        TableRow(
          children: <Widget>[
            Container(
              height: 32,
              color: Colors.lightBlueAccent,
              alignment: Alignment.center,
              child: Text(rowData[0].playerName),
            ), // Az első szett eredményének cellája
            createComparisonCell(rowData[0].playerScore1, rowData[1].playerScore1, 1, 0, rowIndex, "1.szett"),
            createComparisonCell(rowData[0].playerScore2, rowData[1].playerScore2, 2, 0, rowIndex, "2.szett"),
            createComparisonCell(rowData[0].playerScore3, rowData[1].playerScore3, 3, 0, rowIndex, "3.szett"),
            createComparisonCell(rowData[0].playerScore4, rowData[1].playerScore4, 4, 0, rowIndex, "4.szett"),
            // További szettek eredményeinek cellái, stb.

            TableCell(
              verticalAlignment: TableCellVerticalAlignment.top,
              child: Container(
                height: 32,
                width: 32,
                color: Colors.blueGrey,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (rowData[0].isSum)
                      Text("össz.")
                    else
                      Text(rowData[0].totalScore.toString()),
                  ],
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.top,
              child: Container(
                height: 32,
                width: 32,
                color: Colors.blueGrey,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (rowData[1].isSum)
                      Text("össz.")
                    else
                      Text(rowData[1].totalScore.toString()),
                  ],
                ),
              ),
            ),


            createComparisonCell(rowData[1].playerScore1, rowData[0].playerScore1, 1, 1, rowIndex, "1.szett"),
            createComparisonCell(rowData[1].playerScore2, rowData[0].playerScore2, 2, 1, rowIndex, "2.szett"),
            createComparisonCell(rowData[1].playerScore3, rowData[0].playerScore3, 3, 1, rowIndex, "3.szett"),
            createComparisonCell(rowData[1].playerScore4, rowData[0].playerScore4, 4, 1, rowIndex, "4.szett"),


            Container(
              height: 32,
              color: Colors.blue,
              alignment: Alignment.center,
              child: Text(rowData[1].playerName),
            ),
          ],
        ),
      );
    }
  }




  Widget twoColumnTable() {
    List<TableRow> twoColumnRows = [
      // Fejléc sor
      TableRow(
        children: <Widget>[
          Container(
            height: 32,
            color: Colors.grey,
            alignment: Alignment.center,
            child: const Text(
              'Herend Városi Teke Klub',
              style: TextStyle(fontSize: 24), // Itt állítjuk be a szöveg méretét.
            ),
          ),
          Container(
            height: 32,
            color: Colors.grey,
            alignment: Alignment.center,
            child: const Text(
              'Vendég csapat',
              style: TextStyle(fontSize: 24), // Itt állítjuk be a szöveg méretét.
            ),

          ),
        ],
      ),
      // Ide jönnek az adatsorok
      // ...
    ];

    return Table(
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>{
        0: FlexColumnWidth(1), // Ez az oszlop veszi a rendelkezésre álló hely felét
        1: FlexColumnWidth(1), // Ez az oszlop szintén a rendelkezésre álló hely felét veszi
      },
      children: twoColumnRows,
    );
  }


  Widget twoColumnTablealso() {
    calculateTotalScores();


    List<TableRow> twoColumnRows = [
      // Fejléc sor
      TableRow(
        children: <Widget>[
          Container(
            height: 32,
            color: Colors.grey,
            alignment: Alignment.center,
            child: Text(
              totalHomeScore.toString(),
              style: TextStyle(fontSize: 24), // Szöveg betűmérete itt 24-es.
            ),
          ),
          Container(
            height: 32,
            color: Colors.grey,
            alignment: Alignment.center,
            child: Text(
              totalAwayScore.toString(),
              style: TextStyle(fontSize: 24), // Szöveg betűmérete itt 24-es.
            ),
          ),
        ],
      ),
      // Ide jönnek az adatsorok
      // ...
    ];

    return Table(
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(60),
        1: FixedColumnWidth(60),
      },
      children: twoColumnRows,
    );
  }

  void calculateTotalScores() {
    // Átmeneti változók, hogy ne írjuk felül a globális értékeket minden híváskor
    int tempTotalHomeScore = 0;
    int tempTotalAwayScore = 0;

    // Számítások elvégzése az összesített pontszámokhoz
    for (var pair in myRowDataList) {
      tempTotalHomeScore += pair[0].totalScore;
      tempTotalAwayScore += pair[1].totalScore;
    }

    // Kivonjuk a 10-et az összesített pontszámokból
    totalHomeScore = tempTotalHomeScore - 10;
    totalAwayScore = tempTotalAwayScore - 10;
  }

  Widget kulonbseg() {
    // A pontkülönbség kiszámítása.
    int scoreDifference = totalHomeScore - totalAwayScore;
    // A háttérszín beállítása a pontkülönbség alapján.
    Color backgroundColor = scoreDifference >= 0 ? Colors.green : Colors.red;

    return Table(
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(120), // Az oszlop szélessége.
      },
      children: [
        TableRow(
          children: [
            Container(
              height: 40, // A cella magassága.
              color: backgroundColor,
              alignment: Alignment.center,
              child: Text(
                scoreDifference.toString(), // A pontkülönbség szövege.
                style: TextStyle(fontSize: 24), // A szöveg stílusa.
              ),
            ),
          ],
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: FutureBuilder<ResultData>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data found'));
          }

          return Column(
            children: <Widget>[
              Text(snapshot.data!.end_results.toString()),
              Text(snapshot.data!.temp_results.toString()),
              //Text(Hazai1JatekosSzett2.toString()),
              twoColumnTable(),
              Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(300),
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth(),
                  3: FlexColumnWidth(),
                  4: FlexColumnWidth(),
                  5: FixedColumnWidth(60),
                  6: FixedColumnWidth(60),
                  7: FlexColumnWidth(),
                  8: FlexColumnWidth(),
                  9: FlexColumnWidth(),
                  10: FlexColumnWidth(),
                  11: FixedColumnWidth(300),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: rows,
              ),
              twoColumnTablealso(),
              kulonbseg(),
            ],
          );
        },
      ),
    );
  }

  List<DataRow> _generateRows(ResultData data) {
    final endResults = data.end_results?[0] ?? [];

    List<DataRow> rows = List.generate(6, (index) {
      // Előre kitöltünk egy alap sort
      List<DataCell> cells =
      List.generate(12, (colIndex) => DataCell(Text('')));

      // Második sor, második oszlop
      if (index == 1 && endResults.length > 0) {
        cells[1] = DataCell(Text(endResults[0]));
      }
      // Második sor, 8. oszlop
      if (index == 1 && endResults.length > 1) {
        cells[7] = DataCell(Text(endResults[1]));
      }
      // Harmadik sor, második oszlop
      if (index == 2 && endResults.length > 2) {
        cells[1] = DataCell(Text(endResults[2]));
      }
      // Harmadik sor, 8. oszlop
      if (index == 2 && endResults.length > 3) {
        cells[7] = DataCell(Text(endResults[3]));
      }

      return DataRow(cells: cells);
    });

    return rows;
  }




}

@JsonSerializable()
class ResultData {
  final List<dynamic>? end_results;
  final List<dynamic>? temp_results;

  ResultData({this.end_results, this.temp_results});

  factory ResultData.fromJson(Map<String, dynamic> json) =>
      _$ResultDataFromJson(json);
  Map<String, dynamic> toJson() => _$ResultDataToJson(this);
}

