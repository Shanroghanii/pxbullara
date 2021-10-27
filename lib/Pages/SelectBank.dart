import 'package:ar_live_ais/Pages/EditBankDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectBank extends StatefulWidget {
  String date_of_birth,gender,name,surname;
  SelectBank({this.date_of_birth,this.gender,this.name,this.surname});

  @override
  _SelectBankState createState() => _SelectBankState(date_of_birth: this.date_of_birth,gender: this.gender,name: this.name,surname: this.surname);
}

class _SelectBankState extends State<SelectBank> {

  String date_of_birth,gender,name,surname;
  _SelectBankState({this.date_of_birth,this.gender,this.name,this.surname});

  Future<void> addStringToSF(String val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('bank', "$val");
    print('==================done');
  }

  Future<void> getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('bank');
    // setState(() {
    //   _selectedBank=stringValue;
    // });
    print('=================='+stringValue);
    // return stringValue;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Banks',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: 'Select bank',
            tiles: [
              SettingsTile(
                title: 'Siam Commercial',
                subtitle: 'SCB',
                leading: Image.asset(
                  'bank/siam.png',
                  height: 40,
                  width: 40,
                ),
                onPressed: (BuildContext context) {
                  // Navigator.pop(context);
                  addStringToSF('Siam Commercial').whenComplete(() {
                    // getStringValuesSF();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditBankDetails(date_of_birth: date_of_birth,gender: gender,name: name,surname: surname,)
                      ),
                    );
                  });
                },
              ),
              SettingsTile(
                title: 'Kasikorn Bank',
                subtitle: 'KBANK',
                leading: Image.asset(
                  'bank/kasikorn.png',
                  height: 40,
                  width: 40,
                ),
                onPressed: (BuildContext context) {
                  // Navigator.pop(context);
                  addStringToSF('Kasikorn Bank').whenComplete(() {
                    // getStringValuesSF();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditBankDetails(date_of_birth: date_of_birth,gender: gender,name: name,surname: surname,)),
                    );
                  });
                },
              ),
              SettingsTile(
                title: 'Bangkok Bank',
                subtitle: 'BBL',
                leading: Image.asset(
                  'bank/bangkok.png',
                  height: 40,
                  width: 40,
                ),
                onPressed: (BuildContext context) {
                  // Navigator.pop(context);
                  addStringToSF('Bangkok Bank').whenComplete(() {
                    // getStringValuesSF();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditBankDetails(date_of_birth: date_of_birth,gender: gender,name: name,surname: surname,)),
                    );
                  });
                },
              ),
              SettingsTile(
                title: 'Bank of Ayudhaya',
                subtitle: 'BAY',
                leading: Image.asset(
                  'bank/ayudhaya.png',
                  height: 40,
                  width: 40,
                ),
                onPressed: (BuildContext context) {
                  // Navigator.pop(context);
                  addStringToSF('Bank of Ayudhaya').whenComplete(() {
                    // getStringValuesSF();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditBankDetails(date_of_birth: date_of_birth,gender: gender,name: name,surname: surname,)),
                    );
                  });
                },
              ),
              SettingsTile(
                title: 'Thai Military Bank',
                subtitle: 'TMB',
                leading: Image.asset(
                  'bank/military.png',
                  height: 40,
                  width: 40,
                ),
                onPressed: (BuildContext context) {
                  // Navigator.pop(context);
                  addStringToSF('Thai Military Bankk').whenComplete(() {
                    // getStringValuesSF();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditBankDetails(date_of_birth: date_of_birth,gender: gender,name: name,surname: surname,)),
                    );
                  });
                },
              ),
              SettingsTile(
                title: 'Krung Thai Bank',
                subtitle: 'KTB',
                leading: Image.asset(
                  'bank/krungthai.png',
                  height: 40,
                  width: 40,
                ),
                onPressed: (BuildContext context) {
                  // Navigator.pop(context);
                  addStringToSF('Krung Thai Bank').whenComplete(() {
                    // getStringValuesSF();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditBankDetails(date_of_birth: date_of_birth,gender: gender,name: name,surname: surname,)),
                    );
                  });
                },
              ),
              SettingsTile(
                title: 'Kiatnakin Bank',
                subtitle: 'KK',
                leading: Image.asset(
                  'bank/kiatnakin.png',
                  height: 40,
                  width: 40,
                ),
                onPressed: (BuildContext context) {
                  // Navigator.pop(context);
                  addStringToSF('Kiatnakin Bank').whenComplete(() {
                    // getStringValuesSF();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditBankDetails(date_of_birth: date_of_birth,gender: gender,name: name,surname: surname,)),
                    );
                  });
                },
              ),
              SettingsTile(
                title: 'Citibank',
                subtitle: 'CITI',
                leading: Image.asset(
                  'bank/citibank.png',
                  height: 40,
                  width: 40,
                ),
                onPressed: (BuildContext context) {
                  // Navigator.pop(context);
                  addStringToSF('Citibank').whenComplete(() {
                    // getStringValuesSF();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditBankDetails(date_of_birth: date_of_birth,gender: gender,name: name,surname: surname,)),
                    );
                  });
                },
              ),
              SettingsTile(
                title: 'Thai Investment and Securities Company Bank',
                subtitle: 'TISCO',
                leading: Image.asset(
                  'bank/thaiinvestment.png',
                  height: 40,
                  width: 40,
                ),
                onPressed: (BuildContext context) {
                  // Navigator.pop(context);
                  addStringToSF('Thai Investment and Securities Company Bank').whenComplete(() {
                    // getStringValuesSF();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditBankDetails(date_of_birth: date_of_birth,gender: gender,name: name,surname: surname,)),
                    );
                  });
                },
              ),
              SettingsTile(
                title: 'Bank of Thailand',
                subtitle: 'BOT',
                leading: Image.asset(
                  'bank/bankthai.png',
                  height: 40,
                  width: 40,
                ),
                onPressed: (BuildContext context) {
                  // Navigator.pop(context);
                  addStringToSF('Bank of Thailand').whenComplete(() {
                    // getStringValuesSF();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditBankDetails(date_of_birth: date_of_birth,gender: gender,name: name,surname: surname,)),
                    );
                  });
                },
              ),
              SettingsTile(
                title: 'Thai credit retail bank',
                subtitle: 'TCRB',
                leading: Image.asset(
                  'bank/thaicreditretail.png',
                  height: 40,
                  width: 40,
                ),
                onPressed: (BuildContext context) {
                  // Navigator.pop(context);
                  addStringToSF('Thai credit retail bank').whenComplete(() {
                    // getStringValuesSF();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditBankDetails(date_of_birth: date_of_birth,gender: gender,name: name,surname: surname,)),
                    );
                  });
                },
              ),
              SettingsTile(
                title: 'Thanachart Bank',
                subtitle: 'TBANK',
                leading: Image.asset(
                  'bank/thanachart.png',
                  height: 40,
                  width: 40,
                ),
                onPressed: (BuildContext context) {
                  // Navigator.pop(context);
                  addStringToSF('Thanachart Bank').whenComplete(() {
                    // getStringValuesSF();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditBankDetails(date_of_birth: date_of_birth,gender: gender,name: name,surname: surname,)),
                    );
                  });
                },
              ),
              SettingsTile(
                title: 'Bank of America',
                subtitle: 'BOA',
                leading: Image.asset(
                  'bank/america.png',
                  height: 40,
                  width: 40,
                ),
                onPressed: (BuildContext context) {
                  // Navigator.pop(context);
                  addStringToSF('Bank of America').whenComplete(() {
                    // getStringValuesSF();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditBankDetails(date_of_birth: date_of_birth,gender: gender,name: name,surname: surname,)),
                    );
                  });
                },
              ),
              SettingsTile(
                title: 'United Overseas Bank, Thailand',
                subtitle: 'UOB',
                leading: Image.asset(
                  'bank/oversea.png',
                  height: 40,
                  width: 40,
                ),
                onPressed: (BuildContext context) {
                  // Navigator.pop(context);
                  addStringToSF('United Overseas Bank, Thailand').whenComplete(() {
                    // getStringValuesSF();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditBankDetails(date_of_birth: date_of_birth,gender: gender,name: name,surname: surname,)),
                    );
                  });
                },
              ),
              SettingsTile(
                title: 'Standard Chartered Bank Thai',
                subtitle: 'SC',
                leading: Image.asset(
                  'bank/standard.png',
                  height: 40,
                  width: 40,
                ),
                onPressed: (BuildContext context) {
                  // Navigator.pop(context);
                  addStringToSF('Standard Chartered Bank Thai').whenComplete(() {
                    // getStringValuesSF();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditBankDetails(date_of_birth: date_of_birth,gender: gender,name: name,surname: surname,)),
                    );
                  });
                },
              ),
              SettingsTile(
                title: 'Mega International Commercial Bank',
                subtitle: 'MEGA',
                leading: Image.asset(
                  'bank/mega.png',
                  height: 40,
                  width: 40,
                ),
                onPressed: (BuildContext context) {
                  // Navigator.pop(context);
                  addStringToSF('Mega International Commercial Bank').whenComplete(() {
                    // getStringValuesSF();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditBankDetails(date_of_birth: date_of_birth,gender: gender,name: name,surname: surname,)),
                    );
                  });
                },
              ),
              SettingsTile(
                title: 'ICBCT',
                subtitle: 'ICBCT',
                leading: Image.asset(
                  'bank/icbct.png',
                  height: 40,
                  width: 40,
                ),
                onPressed: (BuildContext context) {
                  // Navigator.pop(context);
                  addStringToSF('ICBCT').whenComplete(() {
                    // getStringValuesSF();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditBankDetails(date_of_birth: date_of_birth,gender: gender,name: name,surname: surname,)),
                    );
                  });
                },
              ),
              SettingsTile(
                title: 'Land and House Bank',
                subtitle: 'LHB',
                leading: Image.asset(
                  'bank/landhouse.png',
                  height: 40,
                  width: 40,
                ),
                onPressed: (BuildContext context) {
                  // Navigator.pop(context);
                  addStringToSF('Land and House Bank').whenComplete(() {
                    // getStringValuesSF();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditBankDetails(date_of_birth: date_of_birth,gender: gender,name: name,surname: surname,)),
                    );
                  });
                },
              ),
              SettingsTile(
                title: 'Bank for Agriculture and Agricultural Cooperatives',
                subtitle: 'BAAC',
                leading: Image.asset(
                  'bank/agriculture.png',
                  height: 40,
                  width: 40,
                ),
                onPressed: (BuildContext context) {
                  // Navigator.pop(context);
                  addStringToSF('Bank for Agriculture and Agricultural Cooperatives').whenComplete(() {
                    // getStringValuesSF();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditBankDetails(date_of_birth: date_of_birth,gender: gender,name: name,surname: surname,)),
                    );
                  });
                },
              ),
              SettingsTile(
                title: 'CIMB THAI',
                subtitle: 'CIMBT',
                leading: Image.asset(
                  'bank/cimb.png',
                  height: 40,
                  width: 40,
                ),
                onPressed: (BuildContext context) {
                  // Navigator.pop(context);
                  addStringToSF('CIMB THAI').whenComplete(() {
                    // getStringValuesSF();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditBankDetails(date_of_birth: date_of_birth,gender: gender,name: name,surname: surname,)),
                    );
                  });
                },
              ),
              SettingsTile(
                title: 'Government Saving Bank',
                subtitle: 'GSB',
                leading: Image.asset(
                  'bank/saving.png',
                  height: 40,
                  width: 40,
                ),
                onPressed: (BuildContext context) {
                  // Navigator.pop(context);
                  addStringToSF('Government Saving Bank').whenComplete(() {
                    // getStringValuesSF();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditBankDetails(date_of_birth: date_of_birth,gender: gender,name: name,surname: surname,)),
                    );
                  });
                },
              ),
              SettingsTile(
                title: 'Government Housing Bank',
                subtitle: 'GHB',
                leading: Image.asset(
                  'bank/housing.png',
                  height: 40,
                  width: 40,
                ),
                onPressed: (BuildContext context) {
                  // Navigator.pop(context);
                  addStringToSF('Government Housing Bank').whenComplete(() {
                    // getStringValuesSF();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditBankDetails(date_of_birth: date_of_birth,gender: gender,name: name,surname: surname,)),
                    );
                  });
                },
              ),
              SettingsTile(
                title: 'Islamic Bank of Thailand',
                subtitle: 'IBT',
                leading: Image.asset(
                  'bank/islamic.png',
                  height: 40,
                  width: 40,
                ),
                onPressed: (BuildContext context) {
                  // Navigator.pop(context);
                  addStringToSF('Islamic Bank of Thailand').whenComplete(() {
                    // getStringValuesSF();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditBankDetails(date_of_birth: date_of_birth,gender: gender,name: name,surname: surname,)),
                    );
                  });
                },
              ),
              SettingsTile(
                title: 'Hong Kong & Shanghai Banking',
                subtitle: 'HSBC',
                leading: Image.asset(
                  'bank/shangai.png',
                  height: 40,
                  width: 40,
                ),
                onPressed: (BuildContext context) {
                  // Navigator.pop(context);
                  addStringToSF('Hong Kong & Shanghai Banking').whenComplete(() {
                    // getStringValuesSF();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditBankDetails(date_of_birth: date_of_birth,gender: gender,name: name,surname: surname,)),
                    );
                  });
                },
              ),
              SettingsTile(
                title: 'Royal Bank of Scotland',
                subtitle: 'RBS',
                leading: Image.asset(
                  'bank/royal.png',
                  height: 40,
                  width: 40,
                ),
                onPressed: (BuildContext context) {
                  // Navigator.pop(context);
                  addStringToSF('Royal Bank of Scotland').whenComplete(() {
                    // getStringValuesSF();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditBankDetails(date_of_birth: date_of_birth,gender: gender,name: name,surname: surname,)),
                    );
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
