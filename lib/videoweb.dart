import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:ui' as ui;
import 'dart:async';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '/slide_transition.dart';
import 'package:path/path.dart';
import '/foot_survey/S.dart';
import '/bubble_level.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      home:VideoWeb('Left',false)));
}
StreamController streamController=StreamController<bool>.broadcast();
class VideoWeb extends StatefulWidget {
  final String side;
  final bool rescan;
  VideoWeb(this.side,this.rescan);
  @override
  _VideoWebState createState() => _VideoWebState();
}

class _VideoWebState extends State<VideoWeb> {
   static html.VideoElement _preview;
   static html.MediaRecorder _recorder;
   static html.VideoElement _result;
   bool vcaptured=false,isrecording=false,atEnd=false,isLoading=false,done=false;
   StreamController<bool> controller = StreamController<bool>();
   String message1,message2;
   double _size = 250.0;
   html.Blob blob = html.Blob([]);

  @override
  void initState() {
    super.initState();
    //openCamera();
    _preview = html.VideoElement()
      ..autoplay = true
      ..muted = true
      ..width = html.window.innerWidth
      ..height = html.window.innerHeight;


    _preview.setAttribute('playsinline', 'true');

    _result = html.VideoElement()
      ..autoplay = true
      ..muted = true
      ..width = html.window.innerWidth
      ..height = html.window.innerHeight
      ..controls = false;

    //_result.setAttribute('autoplay', 'true');

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('preview', (int _) => _preview);


    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('result', (int _) => _result);
    _result.setAttribute('playsinline', 'true');

    Stream stream = controller.stream;
    _result.onPause.listen(
          (event) => controller.add(_result.ended),
      onDone: () => print('Done'),
      onError: (error) => print(error),
    );

    mySetState(bool flag){
      setState(() {
        atEnd=flag;
      });
    }

    stream.listen((value) {
      mySetState(value);
    });

  }

   switchCameraOff() {
     if (_preview.srcObject != null &&
         _preview.srcObject.active) {
       var tracks = _preview.srcObject.getTracks();

       //stopping tracks and setting srcObject to null to switch camera off
       _preview.srcObject = null;

       tracks.forEach((track) {
         track.stop();
       });
     }
   }

   @override
   void dispose() async{
    switchCameraOff();
    _preview=null;
    _result=null;
    _recorder=null;
    //streamController=null;
     super.dispose();
   }



