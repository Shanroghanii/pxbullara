import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

import 'OtpPage.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isThai = false;
  String otpToken;
  String phone;
  String error;
  String avatarError;
  TextEditingController controller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController otherController = TextEditingController();
  TextEditingController reasonController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  var df = new DateFormat('yyyy-MM-dd');
  String bdate;
  List<String> _locations = ['Male', 'Female', 'Other']; // Option 2
  String _selectedLocation;
  bool isSexOther = false;
  bool isReasonOther = false;

  List<String> _option = [
    'Business or brand',
    'Learning and teaching',
    'Social streaming',
    'Public figure',
    'Other'
  ]; // Option 2
  String _selectedOption;

  Future<String> createAccount() async {
    var dio = Dio();

    var formData = FormData.fromMap({
      'avatar': await MultipartFile.fromFile(_image.path,
          filename: _image.path
              .split('/')
              .last), // file.path.split('/').last or use  path library
      'date_of_birth': bdate,
      'device_id': DateTime.now().microsecondsSinceEpoch.toString(),
      'email': emailController.text,
      'gender': (isSexOther ? otherController.text : _selectedLocation),
      'name': nameController.text,
      'password': passController.text,
      'purpose': (isReasonOther ? reasonController.text : _selectedOption),
      'surname': surnameController.text,
      'telephone': "+92" + phoneController.text,
    });
    final respond = dio
        .post('https://api-stg.authority.wittytech.live/v1/register',
            data: formData,
            options: Options(
                method: 'POST',
                contentType: 'multipart/form-data',
                headers: <String, String>{
                  'Content-Type': 'multipart/form-data'
                },
                responseType: ResponseType.json // or ResponseType.JSON
                ))
        .then((response) {
      print(response.data.toString());
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.toString());
        otpToken = parsed['payload']['pre_login']['otp_token'];
        phone = parsed['payload']['pre_login']['otp_telephone'];
        print('this is otp okokokok mdi dokdodk ');
        print(otpToken);
        Toast.show("Success", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtpPage(
                    otpToken: otpToken,
                    phone: phone,
                  )),
        );
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        final parsed = jsonDecode(response.toString());
        error = parsed['message'];
        Toast.show("$error", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);

        throw Exception('Failed to create album.');
      }
    }).catchError((error) => print("error" + error.message.toString()));
    // print("+++++++++++++++++++++++++"+respond);
    // FormData formData = new FormData.from({
    //   "name": "wendux",
    //   "file1": new UploadFileInfo(new File("./upload.jpg"), "upload1.jpg")
    // });
    // final response = await dio.post("/info", data: formData);
    // final response = await http.post(
    //   Uri.parse('https://api-stg.authority.wittytech.live/v1/register'),
    //   headers: <String, String>{
    //     // 'accept': 'multipart/form-data',
    //     'Content-Type': 'multipart/form-data'
    //   },
    //   body: jsonEncode(<String, String>{
    //     'avatar': 'await MultipartFile.fromFile(_image.path,filename: _image.path)',
    //     'date_of_birth': bdate,
    //     'device_id': DateTime.now().microsecondsSinceEpoch.toString(),
    //     'email': emailController.text,
    //     'gender': (isSexOther ? otherController.text : _selectedLocation),
    //     'name': nameController.text,
    //     'password': passController.text,
    //     'purpose': (isReasonOther ? reasonController.text : _selectedOption),
    //     'surname': surnameController.text,
    //     'telephone': "+66" + phoneController.text
    //   }),
    // );
    //  print(response.body);
    //
    // if (response.statusCode == 200) {
    //   final parsed = jsonDecode(response.body);
    //   otpToken = parsed['payload']['pre_login']['otp_token'];
    //   phone = parsed['payload']['pre_login']['otp_telephone'];
    //
    //   // print(otpToken);
    //   Fluttertoast.showToast(
    //       msg: "Success",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.red,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => OtpPage(
    //               otpToken: otpToken,
    //               phone: phone,
    //             )),
    //   );
    // } else {
    //   // If the server did not return a 201 CREATED response,
    //   // then throw an exception.
    //   final parsed = jsonDecode(response.body);
    //   error = parsed['message'];
    //   Fluttertoast.showToast(
    //       msg: "$error",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.red,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    //   throw Exception('Failed to create album.');
    // }
  }

  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // phoneController.text = '+66804548452';
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        bdate = df.format(selectedDate);
        controller.text = bdate;
      });
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
              height: 20,
            ),
            Text(
              'Register',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Fill out the information to register',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w200,
                  color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 22, right: 22),
              child: Container(
                height: h * 0.08,
                child: TextField(
                  controller: surnameController,
                  style: TextStyle(color: Colors.white),
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
                      labelText: 'Surname*',
                      labelStyle: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 22, right: 22),
              child: Container(
                height: h * 0.08,
                child: TextField(
                  controller: nameController,
                  style: TextStyle(color: Colors.white),
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
                      labelText: 'Last Name*',
                      labelStyle: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 22, right: 22),
              child: Container(
                height: h * 0.08,
                child: TextField(
                  controller: passController,
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
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
                      labelText: 'Password*',
                      labelStyle: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 22, right: 22),
              child: Container(
                height: h * 0.08,
                child: TextField(
                  obscureText: true,
                  style: TextStyle(color: Colors.white),
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
                      labelText: 'Confirm Password*',
                      labelStyle: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 22, right: 22),
              child: Container(
                height: h * 0.08,
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.white),
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
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      fillColor: Color(0x29FFFFFF),
                      filled: true,
                      prefixIcon: Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            '+66',
                            style: TextStyle(color: Colors.white),
                          )),
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
                      labelText: 'Phone*',
                      labelStyle: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 22, right: 22),
              child: Container(
                height: h * 0.08,
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.datetime,
                  style: TextStyle(color: Colors.white),
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
                      labelText: 'Date of Birth',
                      suffixIcon: GestureDetector(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Icon(
                            Icons.calendar_today,
                            color: Colors.green,
                          )),
                      labelStyle: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 20, right: 20),
              child: Container(
                height: h * 0.08,
                width: w * 0.95,
                decoration: BoxDecoration(
                  color: Color(0x29FFFFFF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton(
                    dropdownColor: Colors.black,
                    hint: Text(
                        'Sex                                                              ',
                        style: TextStyle(color: Colors.white)),
                    // Not necessary for Option 1
                    value: _selectedLocation,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedLocation = newValue;
                      });
                      if (_selectedLocation == 'Other') {
                        setState(() {
                          isSexOther = true;
                        });
                      } else {
                        setState(() {
                          isSexOther = false;
                        });
                      }
                      // print(isSexOther);
                    },
                    items: _locations.map((location) {
                      return DropdownMenuItem(
                        child: new Text(
                          location,
                          style: TextStyle(color: Colors.white),
                        ),
                        value: location,
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            isSexOther
                ? Padding(
                    padding:
                        const EdgeInsets.only(top: 12.0, left: 22, right: 22),
                    child: Container(
                      height: h * 0.08,
                      child: TextField(
                        controller: otherController,
                        keyboardType: TextInputType.emailAddress,
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
                            labelText: 'Other',
                            labelStyle: TextStyle(color: Colors.white)),
                      ),
                    ),
                  )
                : Container(),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 20, right: 20),
              child: Container(
                height: h * 0.08,
                width: w * 0.95,
                decoration: BoxDecoration(
                  color: Color(0x29FFFFFF),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton(
                    dropdownColor: Colors.black,
                    hint: Text(
                      'The reason for using the application    ',
                      style: TextStyle(color: Colors.white),
                    ),
                    // Not necessary for Option 1
                    value: _selectedOption,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedOption = newValue;
                      });
                      if (_selectedOption == 'Other') {
                        setState(() {
                          isReasonOther = true;
                        });
                      } else {
                        setState(() {
                          isReasonOther = false;
                        });
                      }
                    },
                    items: _option.map((location) {
                      return DropdownMenuItem(
                        child: new Text(
                          location,
                          style: TextStyle(color: Colors.white),
                        ),
                        value: location,
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            isReasonOther
                ? Padding(
                    padding:
                        const EdgeInsets.only(top: 12.0, left: 22, right: 22),
                    child: Container(
                      height: h * 0.08,
                      child: TextField(
                        controller: reasonController,
                        keyboardType: TextInputType.emailAddress,
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
                            labelText: 'Other',
                            labelStyle: TextStyle(color: Colors.white)),
                      ),
                    ),
                  )
                : Container(),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                // uploadAvatar();
                createAccount();
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
                      'Register',
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
  final String avatar;
  final String date;
  final String id;
  final String gender;
  final String email;
  final String name;
  final String password;
  final String purpose;
  final String surname;
  final String telephone;

  Album(
      {this.avatar,
      this.date,
      this.id,
      this.gender,
      this.email,
      this.name,
      this.password,
      this.purpose,
      this.surname,
      this.telephone});

  factory Album.fromJson(Map<String, String> json) {
    return Album(
      avatar: json['avatar'],
      date: json['date_of_birth'],
      id: json['device_id'],
      email: json['email'],
      gender: json['gender'],
      name: json['name'],
      password: json['password'],
      purpose: json['purpose'],
      surname: json['surname'],
      telephone: json['telephone'],
    );
  }
}
