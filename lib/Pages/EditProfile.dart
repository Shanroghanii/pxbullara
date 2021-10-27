import 'dart:convert';

import 'package:ar_live_ais/Pages/ChangeProfilePic.dart';
import 'package:ar_live_ais/Pages/EditBankDetails.dart';
import 'package:ar_live_ais/Pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class EditProfile extends StatefulWidget {
  int value;

  EditProfile({this.value});

  @override
  _EditProfileState createState() => _EditProfileState(value: this.value);
}

class _EditProfileState extends State<EditProfile> {
  int value;

  _EditProfileState({this.value});

  String _selectedBank;
  String error;

  TextEditingController accountNumberController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  String name;
  String avatar='https://cdn-icons-png.flaticon.com/512/149/149071.png';
  String surname;
  String email;
  String telephone;
  String date_of_birth;
  String gender;
  String purpose;
  String account_bank,account_name,account_number;



  Future<void> addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('bank', "Bank Name");
    // print('==================done');
  }

  void addNothing() {
    print('==================nothing');
  }

  Future<void> getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('bank');
    setState(() {
      _selectedBank = stringValue;
    });
    // print('=================='+_selectedBank);
    // return stringValue;
  }

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('jwttoken');
    getUserInfo(stringValue);
    // print('Token'+stringValue);
    // return stringValue;
  }



  getUserInfo(String token) async {
    var url =
        Uri.parse('https://api-stg.authority.wittytech.live/v1/user-info');
    final response = await http.get(url, headers: {
      'accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(response.body);
    if (response.statusCode == 200) {
      Toast.show("Success", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

      // Fluttertoast.showToast(
      //     msg: "Success",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
      final parsed = jsonDecode(response.body);
      setState(() {
        avatar = parsed['payload']['user_info']['avatar'];
        name = parsed['payload']['user_info']['name'];
        surname = parsed['payload']['user_info']['surname'];
        email = parsed['payload']['user_info']['email'];
        telephone = parsed['payload']['user_info']['telephone'];
        date_of_birth = parsed['payload']['user_info']['date_of_birth'];
        gender = parsed['payload']['user_info']['gender'];
        purpose = parsed['payload']['user_info']['purpose'];
        account_bank = parsed['payload']['user_info']['account_bank'];
        account_name = parsed['payload']['user_info']['account_name'];
        account_number = parsed['payload']['user_info']['account_number'];
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
      //     fontSize: 16.0);
      throw Exception('Failed to create album.');
    }
  }

  @override
  void initState()
  {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);

    print("$value");
    value == 1 ? addNothing() : addStringToSF();
    getStringValuesSF();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          // backgroundColor: Color(0xff0D0D0D),
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            'User Profile',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditBankDetails(date_of_birth: date_of_birth,gender: gender,name: name,surname: surname,)),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.edit,color: Colors.white,),
              ),
            )
          ],
        ),
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
                SizedBox(
                  height: 60,
                ),

                Stack(
                  children: [
                    // _image != null
                    //     ? ClipRRect(
                    //         borderRadius: BorderRadius.circular(144),
                    //         child: Image.file(
                    //           _image,
                    //           width: 160,
                    //           height: 160,
                    //           fit: BoxFit.fill,
                    //         ),
                    //       )
                    //     : Container(
                    //         height: 160,
                    //         width: 160,
                    //         decoration: BoxDecoration(
                    //           color: Color(0xff2a2a2a),
                    //           borderRadius: BorderRadius.circular(144),
                    //         ),
                    //         child: Center(
                    //             child: FaIcon(
                    //           FontAwesomeIcons.user,
                    //           size: 70,
                    //           color: Colors.grey[300],
                    //         )),
                    //       ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(144),
                      child: Image.network(
                        avatar,
                        width: 160,
                        height: 160,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned(
                      top: 120,
                      left: 120,
                      child: GestureDetector(
                        onTap: () {
                          // _showPicker(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChangeProfilePic()),
                          );
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
                  height: 20,
                ),
                Text(
                  'My Profile',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding:  EdgeInsets.only(top: 10, left: 25, right: 22),
                    child: Text('Last Name',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 5.0, left: 22, right: 22),
                  child: Container(
                    height: h * 0.08,
                    decoration: BoxDecoration(
                      color: Color(0x29FFFFFF),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '$name',
                              style: TextStyle(color: Colors.white),
                            ))),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding:  EdgeInsets.only(top: 10, left: 25, right: 22),
                    child: Text('Surname',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 5.0, left: 22, right: 22),
                  child: Container(
                    height: h * 0.08,
                    decoration: BoxDecoration(
                      color: Color(0x29FFFFFF),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '$surname',
                              style: TextStyle(color: Colors.white),
                            ))),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding:  EdgeInsets.only(top: 10, left: 25, right: 22),
                    child: Text('Email',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 5.0, left: 22, right: 22),
                  child: Container(
                    height: h * 0.08,
                    decoration: BoxDecoration(
                      color: Color(0x29FFFFFF),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '$email',
                              style: TextStyle(color: Colors.white),
                            ))),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding:  EdgeInsets.only(top: 10, left: 25, right: 22),
                    child: Text('Telephone',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 5.0, left: 22, right: 22),
                  child: Container(
                    height: h * 0.08,
                    decoration: BoxDecoration(
                      color: Color(0x29FFFFFF),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '$telephone',
                              style: TextStyle(color: Colors.white),
                            ))),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding:  EdgeInsets.only(top: 10, left: 25, right: 22),
                    child: Text('Date of Birth',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 5.0, left: 22, right: 22),
                  child: Container(
                    height: h * 0.08,
                    decoration: BoxDecoration(
                      color: Color(0x29FFFFFF),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '$date_of_birth',
                              style: TextStyle(color: Colors.white),
                            ))),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding:  EdgeInsets.only(top: 10, left: 25, right: 22),
                    child: Text('Gender',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 5.0, left: 22, right: 22),
                  child: Container(
                    height: h * 0.08,
                    decoration: BoxDecoration(
                      color: Color(0x29FFFFFF),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '$gender',
                              style: TextStyle(color: Colors.white),
                            ))),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding:  EdgeInsets.only(top: 10, left: 25, right: 22),
                    child: Text('Purpose',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 5.0, left: 22, right: 22),
                  child: Container(
                    height: h * 0.08,
                    decoration: BoxDecoration(
                      color: Color(0x29FFFFFF),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '$purpose',
                              style: TextStyle(color: Colors.white),
                            ))),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding:  EdgeInsets.only(top: 10, left: 25, right: 22),
                    child: Text('Account Bank',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 5.0, left: 22, right: 22),
                  child: Container(
                    height: h * 0.08,
                    decoration: BoxDecoration(
                      color: Color(0x29FFFFFF),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '$account_bank',
                              style: TextStyle(color: Colors.white),
                            ))),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding:  EdgeInsets.only(top: 10, left: 25, right: 22),
                    child: Text('Account Name',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 5.0, left: 22, right: 22),
                  child: Container(
                    height: h * 0.08,
                    decoration: BoxDecoration(
                      color: Color(0x29FFFFFF),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '$account_name',
                              style: TextStyle(color: Colors.white),
                            ))),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding:  EdgeInsets.only(top: 10, left: 25, right: 22),
                    child: Text('Account Number',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.white),),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 5.0, left: 22, right: 22),
                  child: Container(
                    height: h * 0.08,
                    decoration: BoxDecoration(
                      color: Color(0x29FFFFFF),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '$account_number',
                              style: TextStyle(color: Colors.white),
                            ))),
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
  final String account_bank;
  final String account_name;
  final String account_number;
  final String date_of_birth;
  final String gender;
  final String name;
  final String purpose;
  final String surname;

  Album(
      {this.account_bank,
      this.account_name,
      this.account_number,
      this.date_of_birth,
      this.gender,
      this.name,
      this.purpose,
      this.surname});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
        account_bank: json['account_bank'],
        account_name: json['account_name'],
        account_number: json['account_number'],
        date_of_birth: json['date_of_birth'],
        gender: json['gender'],
        name: json['name'],
        purpose: json['purpose'],
        surname: json['surname']);
  }
}
