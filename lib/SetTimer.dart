import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';


const List<String> list = <String>['AM','PM'];

class CreateSchedules extends StatefulWidget{
  final String ScheduleNo;
  const CreateSchedules({Key? key, required this.ScheduleNo}) : super(key: key);

  @override
  State<CreateSchedules> createState() => _CreateSchedules(ScheduleNo: ScheduleNo);
}


class _CreateSchedules extends State<CreateSchedules>{

  _CreateSchedules({required this.ScheduleNo});
  final String ScheduleNo;
  int Start_hr = 6;
  int Start_min = 10;
  String Start_Dur = 'AM';
  int End_hr = 6;
  int End_min = 10;
  String End_Dur = 'AM';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
            theme: ThemeData(
              colorScheme: const ColorScheme(
                brightness: Brightness.light,
                primary: Color.fromARGB(116, 61, 201, 96),
                onPrimary: Colors.black,
                // Colors that are not relevant to AppBar in LIGHT mode:
                primaryVariant: Colors.grey,
                secondary: Colors.grey,
                secondaryVariant: Colors.grey,
                onSecondary: Colors.grey,
                background: Colors.grey,
                onBackground: Colors.grey,
                surface: Colors.grey,
                onSurface: Colors.grey,
                error: Colors.grey,
                onError: Colors.grey,
              ),
            ),
            home: Scaffold(
              appBar: AppBar(
                title: const Row(
                  children: [
                    Text("WasserCraft", style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
              body: Column(
                children: [
                            const Row(
                              children: [Text('Start Time')]
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    children: [
                                      NumberPicker(
                                        value: Start_hr,
                                        minValue: 1,
                                        maxValue: 12,
                                        onChanged: (value) => setState(() => Start_hr = value),
                                      ),
                                      const Text('Hour'),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      NumberPicker(
                                        value: Start_min,
                                        minValue: 0,
                                        maxValue: 59,
                                        onChanged: (value) => setState(() => Start_min = value),
                                      ),
                                      const Text('Mins'),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      DropdownButton<String>(
                                        value: Start_Dur,
                                        icon: const Icon(Icons.arrow_downward),
                                        elevation: 16,
                                        style: const TextStyle(color: Colors.deepPurple),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            Start_Dur = value!;
                                          });
                                        },
                                        items: list.map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                      ),
                                    ],
                                  )
                                ]
                              ),
                              const Row(
                              children: [Text('Start Time')]
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    children: [
                                      NumberPicker(
                                        value: End_hr,
                                        minValue: 1,
                                        maxValue: 12,
                                        onChanged: (value) => setState(() => End_hr = value),
                                      ),
                                      const Text('Hour'),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      NumberPicker(
                                        value: End_min,
                                        minValue: 0,
                                        maxValue: 59,
                                        onChanged: (value) => setState(() => End_min = value),
                                      ),
                                      const Text('Mins'),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      DropdownButton<String>(
                                        value: End_Dur,
                                        icon: const Icon(Icons.arrow_downward),
                                        elevation: 16,
                                        style: const TextStyle(color: Colors.deepPurple),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            End_Dur = value!;
                                          });
                                        },
                                        items: list.map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                      ),
                                    ],
                                  )
                                ]
                              ),
                ],
              )
            )
          );
    }
}
