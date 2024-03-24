import 'package:flutter/material.dart';
import 'package:timmer/ApiCallsToTimer.dart';
import 'package:timmer/SetTimerOpts.dart';

class ListOfModules extends StatefulWidget{
  const ListOfModules({super.key});

  @override
  State<ListOfModules> createState() => _ListOfModulesState();
}


class _ListOfModulesState extends State<ListOfModules>{

  @override
  void initState() {
    super.initState();
  }


   void _fetchData(BuildContext context, String PopUpType) async {
    if (PopUpType == 'loading'){
    // show the loading dialog
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) {
            return const Dialog(
              backgroundColor: Colors.white,
              child: Padding(
                padding:  EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:  [
                    // The loading indicator
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 15,
                    ),
                    // Some text
                    Text('Connecting to Device...')
                  ],
                ),
              ),
            );
          });

      
      ApiCallsToTimer().connectionStatus('192.168.1.1').then((value) {
          if (value.toLowerCase() == 'connected to server'){
            ApiCallsToTimer().ScheduleCount('192.168.1.1').then((value1) {
              int deviceCount = 0;
              List <String> payload = value1.split(",");
              deviceCount = payload.length;
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SetTimer(ScheduleCount: deviceCount, Schedule_dets:payload);
              }));
            });
          }
          else{
            Navigator.of(context).pop();
            _fetchData(context,'error');
          }
          print(value);
        }
      ).onError((error, stackTrace) {
        print("Unable to connect");
        Navigator.of(context).pop();
        _fetchData(context,'error');
      });
    }
    else{
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) {
            return Dialog(
              backgroundColor: Colors.white,
              child: Padding(
                padding:  const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children:  [
                    const Row(
                      children: <Widget>[
                        Text('Unable to Connect Device'),
                      ]
                    ),
                    const Row(
                      children: <Widget>[
                        Text('Please Check your WiFI Connection'),
                      ]
                    ),
                    Row(
                      children: <Widget>[
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Close",style: TextStyle(color: Colors.black,),)
                        )
                      ]
                    )
                  ],
                ),
              ),
            );
          });
    }

  }


  @override
  Widget build(BuildContext context){
    double c_width = MediaQuery.of(context).size.width*0.9;
    double c_height = MediaQuery.of(context).size.height*0.25; 
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child:  GestureDetector(
                            onTap: (){
                              _fetchData(context,'loading');
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
                              height: c_height,
                              width: c_width,
                              child: const Center(
                                child: Text(
                                  "Connect to Device",
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                                  textAlign: TextAlign.center,
                                  softWrap: false,
                                )  ,
                              )
                            ),
                          )
                        ),
                      ],
                    ),
                  ],
                )
            )
          );
    }
}

