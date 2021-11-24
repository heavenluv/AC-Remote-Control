// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:remote_control/class/room_data.dart';
import 'package:remote_control/class/remote_data.dart';

class ActionPage extends StatelessWidget {
  // ignore: non_constant_identifier_names
  const ActionPage({Key? key, required this.roomInfo, required this.AcInfo})
      : super(key: key);
  final RoomData roomInfo;
  final RemoteData AcInfo;
  @override
  Widget build(BuildContext context) {
    return RemoteChoice(
      title: 'Controller',
      roomInfo: roomInfo,
      AcInfo: AcInfo,
    );
  }
}

class RemoteChoice extends StatefulWidget {
  const RemoteChoice(
      {Key? key,
      required this.title,
      required this.roomInfo,
      required this.AcInfo})
      : super(key: key);
  final String title;
  final RoomData roomInfo;
  final RemoteData AcInfo;

  @override
  _RemoteChoiceState createState() => _RemoteChoiceState();
}

class _RemoteChoiceState extends State<RemoteChoice> {
  late RoomData _room;
  late RemoteData _remote;

  @override
  void initState() {
    super.initState();
    _room = widget.roomInfo;
    _remote = widget.AcInfo;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
            style:
                const TextStyle(fontWeight: FontWeight.normal, fontSize: 50)),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Ink(
                    width: 180.0,
                    height: 180.0,
                    decoration: const ShapeDecoration(
                      color: Colors.red,
                      shape: CircleBorder(),
                    ),
                    child: InkWell(
                      child: IconButton(
                        onPressed: () async {
                          EasyLoading.show();
                          //  You enter here what you want the button to do once the user interacts with it
                          await TurnOffAC();
                          EasyLoading.dismiss();
                          Navigator.pop(context);
                        },
                        tooltip: 'Turn off the AC',
                        icon: const Icon(
                          Icons.power_settings_new,
                          color: Colors.white,
                        ),
                        iconSize: 100.0,
                      ),
                      onTap: () {}, // needed
                      splashColor: Colors.blue,
                    ),
                  ),
                  Text(
                    '${_remote.celcius_degree}°C',
                    style: const TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Highspeed',
                    ),
                  ),
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                getRoomTemperature(room: _room),
                getRoomHumidity(room: _room),
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Column(
                  children: [
                    Ink(
                      width: 120.0,
                      height: 120.0,
                      decoration: const ShapeDecoration(
                        color: Colors.blueAccent,
                        shape: BeveledRectangleBorder(),
                      ),
                      child: InkWell(
                        child: IconButton(
                          onPressed: () async {
                            EasyLoading.show();
                            //  You enter here what you want the button to do once the user interacts with it
                            RemoteData temp = await IncreaseTempAC();

                            setState(() {
                              _remote = temp;
                            });
                            EasyLoading.dismiss();
                          },
                          tooltip: 'Increase the temperature',
                          icon: const Icon(
                            Icons.add_circle_outline,
                            color: Colors.white,
                          ),
                          iconSize: 80.0,
                        ),
                        onTap: () {}, // needed
                        splashColor: Colors.blue,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Ink(
                      width: 120.0,
                      height: 120.0,
                      decoration: const ShapeDecoration(
                        color: Colors.lightBlue,
                        shape: BeveledRectangleBorder(),
                      ),
                      child: InkWell(
                        child: IconButton(
                          onPressed: () async {
                            //  You enter here what you want the button to do once the user interacts with it
                            EasyLoading.show();
                            RemoteData temp = await LowerTempAC();
                            setState(() {
                              _remote = temp;
                            });
                            EasyLoading.dismiss();
                          },
                          tooltip: 'Lower the Temperature',
                          icon: const Icon(
                            Icons.remove_circle_outline,
                            color: Colors.white,
                          ),
                          iconSize: 80.0,
                        ),
                        onTap: () {}, // needed
                        splashColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ])
            ]),
      ),
    );
  }
}

class getRoomHumidity extends StatelessWidget {
  const getRoomHumidity({
    Key? key,
    required RoomData room,
  })  : _room = room,
        super(key: key);

  final RoomData _room;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Room \nHumidity",
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontFamily: 'Agne', fontSize: 20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Ink(
              width: 80.0,
              height: 80.0,
              decoration: const ShapeDecoration(
                color: Colors.tealAccent,
                shape: CircleBorder(),
              ),
              child: InkWell(
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.storm, color: Colors.white),
                  iconSize: 60.0,
                ),
                onTap: () {}, // needed
                splashColor: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '${_room.humidity}%',
                style: const TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Highspeed',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class getRoomTemperature extends StatelessWidget {
  const getRoomTemperature({
    Key? key,
    required RoomData room,
  })  : _room = room,
        super(key: key);

  final RoomData _room;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Room \nTemperature",
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontFamily: 'Agne', fontSize: 20),
        ),
        Row(
          children: [
            Ink(
              width: 80.0,
              height: 80.0,
              decoration: const ShapeDecoration(
                color: Colors.amber,
                shape: CircleBorder(),
              ),
              child: InkWell(
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.thermostat, color: Colors.white),
                  iconSize: 60.0,
                ),
                onTap: () {}, // needed
                splashColor: Colors.blue,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                '${_room.temperature}°C',
                style: const TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Highspeed',
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
