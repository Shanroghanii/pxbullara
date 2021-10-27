import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


class SelectImages extends StatefulWidget {
  @override
  _SelectImagesState createState() => _SelectImagesState();
}

class _SelectImagesState extends State<SelectImages> {
  List<Asset> images = <Asset>[];
  String _error = 'No Error Dectected';
  bool isEnabled=false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
  }

  Widget buildGridView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
        crossAxisCount: 2,
        children:
        List.generate(images.length, (index) {
          Asset asset = images[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xff60C757),
                  width: 8,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AssetThumb(
                  asset: asset,
                  width: 160,
                  height: 160,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = <Asset>[];
    String error = 'No Error Detected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 3,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      isEnabled=true;
      images = resultList;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    var h=MediaQuery.of(context).size.height;
    var w=MediaQuery.of(context).size.width;
    return  Scaffold(
      backgroundColor:  Color(0xff0D0D0D),
      appBar: AppBar(
        backgroundColor:  Color(0xff0D0D0D),
        title:  Text('Select Banner Picture',style: TextStyle(color: Colors.white),),
        ),
        body: Column(
          children: <Widget>[
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0,left: 22),
                  child: Text('Select Banner image (${images.length}/3).',style: TextStyle(color: Colors.white,fontSize: 16),),
                )),
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: loadAssets,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0,left: 22),
                  child: Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      color:  Color(0x10ffffff),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/imag.png',height: 40,width: 40,),
                        SizedBox(height: 10,),
                        Text('+ add  image',style: TextStyle(color: CupertinoColors.white),)
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Expanded(
              child: buildGridView(),
            ),
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
                showTopSnackBar(
                  context,
                  CustomSnackBar.success(
                    message:
                    "Added background Successfully",
                  ),
                );
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
                    child: Text('Save',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w600),),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30,)
          ],
        ),
      );
  }
}