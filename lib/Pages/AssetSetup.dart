import 'package:ar_live_ais/Pages/AddTextPage.dart';
import 'package:ar_live_ais/Pages/SelectImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'SelectBackgroundImage.dart';

class AssetSetup extends StatefulWidget {
  @override
  _AssetSetupState createState() => _AssetSetupState();
}

class _AssetSetupState extends State<AssetSetup> {

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
  }

  @override
  Widget build(BuildContext context) {
    var h=MediaQuery.of(context).size.height;
    var w=MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:  Color(0xff0D0D0D),
      appBar: AppBar(
        backgroundColor:  Color(0xff0D0D0D),
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Asset Setup',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
      ),
      body: Column(
        children: [
          SizedBox(height: 30,),
          Center(
            child: Container(
              height: h*0.12,
              width: w*0.86,
              decoration: BoxDecoration(
                color:  Color(0xff2A2A2A),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color:  Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.image_outlined,size: 30,color: Colors.grey[300],),

                  ),
                  SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Banner Picture',
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SelectImages()),
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Center(child: Text('Add',style: TextStyle(color: Colors.white,fontSize: 13),)),
                    ),
                  ),
                  SizedBox(width: 15,),


                ],
              ),
            ),
          ),
          SizedBox(height: 12,),
          Center(
            child: Container(
              height: h*0.12,
              width: w*0.86,
              decoration: BoxDecoration(
                color:  Color(0xff2A2A2A),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color:  Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.gif,size: 30,color: Colors.grey[300],),

                  ),
                  SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('File GIF',
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

                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Center(child: Text('Add',style: TextStyle(color: Colors.white,fontSize: 13),)),
                    ),
                  ),
                  SizedBox(width: 15,),


                ],
              ),
            ),
          ),
          SizedBox(height: 12,),
          Center(
            child: Container(
              height: h*0.12,
              width: w*0.86,
              decoration: BoxDecoration(
                color:  Color(0xff2A2A2A),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color:  Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.image,size: 30,color: Colors.grey[300],),

                  ),
                  SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Background',
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SelectBackgroundImage()),
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Center(child: Text('Add',style: TextStyle(color: Colors.white,fontSize: 13),)),
                    ),
                  ),
                  SizedBox(width: 15,),


                ],
              ),
            ),
          ),
          SizedBox(height: 12,),
          Center(
            child: Container(
              height: h*0.12,
              width: w*0.86,
              decoration: BoxDecoration(
                color:  Color(0xff2A2A2A),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  SizedBox(width: 10,),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color:  Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.text_fields_outlined,size: 30,color: Colors.grey[300],),

                  ),
                  SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Text',
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddTextPage()),
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Center(child: Text('Add',style: TextStyle(color: Colors.white,fontSize: 13),)),
                    ),
                  ),
                  SizedBox(width: 15,),


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
