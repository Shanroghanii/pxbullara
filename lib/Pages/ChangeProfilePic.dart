import 'package:ar_live_ais/Pages/HomePage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'EditProfile.dart';
import 'dart:convert';
import 'dart:io';


class ChangeProfilePic extends StatefulWidget {
  @override
  _ChangeProfilePicState createState() => _ChangeProfilePicState();
}

class _ChangeProfilePicState extends State<ChangeProfilePic> {

  String error;

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('jwttoken');
    changeAvatar(stringValue);
  }

  Future<void> changeAvatar(String token) async {
    var dio = Dio();

    var formData = FormData.fromMap({
      'avatar': await MultipartFile.fromFile(_image.path,filename: _image.path),
    });
    final respond = dio.post('https://api-stg.authority.wittytech.live/v1/uploads/avatar', data: formData, options: Options(
        method: 'POST',
        contentType: 'multipart/form-data',
        headers: <String, String>{
          'Content-Type': 'multipart/form-data',
          'Authorization': 'Bearer $token',
        },
        responseType: ResponseType.json // or ResponseType.JSON
    ))
        .then(
            (response) {
          print(response.toString());
          if (response.statusCode == 200) {
            final parsed = jsonDecode(response.toString());

            // print(otpToken);
            // Fluttertoast.showToast(
            //     msg: "Avatar Updated",
            //     toastLength: Toast.LENGTH_SHORT,
            //     gravity: ToastGravity.BOTTOM,
            //     timeInSecForIosWeb: 1,
            //     backgroundColor: Colors.red,
            //     textColor: Colors.white,
            //     fontSize: 16.0);
            Toast.show("Avatar Updated", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage()),
            );
          } else {
            // If the server did not return a 201 CREATED response,
            // then throw an exception.
            final parsed = jsonDecode(response.toString());
            error = parsed['message'];
            Toast.show("$error", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

            // Fluttertoast.showToast(
            //     msg: "$error",
            //     toastLength: Toast.LENGTH_SHORT,
            //     gravity: ToastGravity.BOTTOM,
            //     timeInSecForIosWeb: 1,
            //     backgroundColor: Colors.red,
            //     textColor: Colors.white,
            //     fontSize: 16.0);
            throw Exception('Failed to create album.');
          }
        })
        .catchError((error) => print("error"+error.toString()));

  }


  File _image;
  final picker = ImagePicker();

  Future _imgFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  _imgFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0D0D0D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfile()),
              );
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Change Profile Avatar',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 60,
          ),

          Stack(
            children: [
              _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(144),
                      child: Image.file(
                        _image,
                        width: 160,
                        height: 160,
                        fit: BoxFit.fill,
                      ),
                    )
                  : Container(
                      height: 160,
                      width: 160,
                      decoration: BoxDecoration(
                        color: Color(0xff2a2a2a),
                        borderRadius: BorderRadius.circular(144),
                      ),
                      child: Center(
                          child: FaIcon(
                        FontAwesomeIcons.user,
                        size: 70,
                        color: Colors.grey[300],
                      )),
                    ),

              Positioned(
                top: 120,
                left: 120,
                child: GestureDetector(
                  onTap: () {
                    _showPicker(context);
                  },
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      'assets/cam.png',
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: (){
             getToken();
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0,left: 22,right: 22),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color:Colors.green,

                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text('Change Profile Picture',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w600),),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
