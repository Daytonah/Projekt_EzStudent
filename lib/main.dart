import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projekt_aplikacje_mobilne/pages/calendar.dart';
import 'package:projekt_aplikacje_mobilne/pages/camera.dart';
import 'package:projekt_aplikacje_mobilne/pages/info.dart';
import 'package:projekt_aplikacje_mobilne/pages/plan.dart';
import 'package:projekt_aplikacje_mobilne/pages/play.dart';
import 'package:projekt_aplikacje_mobilne/pages/timer.dart';
import 'package:projekt_aplikacje_mobilne/pages/to_do_list.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:projekt_aplikacje_mobilne/pages/voice.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      locale: const Locale('pl', 'PL'),
      home: const RootPage(),
    );
  }
}

class TimeDisplay extends StatefulWidget {
  @override
  _TimeDisplayState createState() => _TimeDisplayState();
}

class _TimeDisplayState extends State<TimeDisplay> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        Future.delayed(Duration(seconds: 1), () {
          setState(() {});
        });
        return Text(DateFormat('HH:mm:ss').format(DateTime.now()),
            style: const TextStyle(
              fontSize: 70,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ));
      },
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/appbar.jpg'), fit: BoxFit.fill)),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: const Color.fromARGB(255, 40, 35, 69),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(
                height: 145,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 40, 35, 69),
                  ),
                  child: Center(
                    child: Text(
                      'Ez Student',
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: ListTile(
                  title: const Center(
                    //ignore: todo
                    //TODO: Bartosz
                    child: Text('Aparat', style: TextStyle(fontSize: 20)),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Camera()));
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: ListTile(
                  title: const Center(
                    //ignore: todo
                    //TODO: Bartosz
                    child: Text('Odtwarzacz Audio',
                        style: TextStyle(fontSize: 20)),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Play()));
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: ListTile(
                  title: const Center(
                    child: Text('Timer', style: TextStyle(fontSize: 20)),
                  ),
                  onTap: () {
                    //ignore: todo
                    //TODO: Piotr
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Countdown()));
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: ListTile(
                  title: const Center(
                    child: Text('Plan zajęć', style: TextStyle(fontSize: 20)),
                  ),
                  onTap: () {
                    //ignore: todo
                    //TODO: Piotr
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Plan()));
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: ListTile(
                  //ignore: todo
                  //TODO: Piotr
                  title: const Center(
                    child:
                        Text('Notatki głosowe', style: TextStyle(fontSize: 20)),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Recorder()));
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: ListTile(
                  title: const Center(
                    // ignore: todo
                    //TODO: Bartosz
                    child: Text('Kalendarz', style: TextStyle(fontSize: 20)),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Calendar()));
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(8),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: ListTile(
                  title: const Center(
                    // ignore: todo
                    //TODO: Bartosz
                    child: Text('Info', style: TextStyle(fontSize: 20)),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Info()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 150,
            child: Center(
              child: TimeDisplay(),
            ),
          ),
          Expanded(child: ToDoList()),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 40, 35, 69),
    );
  }
}
