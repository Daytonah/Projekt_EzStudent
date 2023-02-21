import 'package:flutter/material.dart';

import '../main.dart';
import 'package:projekt_aplikacje_mobilne/pages/play.dart';
import 'package:projekt_aplikacje_mobilne/pages/calendar.dart';
import 'package:projekt_aplikacje_mobilne/pages/camera.dart';
import 'package:projekt_aplikacje_mobilne/pages/to_do_list.dart';
import 'package:projekt_aplikacje_mobilne/pages/timer.dart';

class Course {
  final String name;
  final String day;

  Course(this.name, this.day);
}

class Plan extends StatefulWidget {
  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<Plan> {
  final courseNameController = TextEditingController();
  String? _selectedDay = null;
  List<Course> courses = [];

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    courseNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plan zajęć'),
        toolbarHeight: 100,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/appbar.jpg'), fit: BoxFit.fill)),
        ),
      ),
      endDrawer: Drawer(
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
                    child: Text('Odtwarzacz audio', style: TextStyle(fontSize: 20)),
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
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 40, 35, 69),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                  style: TextStyle(
                    color: Color.fromARGB(255, 187, 211, 231)
                  ),
                    controller: courseNameController,
                    decoration: InputDecoration(labelText: 'Godzina oraz \nnazwa przedmiotu',
                    labelStyle: TextStyle(
                     color: Color.fromARGB(255, 187, 211, 231),
                    ),
                    focusColor: Colors.grey[200],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
                  ),
                ),
                SizedBox(width: 16.0),
                DropdownButton<String>(
                  value: _selectedDay,
                  hint: Text('Dzień tygodnia',
                  style: TextStyle(
                    color: Color.fromARGB(255, 187, 211, 231)
                  )),
                  onChanged: (value) {
                    setState(() {
                      _selectedDay = value;
                    });
                  },
                  dropdownColor: const Color.fromARGB(255, 40, 35, 69),
                  items: [
                    DropdownMenuItem(value: 'Poniedziałek', child: Text('Poniedziałek',
                  style: TextStyle(
                    color: Color.fromARGB(255, 187, 211, 231)
                  ))),
                    DropdownMenuItem(value: 'Wtorek', child: Text('Wtorek',
                  style: TextStyle(
                    color: Color.fromARGB(255, 187, 211, 231)
                  ))),
                    DropdownMenuItem(value: 'Środa', child: Text('Środa',
                  style: TextStyle(
                    color: Color.fromARGB(255, 187, 211, 231)
                  ))),
                    DropdownMenuItem(value: 'Czwartek', child: Text('Czwartek',
                  style: TextStyle(
                    color: Color.fromARGB(255, 187, 211, 231)
                  ))),
                    DropdownMenuItem(value: 'Piątek', child: Text('Piątek',
                  style: TextStyle(
                    color: Color.fromARGB(255, 187, 211, 231)
                  ))),
                  ],
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    final name = courseNameController.text;
                    final day = _selectedDay;
                    setState(() {
                      courses.add(Course(name, day!));
                    });
                    courseNameController.clear();
                    _selectedDay = null;
                  },
                  child: Text('Dodaj'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return ListTile(
                  title: Text(course.name,
                  style: TextStyle(
                    color: Color.fromARGB(255, 187, 211, 231)
                  )),
                  subtitle: Text(course.day,
                  style: TextStyle(
                    color: Color.fromARGB(255, 187, 211, 231)
                  )),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        courses.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Plan(), // Use the ScheduleScreen widget here
    );
  }
}