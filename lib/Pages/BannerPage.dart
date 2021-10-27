import 'package:ar_live_ais/Pages/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class BannerPage extends StatefulWidget {
  String jwt_Token;
  String banner_url;
  String url;
  String protocol;

  BannerPage({this.jwt_Token, this.banner_url, this.url, this.protocol});

  @override
  _BannerPageState createState() => _BannerPageState(
      jwt_Token: this.jwt_Token,
      banner_url: this.banner_url,
      url: url,
      protocol: protocol);
}

class _BannerPageState extends State<BannerPage> {
  String jwt_Token;
  String banner_url;
  String url;
  String protocol;

  _BannerPageState({this.jwt_Token, this.banner_url, this.url, this.protocol});

  bool _value = false;

  void _launchURL() async => await canLaunch(banner_url)
      ? await launch(banner_url)
      : throw 'Could not launch $banner_url';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    final _channel = WebSocketChannel.connect(
        Uri.parse('wss://api-stg.authority.wittytech.live/v1/pingpong'),
        protocols: ['$protocol']);
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 400,
              width: double.infinity,
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      _launchURL();
                    },
                    child: Image.network(
                      jwt_Token,
                      fit: BoxFit.fill,
                      height: 400,
                      width: double.infinity,
                    ),
                  ),
                  Positioned(
                    top: h * 0.002,
                    left: w * 0.9,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(22),
                        ),
                        // color: Colors.white,
                        child: Center(
                          child: Icon(
                            Icons.clear,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 70,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Checkbox(
                    value: this._value,
                    onChanged: (bool value) {
                      setState(() {
                        this._value = value;
                      });
                    },
                  ), //
                  SizedBox(width: 10), //SizedBox

                  Text(
                    'Do not show this banner again',
                    style: TextStyle(fontSize: 14.0, color: Colors.black),
                  ), // Checkbox
                ], //<Widget>[]
              ),
            )
          ],
        ),
      ),
    );
  }
}
