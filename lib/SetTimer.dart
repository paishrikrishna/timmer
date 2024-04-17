import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:timmer/ApiCallsToTimer.dart';
import 'package:timmer/SetTimerOpts.dart';


const List<String> list = <String>['AM','PM'];

class CreateSchedules extends StatefulWidget{
  final String ScheduleNo;
  final String T_Start_hr;
  final String T_Start_min;
  final String T_End_hr;
  final String T_End_min;
  final List<String> Checks;
  final List<String> Relays;
  
  const CreateSchedules({Key? key, required this.ScheduleNo,required this.T_Start_hr,required this.T_Start_min,required this.T_End_hr,required this.T_End_min,required this.Checks,required this.Relays}) : super(key: key);

  @override
  State<CreateSchedules> createState() => _CreateSchedules(ScheduleNo: ScheduleNo,T_Start_hr: T_Start_hr,T_Start_min: T_Start_min,T_End_hr: T_End_hr,T_End_min: T_End_min,Checks: Checks,Relays: Relays);
}


class _CreateSchedules extends State<CreateSchedules>{

  _CreateSchedules({required this.ScheduleNo,required this.T_Start_hr,required this.T_Start_min,required this.T_End_hr,required this.T_End_min,required this.Checks,required this.Relays});
  final String ScheduleNo;
  final String T_Start_hr;
  final String T_Start_min;
  final String T_End_hr;
  final String T_End_min;
  final List<String> Checks;
  final List<String> Relays;

  String ReqType = "";
  String ScheduleNo_F = 'Save S';
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
    ScheduleNo_F = (ScheduleNo=="A")?"Save Schedules":"Update Schedule";
    ReqType = (ScheduleNo_F=="Update Schedule")?ScheduleNo:"I";
    Start_hr = (int.parse(T_Start_hr)>12)?(int.parse(T_Start_hr)-12):(int.parse(T_Start_hr)==0)?12:int.parse(T_Start_hr);
    Start_min = int.parse(T_Start_min);
    Start_Dur = (int.parse(T_Start_hr)>=12)?"PM":"AM";
    End_hr = (int.parse(T_End_hr)>12)?(int.parse(T_End_hr)-12):(int.parse(T_End_hr)==0)?12:int.parse(T_End_hr);
    End_min = int.parse(T_End_min);
    End_Dur = (int.parse(T_End_hr)>=12)?"PM":"AM";
    MondaycheckBoxValue = bool.parse(Checks[1]);
    TuesdaycheckBoxValue = bool.parse(Checks[2]);
    WednesdaycheckBoxValue = bool.parse(Checks[3]);
    ThursdaycheckBoxValue = bool.parse(Checks[4]);
    FridaycheckBoxValue = bool.parse(Checks[5]);
    SatudaycheckBoxValue = bool.parse(Checks[6]);
    SundaycheckBoxValue = bool.parse(Checks[0]);
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
                //primaryVariant: Colors.grey,
                secondary: Colors.grey,
                //secondaryVariant: Colors.grey,
                onSecondary: Colors.grey,
                background: Colors.white,
                onBackground: Colors.grey,
                surface: Color.fromARGB(116, 61, 201, 96),
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
                              Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                            Visibility(
                                              visible: (ScheduleNo_F=="Update Schedule")?true:false,
                                              child: Container(
                                                        child: GestureDetector(
                                                        onTap: () {
                                                          ApiCallsToTimer().DeleteScheduleDetails(ScheduleNo).then((value) {
                                                            print("Deleted Schedule $ScheduleNo");
                                                            ApiCallsToTimer().ScheduleCount('192.168.1.1').then((value1) {
                                                              int deviceCount = 0;
                                                              List <String> payload = value1.split(",");
                                                              if(payload[0]!='') {
                                                                deviceCount = payload.length;
                                                              }
                                                              Navigator.pop(context);
                                                              Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                return SetTimer(ScheduleCount: deviceCount, Schedule_dets:payload);
                                                              }));
                                                            });
                                                          });
                                                        },
                                                      child: Container(
                                                              decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.red),
                                                                color: Colors.red,
                                                                borderRadius: BorderRadius.all(Radius.circular(10) ),
                                                              ),
                                                              padding: const EdgeInsets.all(4),
                                                              child: const Row(
                                                                children: [
                                                                  Icon(Icons.delete,color: Colors.white,),
                                                                  SizedBox(width: 2,),
                                                                  Text("Delete Schedule",style: TextStyle(color: Colors.white),),    
                                                                ],
                                                              )
                                                              ,
                                                            ),
                                                      )
                                                    ),
                                            ),
                                            Container(
                                                child: GestureDetector(
                                                onTap: (){
                                                  String Days = "${(SundaycheckBoxValue == true)?'1':'0'}${(MondaycheckBoxValue == true)?'1':'0'}${(TuesdaycheckBoxValue == true)?'1':'0'}${(WednesdaycheckBoxValue == true)?'1':'0'}${(ThursdaycheckBoxValue == true)?'1':'0'}${(FridaycheckBoxValue == true)?'1':'0'}${(SatudaycheckBoxValue == true)?'1':'0'}";
                                                  String Relays = "";
                                                  for(var i =0;i<values.keys.length;i++){
                                                    Relays += "${(values[values.keys.toList()[i]] == true)?'1':'0'}";
                                                  }
                                                  if(Start_Dur == 'AM'){
                                                    Start_hr = ((Start_hr) == 12)?0:(Start_hr);
                                                  }
                                                  else{
                                                    Start_hr = (((Start_hr) == 12)?12:(12 + Start_hr));
                                                  }

                                                  if(End_Dur == 'AM'){
                                                    End_hr = ((End_hr) == 12)?0:(End_hr);
                                                  }
                                                  else{
                                                    End_hr = (((End_hr) == 12)?12:(12 + End_hr));
                                                  }

                                                  ApiCallsToTimer().pushSchedule(Start_hr.toString(),Start_min.toString(),End_hr.toString(),End_min.toString(),Relays,Days,ReqType).then((value) {
                                                    print("Update");
                                                    print(value);
                                                    ApiCallsToTimer().ScheduleCount('192.168.1.1').then((value1) {
                                                      int deviceCount = 0;
                                                      List <String> payload = value1.split(",");
                                                      if(payload[0]!='') {
                                                        deviceCount = payload.length;
                                                      }
                                                      Navigator.pop(context);
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                        return SetTimer(ScheduleCount: deviceCount, Schedule_dets:payload);
                                                      }));
                                                    });
                                                  },);

                                                  print(Days);
                                                  print(Relays);
                                                },
                                              child: Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.green),
                                                        color: Colors.green,
                                                        borderRadius: BorderRadius.all(Radius.circular(10) ),
                                                      ),
                                                      padding: const EdgeInsets.all(4),
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons.save,color: Colors.white,),
                                                          SizedBox(width: 2,),
                                                          Text(ScheduleNo_F,style: TextStyle(color: Colors.white),),    
                                                        ],
                                                      )
                                                      ,
                                                    ),
                                              )
                                            )
                                          ],
                                )
                              ),
                ],
              ),
            )
          );
    }
}
