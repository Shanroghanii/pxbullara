import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LiveScreen extends StatefulWidget {
  @override
  _LiveScreenState createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  bool isLive=false;
  void showDialog(){
    AwesomeDialog(
      dialogBackgroundColor: Color(0xff0D0D0D),
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.NO_HEADER,
      body: Center(child: Text(
        'Confirm to stop Live Stream',
        style: TextStyle(fontStyle: FontStyle.italic,fontSize: 20,color: Colors.white,fontWeight: FontWeight.w600),
      ),),

      btnOkOnPress: () {
        setState(() {
          isLive=false;
        });
      },
      btnCancelOnPress: (){},

    )..show();
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
      body: Stack(
        children: [
          Image.asset('assets/modal.png',height: double.infinity,width: double.infinity,fit: BoxFit.fill,),
          Container(
            height: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 35,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 140,
                        height: 32,
                        decoration: BoxDecoration(
                          color:  Color(0x32000000),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.asset('assets/modal.png',height: 26,width: 26,)),
                            Text('Napat_Fame',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),)
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        if(isLive==false){
                          setState(() {
                            isLive=true;
                          });
                        }
                        else{
                          showDialog();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 140,
                          height: 32,
                          decoration: BoxDecoration(
                            color:isLive?Color(0x88FF0000)  :Color(0xff6EC350),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                             Icon(isLive?Icons.cancel_rounded:Icons.play_circle_fill,color: Colors.white,),
                              Text(isLive? 'STOP LIVE':'START LIVE',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 22.0,top: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 54,
                      height: 32,
                      decoration: BoxDecoration(
                        color:  Color(0x32000000),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.visibility_sharp,color: Colors.white,),
                          Text('0',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500),)
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 405.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color:  Color(0x70000000),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(9),
                          topLeft: Radius.circular(9),

                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color:  Color(0x50000000),
                                      borderRadius: BorderRadius.circular(56),
                                    ),
                                    child: Icon(Icons.gif_sharp,color: Colors.white,size: 40,),

                                  ),
                                  SizedBox(height: 5,),
                                  Text('GIF',style: TextStyle(color: Colors.white,fontSize: 10),)
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color:  Color(0x50000000),
                                      borderRadius: BorderRadius.circular(56),
                                    ),
                                    child: Icon(Icons.image_outlined,color: Colors.white,size: 30,),

                                  ),
                                  SizedBox(height: 5,),
                                  Text('Background',style: TextStyle(color: Colors.white,fontSize: 10),)
                                ],
                              ),

                              Column(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color:  Color(0x50000000),
                                      borderRadius: BorderRadius.circular(56),
                                    ),
                                    child: Icon(Icons.text_fields_outlined,color: Colors.white,size: 30,),

                                  ),
                                  SizedBox(height: 5,),
                                  Text('Text',style: TextStyle(color: Colors.white,fontSize: 10),)
                                ],
                              ),

                              Column(
                                children: [
                                  Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      color:  Color(0x50000000),
                                      borderRadius: BorderRadius.circular(56),
                                    ),
                                    child: Icon(Icons.image,color: Colors.white,size: 30,),

                                  ),
                                  SizedBox(height: 5,),
                                  Text('Banner',style: TextStyle(color: Colors.white,fontSize: 10),)
                                ],
                              ),


                            ],
                          ),
                          // SizedBox(height: 20,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 137,
                              height: 40,
                              decoration: BoxDecoration(
                                color:  Color(0x60ffffff),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(child: Text('Close panel',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w600),)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