   Widget mywidget(BuildContext context){
     widget.rescan==false? message1="Almost there. You’ll repeat the process for your left foot.\n\nFor help: tap the question mark icon.":message1="You’ll repeat the process for your left foot.\n\nFor help: tap the question mark icon.";
     return Column(crossAxisAlignment:CrossAxisAlignment.center,mainAxisAlignment:MainAxisAlignment.spaceEvenly,children:[
       Text("\n\nExcellent!",textAlign: TextAlign.center,
           style: TextStyle(
               color: HexColor('#00CED3'),//Colors.grey[800],
               fontWeight: FontWeight.w600,
               fontFamily: 'Barlow',
               fontSize: 32)),
       widget.side =='Right'? Text(message1,textAlign: TextAlign.center,
           style: TextStyle(
               color: HexColor('#222222'),//Colors.grey[800],
               fontWeight: FontWeight.w400,
               height: 1.5,
               fontFamily: 'Barlow',
               fontSize: 16)):
       Text("Your scans are complete!\nYour participation in our research app gets us one step closer to mastering the art of footwear fit.  ",textAlign: TextAlign.center,
           style: TextStyle(
               color: HexColor('#222222'),//Colors.grey[800],
               fontWeight: FontWeight.w400,
               height: 1.5,
               fontFamily: 'Barlow',
               fontSize: 16)),
       SizedBox(height: 30,),
       ButtonTheme(minWidth: 152.0,height: 40.0,child:FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
         //
         onPressed: ()
         {
           if(!widget.rescan) {
             Navigator.push(
               context,
               SlideRoute(page: widget.side == 'Right' ?VideoWeb('Left',widget.rescan) : S1B(false),//V1E('Left',!rescan)
                   duration: 600,
                   direction: 'Left'),
             );
           }else{
             Navigator.push(
               context,
               SlideRoute(page: widget.side == 'Right' ? bubble_level(view: 'Top', side: 'Left',angle:100, rescan: widget.rescan):S1B(false),
                   duration: 600,
                   direction: 'Left'),
             );
           }
         },

         color: HexColor('#00CED3'),
         shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(20)),
         child: Text("CONTINUE",textAlign: TextAlign.center,
             style: TextStyle(
                 color: HexColor('#222222'),//Colors.grey[800],
                 fontWeight: FontWeight.w700,
                 fontFamily: 'Barlow',
                 fontSize: 16)),
       ))
     ]
     );

   }

  Future<html.MediaStream> openCamera() async {

    final html.MediaStream stream = await html.window.navigator.mediaDevices
        ?.getUserMedia({'audio': false, 'video':
    {'facingMode': 'environment', 'width':1280,'height':720,'frameRate': { 'exact': 15 }}});
    _preview.srcObject = stream;
    return stream;
  }

  void startRecording(html.MediaStream stream) {
    _recorder = html.MediaRecorder(stream);
    _recorder.start();

    //html.Blob blob = html.Blob([]);

    _recorder.addEventListener('dataavailable', (event) {
      blob = js.JsObject.fromBrowserObject(event)['data'];
    }, true);

    _recorder.addEventListener('stop', (event) {
      final url = html.Url.createObjectUrl(blob);
      _result.src = url;
      /*setState(() {
        vcaptured=true;
      });*/

      stream.getTracks().forEach((track) {
        if (track.readyState == 'live') {
          track.stop();
        }
      });
    });
  }

  void stopRecording() => _recorder.stop();


   void uploadImageFile(html.Blob blob,
       {String imageName}) async {
     //UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
     final String side=widget.side;
     //final String view=widget.view;
     final FirebaseAuth _auth = FirebaseAuth.instance;
     //final currentUser = await _auth.currentUser();
     final uid = _auth.currentUser.uid;
     DateTime now = DateTime.now();
     String formattedDate = DateFormat('kkmmssEEEdMMM').format(now);
     //String fileName = basename(widget.imagePath);
     String fileName = basename('video'+widget.side+formattedDate);
     //String fileName = 'data.json';
     fb.StorageReference storageRef = fb.storage().ref('$uid/''$fileName');
     fb.UploadTaskSnapshot uploadTaskSnapshot = await storageRef.put(blob).future;
     //Uri imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
     setState(() {
       uploadTaskSnapshot.ref.getDownloadURL().then(
             (value) => print("Done: $value"),
       );
       //widget.side=='left'? widget.lflag=true:widget.rflag=true;
       isLoading = false;
     });
     //return imageUri;
   }


  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    void _updateSize() {
      setState(() {
        _size = screenSize.height-100;
        done=true;
      });
    }
    if(!vcaptured)
      openCamera();
    return MaterialApp(
      title: 'Flutter Web Recording',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Stack(alignment: Alignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 0.0),
                width: screenSize.width,
                height: screenSize.height,
                color: Colors.transparent,
                child: HtmlElementView(
                  key: UniqueKey(),
                  viewType: 'preview',
                ),
              ),
              /*Container(
                margin: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () async {
                        final html.MediaStream stream = await _openCamera();
                        startRecording(stream);
                      },
                      child: Text('Start Recording'),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: () => stopRecording(),
                      child: Text('Stop Recording'),
                    ),
                  ],
                ),
              ),*/
              if(!vcaptured)
              Container(alignment: Alignment.bottomCenter,child:Padding(padding:EdgeInsets.all(16),child:FlatButton(
                onPressed: () async{

                    final html.MediaStream stream = await openCamera();
                    if(!isrecording) {
                    startRecording(stream);
                    setState(() {
                      isrecording=true;
                      vcaptured=false;
                    });
                  }else{
                    stopRecording();
                    switchCameraOff();
                    setState(() {
                      isrecording=false;
                      vcaptured=true;
                    });
                    /*stream.getTracks().forEach((track) {
                      if (track.readyState == 'live') {
                        track.stop();
                      }
                    });*/
                  }
                },
                child:!isrecording ? Icon(Icons.radio_button_checked,size: 60.0, color:Colors.red):
                DelayedDisplay(delay: Duration(milliseconds: 1000),slidingBeginOffset:const Offset(0.0, 0.0),child:Icon(Icons.stop_outlined,size: 60.0, color:Colors.white)),
                color: Colors.transparent,
                textColor: Colors.white,
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Colors.transparent,
              ))),
              if(vcaptured)
              Container(
                margin: EdgeInsets.only(bottom: 0.0),
                width: screenSize.width,
                height: screenSize.height,
                color: Colors.transparent,
                child: HtmlElementView(
                  key: UniqueKey(),
                  viewType: 'result',
                ),
              ),
                Positioned(top:15,left:screenSize.width-90,child:IconButton(icon:Icon(Icons.help_outline,color: Colors.white,size: 30),
                  onPressed: () async{
                    Navigator.push(
                        context,
                        SlideRoute(page: V1E(widget.side,widget.rescan),duration: 600,direction: 'Left'));
                    //Navigator.push(context, SlideRoute(page: V1E(widget.side,rescan),duration: 600,direction: 'Left'));
                  },)),
                Positioned(top:25,child:Text('Video: '+ widget.side +' Foot', style: TextStyle(
                  fontWeight: FontWeight.w600,fontFamily: 'Barlow',fontSize: 24,color: Colors.white),
                )),
              if(atEnd)
                Opacity(opacity: 1, child:
                AnimatedContainer(alignment: Alignment.bottomCenter, duration: Duration (seconds: 2),width:double.infinity,height:700,
                    padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                    margin: EdgeInsets.only(
                        top:screenSize.height-_size,left: 0.0, right: 0.0, bottom: 0.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                            topLeft:  const  Radius.circular(10.0),
                            topRight: const  Radius.circular(10.0))),
                    child:
                    !done? Column(crossAxisAlignment:CrossAxisAlignment.center,mainAxisAlignment:MainAxisAlignment.spaceEvenly,children:[
                      Text("Review Video",style: TextStyle(color: HexColor('#222222'),
                          fontWeight: FontWeight.w600,
                          //fontStyle: FontStyle.italic,
                          fontFamily: 'Barlow',
                          fontSize: 24),),
                      Text("Your entire foot consistently within the frame?\nFull rotation around your foot?\nNo jerky motions?",textAlign: TextAlign.center, style: TextStyle(color: HexColor('#222222'),
                          fontWeight: FontWeight.w400,
                          height:1.5,
                          fontFamily: 'Barlow',
                          fontSize: 16)),

                      Row(crossAxisAlignment:CrossAxisAlignment.center,mainAxisAlignment:MainAxisAlignment.spaceEvenly,children:[
                        !isLoading? ButtonTheme(minWidth: 152.0,height: 40.0,child:FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                          onPressed: () async{
                            openCamera();
                            setState(() {
                              isrecording=false;
                              vcaptured=false;
                              atEnd=false;
                            });
                            //Navigator.push(context,MaterialPageRoute(builder: (context) =>  VideoWebCamera(widget.side, 'Top',!rescan, false)));
                          },
                          color: HexColor('#FFC40F'),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Text("NO, RETAKE",textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: HexColor('#222222'),//Colors.grey[800],
                                  fontWeight: FontWeight.w700,
                                  //fontStyle: FontStyle.italic,
                                  fontFamily: 'Barlow',
                                  fontSize: 16)),
                        )):Text("Video uploading...\nThis may take a moment.",style: TextStyle(
                            color: HexColor('#222222'),//Colors.grey[800],
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                            fontFamily: 'Barlow',
                            fontSize: 16)),

                        ButtonTheme(minWidth: 152.0,height: 40.0,child: !isLoading? FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                          onPressed: () async{
                            setState((){
                              isLoading=true;
                            });
                            //await uploadImageToFirebase(context);
                            //print(rescan);
                            //print(widget.first_vidset);
                            //await uploadImageFile(widget.data);
                            //if(rescan==false || rescan==true && widget.side=='Right')
                            await uploadImageFile(blob);
                            _updateSize();

                            //if(widget.side == 'Left') { //&& rescan
                              //SlideRoute(page: S1B(false), duration: 600, direction: 'Left');
                            }
                          //},

                          ,color: HexColor('#00CED3'),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Text("YES",textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: HexColor('#222222'),//Colors.grey[800],
                                  fontWeight: FontWeight.w700,
                                  //fontStyle: FontStyle.italic,
                                  fontFamily: 'Barlow',
                                  fontSize: 16)),
                        ):CircularProgressIndicator()),
                      ]),

                    ]):DelayedDisplay(delay: Duration(milliseconds: 300),slidingBeginOffset:const Offset(0.0, 0.0),child:mywidget(context))
                )),
            ],
          ),
        ),
    );
  }
}



