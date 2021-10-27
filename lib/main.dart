import 'dart:convert';

import 'package:ar_live_ais/Pages/HomePage.dart';
import 'package:ar_live_ais/Pages/RegisterPage.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

import 'Pages/LoginOTP.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final plugin = FacebookLogin(debug: true);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AR LIVE_AIS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String otpToken;
  String phone;
  String error;
  bool isThai = false;
  bool checkedValue = false;
  bool isEnabled = false;

  bool isPhone = true;

  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passEditingController = TextEditingController();
  TextEditingController phoneEditingController = TextEditingController();

  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    emailEditingController.dispose();
    passEditingController.dispose();
    phoneEditingController.dispose();

    super.dispose();
  }

  Future<Album> login() async {
    final response = await http.post(
      Uri.parse('https://api-stg.authority.wittytech.live/v1/login'),
      headers: <String, String>{
        'accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: isPhone
          ? jsonEncode(<String, String>{
              'password': passEditingController.text,
              'telephone': "+92" + phoneEditingController.text
            })
          : jsonEncode(<String, String>{
              'email': emailEditingController.text,
              'password': passEditingController.text,
            }),
    );
    print(response.body);

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      otpToken = parsed['payload']['pre_login']['otp_token'];
      phone = parsed['payload']['pre_login']['otp_telephone'];
      Toast.show("Success", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      // Fluttertoast.showToast(
      //     msg: "Success",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0
      // );
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginOtp(
                  otpToken: otpToken,
                  phone: phone,
                )),
      );
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      final parsed = jsonDecode(response.body);
      error = parsed['message'];
      Toast.show("$error", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.WARNING,
        body: Center(
          child: Text(
            'Password or Email/Phone Incorrect!.',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        title: 'Login',
        desc: 'User Authenticatio not valid!',
        btnOkOnPress: () {},
      )..show();

      // Fluttertoast.showToast(
      //     msg: "$error",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0
      // );
      // throw Exception('Failed to create album.');
    }
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
              'Login',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 24),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Log in with Email or Phone',
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
                            color: Colors.white, fontWeight: FontWeight.w600),
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
                            color: Colors.white, fontWeight: FontWeight.w600),
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
                    padding:
                        const EdgeInsets.only(top: 12.0, left: 22, right: 22),
                    child: Container(
                      height: h * 0.08,
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
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
                            labelText: 'Phone*',
                            labelStyle: TextStyle(color: Colors.white)),
                      ),
                    ),
                  )
                : Padding(
                    padding:
                        const EdgeInsets.only(top: 12.0, left: 22, right: 22),
                    child: Container(
                      height: h * 0.08,
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailEditingController,
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
                            labelText: 'Email*',
                            labelStyle: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),

            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 22, right: 22),
              child: Container(
                height: h * 0.08,
                child: TextField(
                  controller: passEditingController,
                  onChanged: (val) {
                    setState(() {
                      isEnabled = true;
                    });
                  },
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                  decoration: InputDecoration(
                      fillColor: Color(0x29FFFFFF),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14.0),
                          borderSide: new BorderSide(color: Color(0x29FFFFFF))),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide:
                            BorderSide(color: Color(0x29FFFFFF), width: 0.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide:
                            BorderSide(color: Color(0x29FFFFFF), width: 0.0),
                      ),
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            Theme(
              data: ThemeData(unselectedWidgetColor: Colors.white),
              child: CheckboxListTile(
                title: Text(
                  "remember me",
                  style: TextStyle(color: Colors.white),
                ),
                value: checkedValue,
                activeColor: Colors.grey,
                onChanged: (newValue) {
                  setState(() {
                    checkedValue = newValue;
                  });
                },
                controlAffinity:
                    ListTileControlAffinity.leading, //  <-- leading Checkbox
              ),
            ),
            GestureDetector(
              onTap: () {
                login();
                // Navigator.push()
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => HomePage()),
                // );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0, left: 22, right: 22),
                child: Container(
                  height: h * 0.08,
                  decoration: BoxDecoration(
                    color: isEnabled ? Colors.green : Color(0xff9D9D9D),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      'Login',
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
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: Text(
                    'Register',
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
                Text(
                  ' forgot password',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Color(0xff6EC350),
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
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
