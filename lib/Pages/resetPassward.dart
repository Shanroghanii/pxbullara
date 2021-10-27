import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'OtpPage.dart';
import 'package:dio/dio.dart';

class ResetPasswardPage extends StatefulWidget {
  @override
  _ResetPasswardPageState createState() => _ResetPasswardPageState();
}

class _ResetPasswardPageState extends State<ResetPasswardPage> {
  final _formKey = GlobalKey<FormState>();
  bool isThai = false;
  String otpToken;
  String phone;

  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  String validatePassword(String value) {
    Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regex = RegExp(pattern);
    print(value);
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value))
        return 'Enter valid password';
      else
        return null;
    }
  }

  String confirmPassword(String value) {
    Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regex = RegExp(pattern);
    print(value);
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value) || passController.text != value)
        return 'password is not matching';
      else
        return null;
    }
  }

  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // phoneController.text = '+66804548452';
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xff0D0D0D),
        image: DecorationImage(
          image: AssetImage('assets/bak.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: h * 0.045,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    )),
                GestureDetector(
                  onTap: () {
                    if (isThai == true) {
                      setState(() {
                        isThai = false;
                      });
                    } else {
                      setState(() {
                        isThai = true;
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: isThai
                            ? Image.asset('assets/off.png')
                            : Image.asset('assets/on.png')),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Image.asset(
              'assets/ar.png',
              height: h * 0.27,
              width: w * 0.5,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Reset passward',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Enter new passward',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w200,
                  color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 12.0, left: 22, right: 22),
                    child: Container(
                      height: h * 0.08,
                      child: TextFormField(
                          controller: passController,
                          obscureText: true,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              fillColor: Color(0x29FFFFFF),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(14.0),
                                  borderSide:
                                      new BorderSide(color: Color(0x29FFFFFF))),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide(
                                    color: Color(0x29FFFFFF), width: 0.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide(
                                    color: Color(0x29FFFFFF), width: 0.0),
                              ),
                              labelText: 'Enter new passward*',
                              labelStyle: TextStyle(color: Colors.white)),
                          validator: validatePassword),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 12.0, left: 22, right: 22),
                    child: Container(
                      height: h * 0.08,
                      child: TextFormField(
                        controller: confirmPassController,
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            fillColor: Color(0x29FFFFFF),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14.0),
                                borderSide:
                                    new BorderSide(color: Color(0x29FFFFFF))),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                  color: Color(0x29FFFFFF), width: 0.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                  color: Color(0x29FFFFFF), width: 0.0),
                            ),
                            labelText: 'Confirm Password*',
                            labelStyle: TextStyle(color: Colors.white)),
                        validator: confirmPassword,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (_formKey.currentState.validate() &&
                    passController.text == confirmPassController.text) {
                  // function
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 22, right: 22),
                child: Container(
                  height: h * 0.08,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    ));
  }
}

class Album {
  final String password;

  Album({
    this.password,
  });

  factory Album.fromJson(Map<String, String> json) {
    return Album(
      password: json['password'],
    );
  }
}
