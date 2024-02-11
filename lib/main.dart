import 'package:flutter/material.dart';
import 'package:timmer/timer_module_list.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(home: const MainApp()));
}


class MainApp extends StatefulWidget {
  const MainApp({super.key});
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const ListOfModules();
        
      }));
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Card(
            elevation: 10,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage("assets/images/Logo.png"),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.center,
                ),
              ),
              alignment: Alignment.center,
            ),
          );
    }
  }