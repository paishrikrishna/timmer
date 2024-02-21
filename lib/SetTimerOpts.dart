import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:timmer/SetTimer.dart';

class SetTimer extends StatefulWidget{
  final int ScheduleCount;
  const SetTimer({Key? key, required this.ScheduleCount}) : super(key: key);

  @override
  State<SetTimer> createState() => _SetTimer(ScheduleCount: ScheduleCount);
}


class _SetTimer extends State<SetTimer>{

  _SetTimer({required this.ScheduleCount});
  final int ScheduleCount;

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
              body: ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: ScheduleCount,
                      itemBuilder: (BuildContext context, int index) {
                        return SelectTimer((index+1).toString());
                      },
                      separatorBuilder: (BuildContext context, int index) => const Divider(),
                    ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return CreateSchedules(ScheduleNo: '0');
                  }));
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Schedules'),
                elevation: 12,
                backgroundColor: Color.fromARGB(116, 61, 201, 96),
                foregroundColor: Colors.white

              )
            )
          );
    }
}


class SelectTimer extends StatelessWidget { 

  SelectTimer(this.ScheduleNo);

  final String ScheduleNo;

  @override 
  Widget build(BuildContext context){ 
    return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child:  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return CreateSchedules(ScheduleNo: ScheduleNo);
                      }));
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(240, 137, 140, 236),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      height: MediaQuery.of(context).size.height*0.25,
                      width: MediaQuery.of(context).size.width*0.9,
                      child:  Center(
                        child: Text(
                          "SetUp Timer For R$ScheduleNo",
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                          textAlign: TextAlign.center,
                          softWrap: false,
                        )  ,
                      )
                    ),
                  )
                ),
              ],
            );
    } 
}