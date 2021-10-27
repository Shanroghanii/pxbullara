import 'dart:convert';

import 'package:ar_live_ais/Pages/AssetSetup.dart';
import 'package:ar_live_ais/Pages/FacebookPage.dart';
import 'package:ar_live_ais/Pages/LiveScreen.dart';
import 'package:ar_live_ais/main.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'EditProfile.dart';

class HomePage extends StatefulWidget
{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{

  bool isThai=false;
  String error;

  String name,surname,urls,protocol,avatar='https://cdn.icon-icons.com/icons2/2506/PNG/512/user_icon_150670.png';

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('jwttoken');
    getUserInfo(stringValue);
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('jwttoken');
    readyLogout(stringValue);
  }

  Future<void> readyLogout(String token) async {
    var url=Uri.parse('https://api-stg.authority.wittytech.live/v1/logout');
    final response = await http.post(url, headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    if (response.statusCode == 200)
    {
      Toast.show("Logout", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

      // Fluttertoast.showToast(
      //     msg: "Logout",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0
      // );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );

    } else {
      final parsed = jsonDecode(response.toString());
      error = parsed['message'];
      Toast.show("$error", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

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




  getUserInfo(String token) async {
    var url=Uri.parse('https://api-stg.authority.wittytech.live/v1/user-info');
    final response = await http.get(url, headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(response.body);

    if (response.statusCode == 200)
    {
      Toast.show("Success", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

      // Fluttertoast.showToast(
      //     msg: "Success",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0
      // );

      final parsed = jsonDecode(response.body);
      setState(() {
        name=parsed['payload']['user_info']['name'];
        surname=parsed['payload']['user_info']['surname'];
        avatar=parsed['payload']['user_info']['avatar'];
        protocol=parsed['payload']['websocket']['protocol'];
        // urls=parsed['payload']['websocket']['url'];

      });
    } else {
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

  @override
  void initState() {
    getToken();
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);

    final _channel = WebSocketChannel.connect(
        Uri.parse('wss://api-stg.authority.wittytech.live/v1/pingpong'),protocols: ['$protocol']
    );

    // print("URL"+urls);
    // print("protocol"+protocol);
  }

  void showDialog(){
    AwesomeDialog(
      dialogBackgroundColor: Color(0xff0D0D0D),
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.NO_HEADER,
      body: Center(child: Text(
        'Confirm to log out',
        style: TextStyle(fontStyle: FontStyle.italic,fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600),
      ),),

      btnOkOnPress: () {
        logout();
      },
      btnCancelOnPress: (){
        Navigator.pop(context);
      },

    )..show();
  }

  void linkYoutubeDialog(){
    AwesomeDialog(
      dialogBackgroundColor: Colors.black,
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.NO_HEADER,
      body: Column(
        children: [
          Text(
            'Link Youtube',
            style: TextStyle(fontStyle: FontStyle.italic,fontSize: 20,color: Colors.white,fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0,left: 22,right: 22),
            child: Container(
              height: 45,
              child: TextField(
                style: TextStyle(color: Colors.white),

                decoration: InputDecoration(
                    fillColor: Color(0x29FFFFFF),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.0),
                        borderSide: new BorderSide(color: Color(0x29FFFFFF))
                    ),
                    enabledBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide:  BorderSide(color: Color(0x29FFFFFF), width: 0.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide:  BorderSide(color: Color(0x29FFFFFF), width: 0.0),
                    ),
                    labelText: 'https://youtube.com/',
                    labelStyle: TextStyle(color: Colors.white)
                ),
              ),
            ),
          ),
        ],
      ),
      btnOkOnPress: () {
        showTopSnackBar(
          context,
          CustomSnackBar.success(
            message:
            "Added Youtube Link Successfully",
          ),
        );
      },

    )..show();
  }
  void linkFacebookDialog(){
    AwesomeDialog(
      dialogBackgroundColor: Colors.black,
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.NO_HEADER,
      body: Column(
        children: [
          Text(
            'Link Facebook',
            style: TextStyle(fontStyle: FontStyle.italic,fontSize: 20,color: Colors.white,fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0,left: 22,right: 22),
            child: Container(
              height: 45,
              child: TextField(
                style: TextStyle(color: Colors.white),

                decoration: InputDecoration(
                    fillColor: Color(0x29FFFFFF),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14.0),
                        borderSide: new BorderSide(color: Color(0x29FFFFFF))
                    ),
                    enabledBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide:  BorderSide(color: Color(0x29FFFFFF), width: 0.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide:  BorderSide(color: Color(0x29FFFFFF), width: 0.0),
                    ),
                    labelText: 'https://facebook.com/',
                    labelStyle: TextStyle(color: Colors.white)
                ),
              ),
            ),
          ),
        ],
      ),
      btnOkOnPress: () {
        showTopSnackBar(
          context,
          CustomSnackBar.success(
            message:
            "Added Facebook Link Successfully",
          ),
        );
      },

    )..show();
  }

  @override
  Widget build(BuildContext context) {
    var h=MediaQuery.of(context).size.height;
    var w=MediaQuery.of(context).size.width;

    return Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color:  Color(0xff0D0D0D),
            image:  DecorationImage(
              image: AssetImage('assets/bak.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: h*0.045,),

                GestureDetector(
                  onTap: (){
                    if(isThai==true){
                      setState(() {
                        isThai=false;
                      });
                    }
                    else{
                      setState(() {
                        isThai=true;
                      });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                        alignment: Alignment.topRight,
                        child:isThai?Image.asset('assets/off.png'): Image.asset('assets/on.png')),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: h*0.34,
                  width: w*0.86,
                  decoration: BoxDecoration(
                    color:  Color(0xff0D0D0D),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 15,),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => EditProfile(value: 0,)),
                          );
                        },
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(52),
                            child: Image.network('$avatar',height: 80,width: 80,fit: BoxFit.cover,)),
                      ),
                      SizedBox(height: 10,),
                      Text('$name $surname',
                      style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 10,),
                      Text('ID : 000192405',
                      style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 30,),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LiveScreen()),
                      );
                    },
                    child: Container(
                      height: h*0.06,
                      width: w*0.73,
                      decoration: BoxDecoration(
                        color:  Colors.green,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.play_arrow_rounded,color: Colors.white,),
                          SizedBox(width: 10,),
                          Text('PERVIEW LIVE',
                            style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.white),)
                        ],
                      ),
                    ),
                  ),


                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: h*0.12,
                  width: w*0.86,
                  decoration: BoxDecoration(
                    color:  Color(0xff0D0D0D),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      Image.asset('assets/setting.png',height: 55,width: 55,),
                      SizedBox(width: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Asset Setup',
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 15),
                          ),
                          Text('Set Banner, Gif,\nBackground, Text',
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 12),
                          ),

                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AssetSetup()),
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                        ),
                      ),
                      SizedBox(width: 15,),


                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: h*0.12,
                  width: w*0.86,
                  decoration: BoxDecoration(
                    color:  Color(0xff0D0D0D),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 10,),
                      Image.asset('assets/facebook.png',height: 45,width: 45,),
                      SizedBox(width: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Facebook Setup',
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 15),
                          ),
                          Text('-',
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 12),
                          ),

                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: (){
                          // linkFacebookDialog();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FacebookPage()),
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Icon(Icons.add,color: Colors.white,),
                        ),
                      ),
                      SizedBox(width: 15,),


                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: h*0.12,
                  width: w*0.86,
                  decoration: BoxDecoration(
                    color:  Color(0xff0D0D0D),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 10,),
                      Image.asset('assets/youtube.png',height: 45,width: 45,),
                      SizedBox(width: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Youtube Setup',
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 15),
                          ),
                          Text('-',
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 12),
                          ),

                        ],
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: (){
                          linkYoutubeDialog();
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Icon(Icons.add,color: Colors.white,),
                        ),
                      ),
                      SizedBox(width: 15,),


                    ],
                  ),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: (){
                    showDialog();
                  },
                  child: Text('Log Out',
                  style: TextStyle(decoration: TextDecoration.underline,color: Colors.green,fontSize: 16,fontWeight: FontWeight.w400),
                  ),
                )

              ],
            ),
          ),
        )
    );
  }
}
