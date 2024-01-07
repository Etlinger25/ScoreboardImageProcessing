import 'dart:math';

import 'package:fletterapp/Player.dart';
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
      home: const MyHomePage(title: 'Flutter Demo Hfdsfdome Page'),
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

  addTableElements(ResultData data) {
    myRowDataList = [];
    print(data.end_results);
    myRowDataList.add([
      Player(
        playerName: "Herend",
        playerScore1: 1,
        playerScore2: 2,
        playerScore3: 3,
        playerScore4: 4,
        isSum: true,
      ),
      Player(
        playerName: "Gotthárd",
        playerScore1: 1,
        playerScore2: 2,
        playerScore3: 3,
        playerScore4: 4,
        isSum: true,
      )
    ]);

    var playerScore1 = 0;
    var playerScore2 = 0;
    var playerScore3 = 0;
    var playerScore4 = 0;

    if (data.end_results!.length > 0 && data.end_results?[0] != null) {
      var score = int.tryParse(data.end_results?[0][0]);
      playerScore1 = score ?? 0;
    } else if (data.end_results!.length == 0) {
      var score = int.tryParse(data.temp_results?[0][0]);
      playerScore1 = score ?? 0;
    }
    if (data.end_results!.length > 1 && data.end_results?[1] != null) {
      var score = int.tryParse(data.end_results?[1][0]);
      playerScore2 = score ?? 0;
    } else if (data.end_results!.length == 1) {
      var score = int.tryParse(data.temp_results?[0][0]);
      playerScore2 = score ?? 0;
    }
    if (data.end_results!.length > 2 && data.end_results![2] != null) {
      var score = int.tryParse(data.end_results?[2][0]);
      playerScore3 = score ?? 0;
    } else if (data.end_results!.length == 2) {
      var score = int.tryParse(data.temp_results?[0][0]);
      playerScore3 = score ?? 0;
    }
    if (data.end_results!.length > 3 && data.end_results?[3] != null) {
      var score = int.tryParse(data.end_results?[3][0]);
      playerScore4 = score ?? 0;
    } else if (data.end_results!.length == 3) {
      var score = int.tryParse(data.temp_results?[0][0]);
      playerScore4 = score ?? 0;
    }

    var player2Score1 = 0;
    var player2Score2 = 0;
    var player2Score3 = 0;
    var player2Score4 = 0;

    if (data.end_results!.length > 0 && data.end_results?[0] != null) {
      var score = int.tryParse(data.end_results?[0][1]);
      player2Score1 = score ?? 0;
    } else if (data.end_results!.length == 0) {
      var score = int.tryParse(data.temp_results?[0][1]);
      player2Score1 = score ?? 0;
    }
    if (data.end_results!.length > 1 && data.end_results?[1] != null) {
      var score = int.tryParse(data.end_results?[1][1]);
      player2Score2 = score ?? 0;
    } else if (data.end_results!.length == 1) {
      var score = int.tryParse(data.temp_results?[0][1]);
      player2Score2 = score ?? 0;
    }
    if (data.end_results!.length > 2 && data.end_results![2] != null) {
      var score = int.tryParse(data.end_results?[2][1]);
      player2Score3 = score ?? 0;
    } else if (data.end_results!.length == 2) {
      var score = int.tryParse(data.temp_results?[0][1]);
      player2Score3 = score ?? 0;
    }
    if (data.end_results!.length > 3 && data.end_results?[3] != null) {
      var score = int.tryParse(data.end_results?[3][1]);
      player2Score4 = score ?? 0;
    } else if (data.end_results!.length == 3) {
      var score = int.tryParse(data.temp_results?[0][1]);
      player2Score4 = score ?? 0;
    }

    myRowDataList.add([
      Player(
        playerName: "András",
        playerScore1: playerScore1,
        playerScore2: playerScore2,
        playerScore3: playerScore3,
        playerScore4: playerScore4,
      ),
      Player(
        playerName: "Gotthárd",
        playerScore1: player2Score1,
        playerScore2: player2Score2,
        playerScore3: player2Score3,
        playerScore4: player2Score4,
      )
    ]);

    for (var rowData in myRowDataList) {
      rows.add(
        TableRow(
          children: <Widget>[
            Container(
              height: 32,
              color: Colors.green,
              alignment: Alignment.center,
              child: Text(rowData[0].playerName),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.top,
              child: Container(
                height: 32,
                width: 32,
                color: Colors.red,
                alignment: Alignment.center,
                child: Text(rowData[0].playerScore1.toString()),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.top,
              child: Container(
                height: 32,
                width: 32,
                color: Colors.red,
                alignment: Alignment.center,
                child: Text(rowData[0].playerScore2.toString()),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.top,
              child: Container(
                height: 32,
                width: 32,
                color: Colors.red,
                alignment: Alignment.center,
                child: Text(rowData[0].playerScore3.toString()),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.top,
              child: Container(
                height: 32,
                width: 32,
                color: Colors.red,
                alignment: Alignment.center,
                child: Text(rowData[0].playerScore4.toString()),
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
                    if (rowData[0].isSum)
                      Text("össz.")
                    else
                      Text(rowData[0].playerTotalScore.toString()),
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
                      Text(rowData[1].playerTotalScore.toString()),
                  ],
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.top,
              child: Container(
                height: 32,
                width: 32,
                color: Colors.red,
                alignment: Alignment.center,
                child: Text(rowData[1].playerScore1.toString()),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.top,
              child: Container(
                height: 32,
                width: 32,
                color: Colors.red,
                alignment: Alignment.center,
                child: Text(rowData[1].playerScore2.toString()),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.top,
              child: Container(
                height: 32,
                width: 32,
                color: Colors.red,
                alignment: Alignment.center,
                child: Text(rowData[1].playerScore3.toString()),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.top,
              child: Container(
                height: 32,
                width: 32,
                color: Colors.red,
                alignment: Alignment.center,
                child: Text(rowData[1].playerScore4.toString()),
              ),
            ),
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
            return Center(child: Text('Error2: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data found'));
          }

          return Column(
            children: [
              Text(snapshot.data!.end_results.toString()),
              Text(snapshot.data!.temp_results.toString()),
              Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  0: FixedColumnWidth(300),
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth(),
                  3: FlexColumnWidth(),
                  4: FlexColumnWidth(),
                  5: FlexColumnWidth(),
                  6: FlexColumnWidth(),
                  7: FlexColumnWidth(),
                  8: FlexColumnWidth(),
                  9: FlexColumnWidth(),
                  10: FlexColumnWidth(),
                  11: FixedColumnWidth(300),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: rows,
              )
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
