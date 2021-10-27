import 'dart:convert';
import 'package:ar_live_ais/Pages/BannerPage.dart';
import 'package:ar_live_ais/Pages/LoginOTP.dart';
import 'package:ar_live_ais/Pages/resetPassward.dart';
import 'package:ar_live_ais/main.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/services.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'package:ar_live_ais/Pages/OtpPage.dart';
import 'package:ar_live_ais/Pages/RegisterPage.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class ForgotPassward extends StatefulWidget {
  @override
  _ForgotPasswardState createState() => _ForgotPasswardState();
}

class _ForgotPasswardState extends State<ForgotPassward> {
  final _formKey = GlobalKey<FormState>();
  String otpToken;
  String phone;
  String error;
  bool isThai = false;
  bool checkedValue = false;
  bool isEnabled = false;

  bool isPhone = true;

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();

  String validateMobile(String value) {
    String patttern = r'(^(?:[+]66)?[0-9]{8,10}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null)
      return 'Enter a valid email address';
    else
      return null;
  }

  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    emailEditingController.dispose();
    phoneEditingController.dispose();

    super.dispose();
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: h * 0.045,
                ),

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

                Image.asset(
                  'assets/ar.png',
                  height: h * 0.27,
                  width: w * 0.5,
                  fit: BoxFit.fill,
                ),
                // SizedBox(height: h*0.07,),
                Text(
                  'Forgot Passward',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 24),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Enter Email or Phone',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                      fontSize: 16),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (isPhone == true) {
                          setState(() {
                            isPhone = false;
                          });
                        } else {
                          setState(() {
                            isPhone = true;
                          });
                        }
                      },
                      child: Container(
                        height: h * 0.054,
                        width: w * 0.22,
                        decoration: BoxDecoration(
                          color: isPhone ? Colors.grey[800] : Color(0xff0D0D0D),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            'Phone',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (isPhone == false) {
                          setState(() {
                            isPhone = true;
                          });
                        } else {
                          setState(() {
                            isPhone = false;
                          });
                        }
                      },
                      child: Container(
                        height: h * 0.054,
                        width: w * 0.22,
                        decoration: BoxDecoration(
                          color: isPhone ? Color(0xff0D0D0D) : Colors.grey[800],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            'Email',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  indent: 50,
                  endIndent: 50,
                  color: Colors.grey,
                ),

                isPhone
                    ? Padding(
                        padding: const EdgeInsets.only(
                            top: 12.0, left: 22, right: 22),
                        child: Container(
                          height: h * 0.08,
                          child: TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: phoneEditingController,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  fillColor: Color(0x29FFFFFF),
                                  prefixIcon: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Text(
                                        '+66',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14.0),
                                      borderSide: new BorderSide(
                                          color: Color(0x29FFFFFF))),
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
                                  labelText: 'Phone*',
                                  labelStyle: TextStyle(color: Colors.white)),
                              validator: validateMobile),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                            top: 12.0, left: 22, right: 22),
                        child: Container(
                          height: h * 0.08,
                          child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: emailEditingController,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  fillColor: Color(0x29FFFFFF),
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14.0),
                                      borderSide: new BorderSide(
                                          color: Color(0x29FFFFFF))),
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
                                  labelText: 'Email*',
                                  labelStyle: TextStyle(color: Colors.white)),
                              validator: validateEmail),
                        ),
                      ),

                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResetPasswardPage()),
                      );
                    }
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 12.0, left: 22, right: 22),
                    child: Container(
                      height: h * 0.08,
                      decoration: BoxDecoration(
                        color: isEnabled ? Colors.green : Color(0xff9D9D9D),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          'Submit',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyHomePage()),
                        );
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff6EC350),
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    Text(
                      ' or ',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()),
                        );
                      },
                      child: Text(
                        ' Register',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color(0xff6EC350),
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Album {
  final String email;
  final String password;
  final String telephone;

  Album({this.email, this.password, this.telephone});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      email: json['email'],
      password: json['password'],
      telephone: json['telephone'],
    );
  }
}
