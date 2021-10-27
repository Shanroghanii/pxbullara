import 'dart:async';
import 'dart:convert';

import 'package:ar_live_ais/Pages/BannerPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'HomePage.dart';

class LoginOtp extends StatefulWidget {
  String otpToken;
  String phone;
  LoginOtp({this.otpToken,this.phone});

  @override
  _LoginOtpState createState() => _LoginOtpState(otpToken: this.otpToken,phone: phone);
}

class _LoginOtpState extends State<LoginOtp> {

  String otpToken;
  String phone;
  String jwt_token;
  _LoginOtpState({this.otpToken,this.phone});

  bool isEnabled=false;

  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  bool resendOTP=false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String banner_image;
  String banner_url;
  bool has_banner;
  String url;
  String protocol;


  CountdownTimerController controller;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;

  void onEnd() {
    print('onEnd');
    setState(() {
      resendOTP=true;
    });
  }

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);

    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
  }

  resendOTPFunc() async {
    final response = await http.post(
      Uri.parse('https://api-stg.authority.wittytech.live/v1/otp/resend'),
      headers: <String, String>{
        'accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'otp_token': '$otpToken',
      }),
    );
    print(response.body);

    if (response.statusCode == 200)
    {
      Toast.show("OTP RESENT", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

      // Fluttertoast.showToast(
      //     msg: "OTP RESENT",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0
      // );
      setState(() {
        resendOTP=false;
      });

    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      Toast.show("Error", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

      // Fluttertoast.showToast(
      //     msg: "Error",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0
      // );
      throw Exception('Failed to create album.');
    }
  }


  Future<void> addJWTToken(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('jwttoken', "$val");
    print('================== JWT Token Saved');
  }

  @override
  void dispose()
  {
    errorController.close();
    controller.dispose();
    super.dispose();
  }

  getImage(String token) async {
    var url=Uri.parse('https://api-stg.authority.wittytech.live/v1/user-info');
    final response = await http.get(url, headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(response.body);

    if (response.statusCode == 200)
    {
      final parsed = jsonDecode(response.body);
      has_banner=parsed['payload']['banner']['has_banner'];
      if(has_banner==true){
        Toast.show("Show Banner", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

        // Fluttertoast.showToast(
        //     msg: "Show Banner",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.BOTTOM,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.red,
        //     textColor: Colors.white,
        //     fontSize: 16.0
        // );
        setState(() {
          banner_image=parsed['payload']['banner']['banner_image'];
          banner_url=parsed['payload']['banner']['banner_url'];
          protocol=parsed['payload']['websocket']['protocol'];
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BannerPage(jwt_Token: banner_image,banner_url: banner_url,url: 'url',protocol: protocol,)),
        );
      }
      else{
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } else {
      // Fluttertoast.showToast(
      //     msg: "Error",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.CENTER,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0
      // );
      Toast.show("Error", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

      throw Exception('Failed to create album.');
    }
  }

  Future<Album> confirmOTP() async {

    print('**********************$currentText');

    final response = await http.post(
      Uri.parse('https://api-stg.authority.wittytech.live/v1/otp/confirm'),
      headers: <String, String>{
        'accept': 'application/json',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, String>{
        'digits': '$currentText',
        'otp_token': '$otpToken',
      }),
    );
    print(response.body);

    if (response.statusCode == 200)
    {
      Toast.show("Success", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);


      final parsed = jsonDecode(response.body);
      jwt_token=parsed['payload']['jwt_token'];

      addJWTToken(jwt_token);


      await getImage(jwt_token);


    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      Toast.show("Error", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

      throw Exception('Failed to create album.');
    }

  }

  @override
  Widget build(BuildContext context) {
    var h=MediaQuery.of(context).size.height;
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff0D0D0D),
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color:  Color(0xff0D0D0D),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text('Enter the 4-digit OTP.'
                ,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 24,color: Colors.white),),
            ),
            SizedBox(height: 14,),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'Enter code that we have sent to your\n',
                        style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15,color: Color(0xff666666))),
                    TextSpan(
                        text: 'phone number',
                        style: TextStyle(fontWeight: FontWeight.w400,fontSize: 15,color: Color(0xff666666))),
                    TextSpan(
                        text: ' $phone',
                        style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,color: Colors.green)),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: formKey,
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 30),
                  child: PinCodeTextField(
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 4,
                    obscureText: false,
                    obscuringCharacter: '*',
                    animationType: AnimationType.fade,
                    validator: (v) {
                      if (v.length < 3) {
                        return "I'm from validator";
                      } else {
                        return null;
                      }
                    },
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 60,
                      fieldWidth: 66,
                      inactiveColor: Colors.green,
                      selectedFillColor: Colors.grey,
                      inactiveFillColor: Colors.grey,
                      activeFillColor:
                      hasError ? Colors.orange : Colors.white,
                    ),
                    cursorColor: Colors.black,
                    animationDuration: Duration(milliseconds: 300),
                    textStyle: TextStyle(fontSize: 20, height: 1.6),
                    backgroundColor: Color(0xff0D0D0D),
                    enableActiveFill: true,
                    errorAnimationController: errorController,
                    controller: textEditingController,
                    keyboardType: TextInputType.number,
                    boxShadows: [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black12,
                        blurRadius: 10,
                      )
                    ],
                    onCompleted: (v) {
                      // print("Completed");
                      setState(() {
                        isEnabled=true;
                      });
                    },
                    // onTap: () {
                    //   print("Pressed");
                    // },
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        currentText = value;
                      });
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                hasError ? "*Please fill up all the cells properly" : "",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
            ),

            SizedBox(
              height: 14,
            ),
            GestureDetector(
              onTap: (){
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => HomePage()),
                // );
                confirmOTP();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0,left: 22,right: 22),
                child: Container(
                  height: h*0.08,
                  decoration: BoxDecoration(
                    color:isEnabled? Colors.green: Color(0xff9D9D9D),

                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text('Login',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w600),),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.refresh,color:resendOTP?Color(0xff6EC350) :Colors.grey),
                  GestureDetector(
                    onTap: (){
                      if(resendOTP==true){
                        resendOTPFunc();
                      }
                    },
                    child: Text('Resend OTP code',
                      style: TextStyle(color:resendOTP?Color(0xff6EC350) :Colors.grey,fontSize: 16,fontWeight: FontWeight.w400,decoration: TextDecoration.underline),
                    ),
                  ),
                  SizedBox(width: 10,),
                  CountdownTimer(
                    controller: controller,
                    onEnd: onEnd,
                    endTime: endTime,
                    endWidget: Text('00:00:00',style: TextStyle(color: Colors.white)),
                    textStyle: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class Album {
  final String digits;
  final String token;

  Album({ this.digits,  this.token});
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      digits: json['digits'],
      token: json['otp_token'],
    );
  }
}

