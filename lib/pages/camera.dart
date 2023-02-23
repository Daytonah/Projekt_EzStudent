import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:projekt_aplikacje_mobilne/pages/calendar.dart';
import 'package:projekt_aplikacje_mobilne/pages/to_do_list.dart';
import 'package:projekt_aplikacje_mobilne/pages/timer.dart';
import 'package:projekt_aplikacje_mobilne/pages/voice.dart';

class Camera extends StatefulWidget {
  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  GlobalKey _globalKey = GlobalKey();
  File? image;

  @override
  void initState() {
    super.initState();

    _requestPermission();
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      debugPrint('Nie udana próba załączenia: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      debugPrint('Nie udana próba załączenia: $e');
    }
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      color: Colors.white,
                      height: 60.0,
                      minWidth: 200.0,
                      child: const Text(
                        "Wybierz obraz z Galerii",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        pickImage();
                      },
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      color: Colors.white,
                      height: 60.0,
                      minWidth: 200.0,
                      child: const Text(
                        "Zrób zdjęcie",
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        pickImageC();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                key: _globalKey,
                height: 20,
              ),
              image != null
                  ? Image.file(image!)
                  : const Text(
                      "Nie wybrano zdjęcia",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
              Container(
                padding: const EdgeInsets.only(top: 15),
                width: 300,
                height: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Material(
                    color: Colors.white,
                    child: TextButton(
                      onPressed: _saveScreen,
                      style: TextButton.styleFrom(
                          foregroundColor: Color.fromARGB(255, 0, 0, 0)),
                      child: const Text("Zapisz plik"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 40, 35, 69),
    );
  }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    debugPrint(info);
    _toastInfo(info);
  }

  _saveScreen() async {
    if (image == null) {
      _toastInfo("Nie wybrano zdjęcia");
      return;
    }

    final result = await ImageGallerySaver.saveImage(image!.readAsBytesSync());
    _toastInfo(result.toString());
  }

  _toastInfo(String info) {
    Fluttertoast.showToast(msg: info, toastLength: Toast.LENGTH_LONG);
  }
}
