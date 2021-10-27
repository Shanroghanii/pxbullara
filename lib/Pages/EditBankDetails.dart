import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

import 'EditProfile.dart';
import 'HomePage.dart';
import 'SelectBank.dart';

class EditBankDetails extends StatefulWidget {
  String date_of_birth,gender,name,surname;
  EditBankDetails({this.date_of_birth,this.gender,this.name,this.surname});

  @override
  _EditBankDetailsState createState() => _EditBankDetailsState(date_of_birth: this.date_of_birth,gender: this.gender,name: this.name,surname: this.surname);
}

class _EditBankDetailsState extends State<EditBankDetails> {

  String date_of_birth,gender,name,surname;
  _EditBankDetailsState({this.date_of_birth,this.gender,this.name,this.surname});


  String error;
  String account_bank,account_name,account_number;
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();
  String _selectedBank;


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

  @override
  void initState()
  {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);

    getStringValuesSF();

  }



  Future<void> uploadBankInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('jwttoken');
    bankInfo(stringValue);
    // print('Token'+stringValue);
    // return stringValue;
  }

  Future<Album> bankInfo(String token) async {
    final response = await http.post(
      Uri.parse('https://api-stg.authority.wittytech.live/v1/user-info'),
      headers: <String, String>{
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'account_bank': _selectedBank,
        'account_name': accountNameController.text,
        'account_number': accountNumberController.text,
        'date_of_birth': date_of_birth,
        'gender': gender,
        'name': name,
        'purpose': 'Entertainment',
        'surname': surname,
      }),
    );
    print(response.body);
    if (response.statusCode == 200) {
      // print(otpToken);
      // Fluttertoast.showToast(
      //     msg: "Success",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
      Toast.show("Success", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);

      // Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      final parsed = jsonDecode(response.body);
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
  }

  @override
  Widget build(BuildContext context) {

    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff0D0D0D),
      // extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          // backgroundColor: Color(0xff0D0D0D),
          elevation: 0,
          centerTitle: true,
          leading: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
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
            'Edit Bank Details',
            style: TextStyle(color: Colors.white),
          ),
        ),
      body: Column(
        children: [
          Padding(
            padding:
            const EdgeInsets.only(top: 12.0, left: 22, right: 22),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SelectBank(date_of_birth: date_of_birth,gender: gender,name: name,surname: surname)),
                );
              },
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
                          '$_selectedBank',
                          style: TextStyle(color: Colors.white),
                        ))),
              ),
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.only(top: 12.0, left: 22, right: 22),
            child: Container(
              height: h * 0.08,
              child: TextField(
                controller: accountNameController,
                keyboardType: TextInputType.text,
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
                    labelText: 'Account Name*',
                    labelStyle: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.only(top: 12.0, left: 22, right: 22),
            child: Container(
              height: h * 0.08,
              child: TextField(
                controller: accountNumberController,
                keyboardType: TextInputType.phone,
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
                    labelText: 'Account Number*',
                    labelStyle: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              // Navigator.pop(context);
              uploadBankInfo();
            },
            child: Padding(
              padding:
              const EdgeInsets.only(top: 12.0, left: 22, right: 22),
              child: Container(
                height: h * 0.08,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                  child: Text(
                    'Save',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
