import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:timmer/SetTimer.dart';
import 'package:timmer/ApiCallsToTimer.dart';

class SetTimer extends StatefulWidget{
  final int ScheduleCount;
  final List <String> Schedule_dets; 
  const SetTimer({Key? key, required this.ScheduleCount, required this.Schedule_dets}) : super(key: key);

  @override
  State<SetTimer> createState() => _SetTimer(ScheduleCount: ScheduleCount, Schedule_dets: Schedule_dets);
}


class _SetTimer extends State<SetTimer>{

  _SetTimer({required this.ScheduleCount, required this.Schedule_dets});
  int ScheduleCount;
  final List <String> Schedule_dets;

  int ScheduleLimits = 150;

  @override
  void initState() {
    super.initState();
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Schedule Limit"),
      content: Text("Can't create more Schedules. Schedule Limit Reached"),
      actions: [
        okButton,
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
  Widget build(BuildContext context){
    return MaterialApp(
            theme: ThemeData(
              colorScheme: const ColorScheme(
                brightness: Brightness.light,
                primary: Color.fromARGB(255, 30, 180, 164),
                onPrimary: Colors.black,
                // Colors that are not relevant to AppBar in LIGHT mode:
                //primaryVariant: Colors.grey,
                secondary: Colors.grey,
                //secondaryVariant: Colors.grey,
                onSecondary: Colors.grey,
                background: Colors.white,
                onBackground: Colors.white,
                surface: Color.fromARGB(255, 30, 180, 164),
                onSurface: Colors.grey,
                error: Colors.grey,
                onError: Colors.grey,
              ),
            ),
            home: Scaffold(
              appBar: AppBar(
                title: Image.asset('assets/images/AppBAR_Logo.jpg', height: 50,),

              ),
              body: /*ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: ScheduleCount,
                itemBuilder: (BuildContext context, int index) {
                  return SelectTimer((index+1).toString(),Schedule_dets);
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(),
              ),*/
              Container(
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top:10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("${ScheduleLimits-ScheduleCount} Schedules more can be created",style: TextStyle(fontSize: 18,color: Colors.black),)
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top:35),
                      child: ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemCount: ScheduleCount,
                        itemBuilder: (BuildContext context, int index) {
                          return SelectTimer((index+1).toString(),Schedule_dets);
                        },
                        separatorBuilder: (BuildContext context, int index) => const Divider(),
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: (){
                  if(ScheduleLimits-ScheduleCount > 0) {
                    ApiCallsToTimer().ScheduleDetails("A").then((value) {
                      List<String> Payload = value.split(";");
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) {
                        return CreateSchedules(ScheduleNo: "A",
                            T_Start_hr: Payload[0].split(":")[0],
                            T_Start_min: Payload[0].split(":")[1],
                            T_End_hr: Payload[1].split(":")[0],
                            T_End_min: Payload[1].split(":")[1],
                            Checks: Payload[2].split(","),
                            Relays: Payload[3].split(","));
                      }));
                    });
                  }
                  else{
                    showAlertDialog(context);
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text("Add Schedules",textAlign: TextAlign.center,),
                elevation: 12,
                backgroundColor: Color.fromARGB(116, 61, 201, 96),
                foregroundColor: Colors.white

              )
            )
          );
    }
}


class SelectTimer extends StatelessWidget { 

  SelectTimer(this.ScheduleNo, this.Schedule_dets);

  final String ScheduleNo;
  final List <String> Schedule_dets;

  @override 
  Widget build(BuildContext context){ 
    return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child:  GestureDetector(
                    onTap: (){
                      ApiCallsToTimer().ScheduleDetails(ScheduleNo.toString()).then((value) {
                      List<String> Payload = value.split(";");

                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return CreateSchedules(ScheduleNo: ScheduleNo,T_Start_hr: Payload[0].split(":")[0],T_Start_min: Payload[0].split(":")[1],T_End_hr: Payload[1].split(":")[0],T_End_min: Payload[1].split(":")[1],Checks: Payload[2].split(","),Relays: Payload[3].split(","));
                      }));
                    });
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 30, 180, 164),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width*0.9,
                      child:  Center(
                        child: Text(
                          //"Schedule $ScheduleNo",
                          "\n${ Schedule_dets[int.parse(ScheduleNo)-1].split(";")[0] } ${ Schedule_dets[int.parse(ScheduleNo)-1].split(";")[1] } To ${ Schedule_dets[int.parse(ScheduleNo)-1].split(";")[2] } ${ Schedule_dets[int.parse(ScheduleNo)-1].split(";")[3] } \n",
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