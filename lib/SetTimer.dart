import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';


const List<String> list = <String>['AM','PM'];

class CreateSchedules extends StatefulWidget{
  //final String ScheduleNo;
  final String T_Start_hr;
  final String T_Start_min;
  final String T_End_hr;
  final String T_End_min;
  final List<String> Checks;
  final List<String> Relays;
  
  const CreateSchedules({Key? key, required this.T_Start_hr,required this.T_Start_min,required this.T_End_hr,required this.T_End_min,required this.Checks,required this.Relays}) : super(key: key);

  @override
  State<CreateSchedules> createState() => _CreateSchedules(T_Start_hr: T_Start_hr,T_Start_min: T_Start_min,T_End_hr: T_End_hr,T_End_min: T_End_min,Checks: Checks,Relays: Relays);
}


class _CreateSchedules extends State<CreateSchedules>{

  _CreateSchedules({required this.T_Start_hr,required this.T_Start_min,required this.T_End_hr,required this.T_End_min,required this.Checks,required this.Relays});
  //final String ScheduleNo;
  final String T_Start_hr;
  final String T_Start_min;
  final String T_End_hr;
  final String T_End_min;
  final List<String> Checks;
  final List<String> Relays;

  int Start_hr = 6;
  int Start_min = 10;
  String Start_Dur = 'AM';
  int End_hr = 6;
  int End_min = 10;
  String End_Dur = 'AM';
  bool MondaycheckBoxValue = false;
  bool TuesdaycheckBoxValue = false;
  bool WednesdaycheckBoxValue = false;
  bool ThursdaycheckBoxValue = false;
  bool FridaycheckBoxValue = false;
  bool SatudaycheckBoxValue = false;
  bool SundaycheckBoxValue = false;
  var values = {"1":false,"2":false};

  @override
  void initState() {
    super.initState();
    Start_hr = int.parse(T_Start_hr);
    Start_min = int.parse(T_Start_min);
    Start_Dur = 'AM';
    End_hr = int.parse(T_End_hr);
    End_min = int.parse(T_End_min);
    End_Dur = 'AM';
    MondaycheckBoxValue = bool.parse(Checks[0]);
    TuesdaycheckBoxValue = bool.parse(Checks[1]);
    WednesdaycheckBoxValue = bool.parse(Checks[2]);
    ThursdaycheckBoxValue = bool.parse(Checks[3]);
    FridaycheckBoxValue = bool.parse(Checks[4]);
    SatudaycheckBoxValue = bool.parse(Checks[5]);
    SundaycheckBoxValue = bool.parse(Checks[6]);
    Map<String,bool> samVal = {};
    for(var i=0;i<Relays.length;i++){
      samVal[(i+1).toString()] = bool.parse(Relays[i]);
    }
    values = samVal;
    
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
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueAccent)
                              ),
                              child:Column(
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
                                                        itemHeight: 30,
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
                                                        itemHeight: 30,
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
                                            ],
                                    ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueAccent)
                                ),
                                child:Column(
                                      children: [
                                        const Row(
                                                children: [Text('End Time')]
                                              ),
                                              Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Column(
                                                      children: [
                                                        NumberPicker(
                                                          itemHeight: 30,
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
                                                          itemHeight: 30,
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
                                      ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueAccent)
                                ),
                                child: Column(
                                  children: [
                                    const Row(
                                      children: [
                                        Text('Select Days'),
                                      ]
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Checkbox(value: SundaycheckBoxValue,
                                              activeColor: Colors.green,
                                              onChanged:(bool? value) {
                                                setState(() {
                                                  SundaycheckBoxValue = value ?? false;
                                                });
                                              },
                                            ),
                                            const Text('Sun'),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Checkbox(value: MondaycheckBoxValue,
                                              activeColor: Colors.green,
                                              onChanged:(bool? value) {
                                                setState(() {
                                                  MondaycheckBoxValue = value ?? false;
                                                });
                                              },
                                            ),
                                            const Text('Mon'),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Checkbox(value: TuesdaycheckBoxValue,
                                              activeColor: Colors.green,
                                              onChanged:(bool? value) {
                                                setState(() {
                                                  TuesdaycheckBoxValue = value ?? false;
                                                });
                                              },
                                            ),
                                            const Text('Tue'),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Checkbox(value: WednesdaycheckBoxValue,
                                              activeColor: Colors.green,
                                              onChanged:(bool? value) {
                                                setState(() {
                                                  WednesdaycheckBoxValue = value ?? false;
                                                });
                                              },
                                            ),
                                            const Text('Wed'),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Checkbox(value: ThursdaycheckBoxValue,
                                              activeColor: Colors.green,
                                              onChanged:(bool? value) {
                                                setState(() {
                                                  ThursdaycheckBoxValue = value ?? false;
                                                });
                                              },
                                            ),
                                            const Text('Thu'),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Checkbox(value: FridaycheckBoxValue,
                                              activeColor: Colors.green,
                                              onChanged:(bool? value) {
                                                setState(() {
                                                  FridaycheckBoxValue = value ?? false;
                                                });
                                              },
                                            ),
                                            const Text('Fri'),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Checkbox(value: SatudaycheckBoxValue,
                                              activeColor: Colors.green,
                                              onChanged:(bool? value) {
                                                setState(() {
                                                  SatudaycheckBoxValue = value ?? false;
                                                });
                                              },
                                            ),
                                            const Text('Sat'),
                                          ],
                                        ),
                                      ],
                                    )
                                  ]
                                )
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueAccent)
                                ),
                                child: Column(
                                  children: [
                                    const Row(
                                      children: [
                                        Text('Select Relays'),
                                      ]
                                    ),
                                    Row(
                                      children: values.keys.map((String key) {
                                                return Column(
                                                  children: [
                                                    Checkbox(value: values[key],
                                                      activeColor: Colors.green,
                                                      onChanged:(bool? value) {
                                                        setState(() {
                                                          values[key] = value ?? false;
                                                        });
                                                      },
                                                    ),
                                                    Text("R$key"),
                                                  ],
                                                );
                                              }).toList(),
                                    ),
                                  ]
                                )
                              ),
                ],
              ),
              floatingActionButton: FloatingActionButton.extended(
                                onPressed: (){
                                  
                                },
                                icon: const Icon(Icons.save),
                                label: const Text('Save Schedules'),
                                elevation: 12,
                                backgroundColor: Color.fromARGB(116, 61, 201, 96),
                                foregroundColor: Colors.white
                              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            )
          );
    }
}
