import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:projekt_aplikacje_mobilne/util/calendar_utils.dart';
import 'package:projekt_aplikacje_mobilne/pages/camera.dart';
import 'package:projekt_aplikacje_mobilne/pages/timer.dart';
import 'package:projekt_aplikacje_mobilne/pages/voice.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List> _events = {};

  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getSavedEvents();
  }

  void _getSavedEvents() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> eventsMap =
        prefs.getKeys().fold({}, (Map<String, String> acc, String key) {
      if (DateTime.tryParse(key) != null) {
        acc[key] = prefs.getString(key) ?? '';
      }
      return acc;
    });
    Map<DateTime, List> newEvents = {};
    eventsMap.forEach((key, value) {
      newEvents[DateTime.parse(key)] = value.split(',');
    });
    setState(() {
      _events = newEvents;
    });
  }

  void _addEvent() async {
    setState(() {
      if (_events[_selectedDay] != null) {
        _events[_selectedDay]!.add(_eventController.text);
      } else {
        _events[_selectedDay!] = [_eventController.text];
      }
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString(
            _selectedDay.toString(), _events[_selectedDay]!.join(','));
      });
    });

    _eventController.clear();
  }

  void _deleteEvent(String event) async {
    setState(() {
      _events[_selectedDay]!.remove(event);

      if (_events[_selectedDay]!.isEmpty) {
        _events.remove(_selectedDay);
        SharedPreferences.getInstance().then((prefs) {
          prefs.remove(_selectedDay.toString());
        });
      } else {
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString(
              _selectedDay.toString(), _events[_selectedDay]!.join(','));
        });
      }
    });
  }

  void _showAddEventDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Dodaj wydarzenie"),
          content: TextField(
            controller: _eventController,
            decoration: InputDecoration(
              hintText: "Nazwa wydarzenia",
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Anuluj"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Dodaj"),
              onPressed: () {
                _addEvent();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

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
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            eventLoader: (day) {
              return _events[day] ?? [];
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            startingDayOfWeek: StartingDayOfWeek.monday,
          ),
          SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.all(16.0),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: _getEvents(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEventDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  List<Widget> _getEvents() {
    List<Widget> eventWidgets = [];

    for (var entry in _events.entries) {
      var day = entry.key;
      var events = entry.value;
      if (events != null) {
        for (String event in events) {
          eventWidgets.add(
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: InkWell(
                onTap: () {
                  // TODO: add event details screen
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      '${DateFormat('yyyy-MM-dd').format(day)} - $event',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () => _deleteEvent(event),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      }
    }

    if (eventWidgets.isEmpty) {
      eventWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text('Brak wydarzeń'),
        ),
      );
    }

    return eventWidgets;
  }
}
