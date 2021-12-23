import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ungqrcode/utility/my_constant.dart';
import 'package:ungqrcode/utility/my_dialog.dart';
import 'package:ungqrcode/widgets/show_button.dart';
import 'package:ungqrcode/widgets/show_form.dart';
import 'package:ungqrcode/widgets/show_progress.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({Key? key}) : super(key: key);

  @override
  _AddAccountState createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  final formKey = GlobalKey<FormState>();
  double? lat, lng;
  String? name, user, password, token;

  @override
  void initState() {
    super.initState();
    processGetLocation();
    findToken();
  }

  Future<void> findToken() async {
    print('## findToken Work');
    await Firebase.initializeApp().then((value) async {
      print('## Firebase Initial Success');

      FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
      token = await firebaseMessaging.getToken();
      print('## token ==> $token');
    });
  }

  Future<void> processGetLocation() async {
    bool locationServiceEnable;
    LocationPermission locationPermission;

    locationServiceEnable = await Geolocator.isLocationServiceEnabled();

    if (locationServiceEnable) {
      print('On Service Location');

      locationPermission = await Geolocator.checkPermission();
      print('locationPermission ==> $locationPermission');

      if (locationPermission == LocationPermission.denied) {
        locationPermission = await Geolocator.requestPermission();
        if (locationPermission == LocationPermission.deniedForever) {
          Geolocator.openAppSettings();
        } else {
          findLatLng();
        }
      } else {
        if (locationPermission == LocationPermission.deniedForever) {
          Geolocator.openAppSettings();
        } else {
          findLatLng();
        }
      }
    } else {
      print('Off Service Location');
      // exit(0);
      Geolocator.openLocationSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstant.primary,
        title: const Text('Add New Account'),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
          behavior: HitTestBehavior.opaque,
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                buildFormField(
                  constraints,
                  Icons.fingerprint,
                  'Name :',
                  nameValidate,
                  nameSave,
                ),
                buildFormField(
                  constraints,
                  Icons.perm_identity,
                  'User :',
                  userValidate,
                  userSave,
                ),
                buildFormField(
                  constraints,
                  Icons.lock_outline,
                  'Password :',
                  passwordValidate,
                  passwordSave,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(border: Border.all()),
                      margin: const EdgeInsets.only(top: 16),
                      width: constraints.maxWidth * 0.75,
                      height: constraints.maxWidth * 0.75,
                      // color: Colors.grey,
                      child: lat == null
                          ? const ShowProgress()
                          : GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: LatLng(lat!, lng!),
                                zoom: 16,
                              ),
                              onMapCreated: (controller) {},
                              markers: myMarkers(),
                            ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      width: constraints.maxWidth * 0.6,
                      child: ShowButton(
                          label: 'Add New Account',
                          funcButton: processAddAccount),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Set<Marker> myMarkers() {
    // ignore: prefer_collection_literals
    return <Marker>[
      Marker(
        // ignore: prefer_const_constructors
        markerId: MarkerId('id'),
        position: LatLng(lat!, lng!),
        infoWindow:
            InfoWindow(title: 'You Here', snippet: 'lat = $lat, lng = $lng'),
      ),
    ].toSet();
  }

  Future<void> processAddAccount() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      print(
          ' ## name = $name, user = $user, password = $password, \n lat = $lat, lng = $lat, \n token = $token');

      String pathCheckUser =
          'https://www.androidthai.in.th/bigc/getUserWhereUserUng.php?isAdd=true&user=$user';
      await Dio().get(pathCheckUser).then((value) async {
        print('## value checkUser ==>> $value');
        if (value.toString() == 'null') {
          //user true
          String pathInsertUser =
              'https://www.androidthai.in.th/bigc/insertUserUng.php?isAdd=true&name=$name&user=$user&password=$password&lat=$lat&lng=$lng&token=$token';
          await Dio().get(pathInsertUser).then((value) {
            if (value.toString() == 'true') {
              MyDialog(
                funcAction: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ).actionDialog(
                  context, 'Welcome to App', 'Success Add Your Account');
            } else {
              MyDialog()
                  .normalDialog(context, 'Have Problem', 'Please Try Again');
            }
          });
        } else {
          // user false
          MyDialog()
              .normalDialog(context, 'User False ?', 'Please Change User');
        }
      });
    }
  }

  Row buildFormField(
    BoxConstraints constraints,
    IconData iconData,
    String label,
    String? Function(String? string) funcValidate,
    Function(String? string) funcSave,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16),
          width: constraints.maxWidth * 0.6,
          child: ShowForm(
            label: label,
            iconData: iconData,
            formValidate: funcValidate,
            formSave: funcSave,
          ),
        ),
      ],
    );
  }

  void nameSave(String? string) => name = string;

  void userSave(String? string) => user = string;

  void passwordSave(String? string) => password = string;

  String? nameValidate(String? string) {
    if (string!.isEmpty) {
      return 'Please Fill Name';
    } else {
      return null;
    }
  }

  String? userValidate(String? string) {
    if (string!.isEmpty) {
      return 'Please Fill User';
    } else {
      return null;
    }
  }

  String? passwordValidate(String? string) {
    if (string!.isEmpty) {
      return 'Please Fill Password';
    } else {
      return null;
    }
  }

  Future<void> findLatLng() async {
    Position? position = await findPosition();
    if (position != null) {
      setState(() {
        lat = position.latitude;
        lng = position.longitude;
        print('lat = $lat, lng = $lng');
      });
    }
  }

  Future<Position?> findPosition() async {
    try {
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      return null;
    }
  }
}
