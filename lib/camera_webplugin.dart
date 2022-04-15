// Browser APIs

// Web Camera
// ignore: avoid_web_libraries_in_flutter
import 'dart:async';
import 'dart:html';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:math';
//import 'package:adelante_demo/gen_profile.dart';
//import 'package:adelante_demo/getUserMedia.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
import '/clippy.dart';
//import '/A.dart';
//import 'package:adelante_demo/PrimaryButton.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase_storage/firebase_storage.dart';
//import 'dart:io' as io;
//import 'package:flutter_webrtc/flutter_webrtc.dart';
//import 'dart:convert';
//import 'dart:typed_data';
import 'package:flutter/services.dart';
//import 'package:permission_handler/permission_handler.dart';
//import 'package:camera/camera.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import '/foot_survey/S.dart';
import 'package:iambic_research/bubble_level.dart';
import 'package:delayed_display/delayed_display.dart';
import 'slide_transition.dart';
import 'dart:convert';
import 'foot_survey/S.dart';
import 'T4.dart';
import 'Tutorial.dart';
import 'VideoWeb.dart';
import 'foot_survey/video_webcapture.dart';
import 'globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);
bool rescan;
//Blob imageblb;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseAuth.instance.signInAnonymously();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  //await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: AspectRatio(
              aspectRatio: 1,
              child:MyCamera('Right','Inner'),
        ),
      ),
    ));
  }
}

class MyCamera extends StatelessWidget {
  final String side,view;
  //bool rflag,lflag;
  MyCamera(this.side,this.view);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //body: MediaQuery.of(context).orientation == Orientation.landscape? W2X():WebCamera(side, view, rflag, lflag));
        body: WebCamera(true,side, view,'generic',false));
  }
}


class WebCamera extends StatefulWidget {
  final String side,view,txt;
  final bool flag,rescan;

  //bool rflag,lflag;
  WebCamera(this.flag,this.side,this.view,this.txt,this.rescan);
  @override
  _WebCameraState createState() => _WebCameraState();
}

class _WebCameraState extends State<WebCamera> {
  //final ValueNotifier<bool> IS_PORTRAIT = ValueNotifier<bool>(true);
  String check='old';
  List<MediaDeviceInfo> _mediaDevicesList;
  Widget _camera;
  VideoElement _cameraVideo;
  //final _localRenderer = RTCVideoRenderer();
  String key = UniqueKey().toString();
  MediaStream _localStream;
  //var storageRef = firebase.storage().ref();
  bool isLoading=false;

  Future<Blob> takePicture() async {
    final videoWidth = _cameraVideo.videoWidth;
    final videoHeight = _cameraVideo.videoHeight;
    final canvas = CanvasElement(
      width: videoWidth,
      height: videoHeight,
    );
    canvas.context2D
      ..translate(videoWidth, 0)
      ..scale(-1, 1)
      ..drawImageScaled(_cameraVideo, 0, 0, videoWidth, videoHeight);
    final blob = await canvas.toBlob();
    switchCameraOff();
    return blob;
    /*return CameraImage(
      data: Url.createObjectUrl(blob),
      width: videoWidth,
      height: videoHeight,
    );*/
  }

  void setup() async{
    // Create the video element
    rescan=widget.rescan;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      _cameraVideo = VideoElement();

      // Register the camera to the video element
      // ignore: undefined_prefixed_name
      ui.platformViewRegistry
          .registerViewFactory('cameraVideo$key', (int viewId) => _cameraVideo);

      // Create the actual camera widget
      _camera = HtmlElementView(key: UniqueKey(), viewType: 'cameraVideo$key');

    //var stream = await window.navigator.mediaDevices.getUserMedia(mediaConstraints);
    //_mediaDevicesList = await window.navigator.mediaDevices.enumerateDevices();
      // Access the camera stream
     /*window.navigator
          .getUserMedia(audio: false, video:
      {'facingMode': 'environment', 'width': 1280, 'height': 720,'torch': true}
      ).then((MediaStream stream) {
        _cameraVideo
          ..srcObject = stream
          ..autoplay = true;

      });*/

      var stream = await window.navigator.mediaDevices.getUserMedia({'audio': false, 'video':
      {'facingMode': 'environment', 'width':1290,'height':750,'torch': true}});
      //var mediaDevices = await window.navigator.mediaDevices.enumerateDevices();
      //print(mediaDevices);
      _localStream = stream;
      _cameraVideo.srcObject = _localStream;
      _cameraVideo.width=1280;
      _cameraVideo.height=720;
      _cameraVideo.setAttribute("playsinline", "true");
      //_cameraVideo.setAttribute("controls", "false");
      _cameraVideo.autoplay = true;
      //await window.screen.orientation.lock('portrait');
       //elem.requestFullscreen();
       //var elem = document.querySelector("video");
       //elem.requestFullscreen();
       //var myScreenOrientation = window.screen.orientation;
       //myScreenOrientation.lock("portrait");
      // Start the camera feed
      //if (perm.state != "denied")
      //_cameraVideo.play();

  }


  @override
  void initState() {
    setup();

    //window.screen.orientation.lock('portrait');
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  switchCameraOff() {
    if (_cameraVideo.srcObject != null &&
        _cameraVideo.srcObject.active) {
      var tracks = _cameraVideo.srcObject.getTracks();

      //stopping tracks and setting srcObject to null to switch camera off
      _cameraVideo.srcObject = null;

      tracks.forEach((track) {
        track.stop();
      });
    }
  }
  @override
  void dispose() {
    // Turn the camera off
    /*final MediaStream cameraFeed = _cameraVideo.captureStream();
    cameraFeed.getVideoTracks().forEach((MediaStreamTrack track) {
      track.stop();
    });
    _cameraVideo.pause();
    _cameraVideo.removeAttribute('src');
    _cameraVideo.load();*/
    switchCameraOff();
    //PaintingBinding.instance.imageCache.clear();
    super.dispose();
  }

  void _captureOnTap() async{

    final MediaStream cameraFeed = _cameraVideo.captureStream();
    final MediaStreamTrack track = cameraFeed.getVideoTracks().first;
    final ImageCapture image = ImageCapture(track);
    final Blob imageBlob = await image.takePhoto({
      'fillLightMode': "auto", // "off", "flash"
      'redEyeReduction': true,
    });
    //await uploadImageFile(imageBlob);
    //final url = Url.createObjectUrlFromBlob(imageBlob);
    // reader = FileReader();
    //reader.readAsDataUrl(imageBlob);
    //var url = html.Url.createObjectUrl(image);
    //Navigator.pop(context, imageBlob);
    //antiside= side.toLowerCase()=='left'?'Right':'Left';
    //widget.flag=true;
    //Navigator.push(context,MaterialPageRoute(builder: (context) =>  widget.view.toLowerCase()=='top'? WT3(widget.side,widget.flag):widget.flag? A1C(side):GenProfile()));
    //SlideRoute(page: T2A(),duration: 600,direction: 'Left'),
    }

  Future<Uint8List> _getBlobData(Blob blob) {
    final completer = Completer<Uint8List>();
    final reader = FileReader();
    reader.readAsArrayBuffer(blob);
    reader.onLoad.listen((_) => completer.complete(reader.result));
    return completer.future;
  }

  Future<Blob> _convertToBlob(CanvasElement canvas) async{
    final imageBlob = await canvas.toBlob('image/jpeg', 0.8);
    return imageBlob;
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    var screenSize = MediaQuery.of(context).size;
    //screenSize.width
    double angle;
    MediaQuery.of(context).orientation == Orientation.portrait? angle=0:angle=3.14/2;
    //var elem = document.querySelector("video");
    //elem.requestFullscreen();
    //var myScreenOrientation = window.screen.orientation;
    //myScreenOrientation.lock("portrait");
    //setup();
    return Scaffold(
     body: !isLoading?
     Stack(alignment: Alignment.center,//
      children: <Widget>[
       Container(color:Colors.black,child:_camera),
        if (widget.flag == true)
        Positioned(bottom:300,
            child:Container(color: Colors.transparent,
              //width: 284,
              //height: 366,
              child:PathExample(view:widget.view,side:widget.side),
            )
        ),
        /*ClipPath(
          clipper: MyCustomClipper (),
          child: Container(color: Color.fromRGBO(0, 0, 0, 0.5),)
          ),*/
        /*IgnorePointer(
            ignoring: true,
            child:Center(child:Container(color:Colors.transparent, child:Image.asset('assets/images/Icon_Tap.png', fit: BoxFit.contain)))),*/
        Positioned(top:30,child:Text((widget.side+" Foot: "+widget.view).toUpperCase(),style:GoogleFonts.jost(fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            fontSize: 17,textStyle:TextStyle(color: HexColor('FFFFFF'),letterSpacing: 1.5,height: 1.4)))),
        /*Positioned(bottom: 50,
            child:IgnorePointer(
                ignoring: true,
                child:Text("Align paper with the outline.\nTAP ANYWHERE TO TAKE THE PICTURE.",textAlign: TextAlign.center,
                  style:GoogleFonts.jomhuria(fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      fontSize: 17,textStyle:TextStyle(color: HexColor('FFFFFF'),letterSpacing: 1,height: 1.4)),
                ))),*/
        if (widget.flag == true && !isLoading)
          GestureDetector(
            onTap: () async{
              //_captureOnTap();
              /*final MediaStream cameraFeed = _cameraVideo.captureStream();
              final MediaStreamTrack track = cameraFeed.getVideoTracks().last;
              final ImageCapture image = ImageCapture(track);
              final Blob imageBlob = await image.takePhoto();*/
              final videoWidth = _cameraVideo.videoWidth;
              final videoHeight = _cameraVideo.videoHeight;
              final canvas = CanvasElement(
                width: videoWidth,
                height: videoHeight,
              );
              canvas.context2D
                ..translate(videoWidth,0)
                ..scale(-1, 1)
                ..drawImageScaled(_cameraVideo, 0, 0, videoWidth, videoHeight)
                ;
              switchCameraOff();
              setState((){
                isLoading=true;
              });
              //final imageBlob = await canvas.toBlob();
              //uploadImageToFirebase(context);
              PaintingBinding.instance.imageCache.clear();
              Blob _imageblb= await _convertToBlob(canvas);
              //await uploadImageFile(widget.imgBlob);
              setState((){
                isLoading=false;
              });
              //Uint8List bytes = await _getBlobData(imageBlob);
              //var reader = new FileReader();
              //reader.readAsText(imageBlob);
              //print(reader.result);
              //Uint8List base64String = reader.result;
              //Uint8List bytes=base64Decode(reader.result);
              //print(bytes);

              /*setState(() {
                isLoading = true;
                //switchCameraOff();
              });*/
              //await uploadImageFile(imageBlob);
              //uploadImageFile(imageBlob);
              //Navigator.pop(context, imageBlob);
               // Navigator.push(context,MaterialPageRoute(builder: (context) =>  widget.view.toLowerCase()=='top'?MyCamera(widget.side,'Inner'):widget.view.toLowerCase()=='Inner'?MyCamera(widget.side,'Outer'):S4H(widget.side)));
              //Navigator.push(context,MaterialPageRoute(builder: (context) =>  DisplayPictureScreen2(imgBlob:bytes)));
              Navigator.push(context,MaterialPageRoute(builder: (context) =>  UploadingImageToFirebaseStorage (imgBlob: _imageblb,side:widget.side,view:widget.view,txt:widget.txt)));
              //SlideRoute(page: UploadingImageToFirebaseStorage (imgBlob: imageBlob,side:widget.side,view:widget.view,txt:widget.txt),duration: 600,direction: 'Left');
            },
          ),
        /*Positioned(top:34,right:24,child:IconButton(icon:Icon(Icons.help_outline,color: HexColor('#FFFFFF'),size: 34,),
          onPressed: () {
            /*Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => widget.view=='Top'? WT5(side,widget.rflag,widget.lflag):WT3(side,widget.rflag,widget.lflag)),
            );*/
            Navigator.of(context).pop();
          },)),*/
        //Text(check)
      ],
    ):Container(width:screenSize.width,height:screenSize.height,color:Colors.black,child:Center(child:CircularProgressIndicator())),
    );
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
    ..lineTo(size.width, 0.0)
    ..lineTo(size.width * 0.75, size.height)
    ..lineTo(size.width * 0.25, size.height)
    ..addRect(new Rect.fromLTWH(0.0, 0.0, size.width, size.height))
    ..fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}

Widget maketxt(String txt) {
  switch (txt) {
    case '21A4':
      return RichText(
        text: TextSpan(
          style: TextStyle(color: HexColor('#222222'),
              fontWeight: FontWeight.w400,
              fontFamily: 'Barlow',
              fontSize: 16),
          children:
          <TextSpan>[
            TextSpan(text: "Are the "),
            TextSpan(text: "4 corners",style: TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(text: " of the paper visible?")
          ],
        ),
      );
      break;
    case '21A5':
      return RichText(
        text: TextSpan(
          style: TextStyle(color: HexColor('#222222'),
              fontWeight: FontWeight.w400,
              fontFamily: 'Barlow',
              fontSize: 16),
          children:
          <TextSpan>[
            TextSpan(text: "Does picture "),
            TextSpan(text: "avoid heavy shadows",style: TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(text: " ?"),
          ],
        ),
      );
      break;
    case '21A6':
      return RichText(
        text: TextSpan(
          style: TextStyle(color: HexColor('#222222'),
              fontWeight: FontWeight.w400,
              fontFamily: 'Barlow',
              fontSize: 16),
          children:
          <TextSpan>[
            TextSpan(text: "Is paper perfectly flat on floor? "),
            //TextSpan(text: "",style: TextStyle(fontWeight: FontWeight.w600)),
            //TextSpan(text: " ?"),
          ],
        ),
      );
      break;
    case 'generic':
      return Container(padding:EdgeInsets.all(0),child:RichText(
        text: TextSpan(
          style: TextStyle(color: HexColor('#222222'),
            fontWeight: FontWeight.w400,
            fontFamily: 'Barlow',
            fontSize: 16,
            height:1.5,
          ),
          children:
          <TextSpan>[
            TextSpan(text: "Does picture avoid heavy shadows?\nIs paper perfectly flat on floor?\n"),
          ],
        ),
        textAlign: TextAlign.center,
      ));
      break;

  }
}

class DisplayPictureScreen2 extends StatelessWidget {
  //final String imagePath;
  final Uint8List imgBytes;
  final String txt;
  const DisplayPictureScreen2({Key key,this.imgBytes,this.txt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    //var reader = new FileReader();
    //final url = Url.createObjectUrlFromBlob(imgBlob);
    //reader.readAsDataUrl(imgBlob);
    //var base64String = reader.result;
    //var url = Url.createObjectUrl(imgBlob);
    String side='left',view='right';
    return WillPopScope(
        onWillPop: () async => false,
    child: Scaffold(backgroundColor:Colors.black,

      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Stack(alignment: Alignment.center, children:[

        Positioned(top:40,child:Text('Right Foot: Top', style: TextStyle(
          fontWeight: FontWeight.w600,fontFamily: 'Barlow',fontSize: 24,color: HexColor('#FFFFFF'),
        ))),
        //Positioned(top:35,left:width-60,child:Icon(Icons.help_outline,color: HexColor('#FFFFFF'),size: 40,)),
        //Container(height:264,width:double.infinity,color:Colors.black),
        Container(width:width,
            padding:
            const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
            margin: const EdgeInsets.only(
                top: 60, left: 0.0, right: 0.0, bottom: 0.0),
            //child:Image.file(File(imagePath),fit: BoxFit.contain)
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(pi),
                child: RotatedBox(quarterTurns: (view=='Inner' && side== 'Right') || (view=='Outer' && side== 'Left')? 1:-1,child: Image.memory(imgBytes)),
              )),

          //RotatedBox(quarterTurns: -1,child: Image.file(File(imagePath),fit: BoxFit.contain)
        //),
        Positioned(bottom:10,child:Container(width:360,
          //padding:EdgeInsets.all(16.0),
          //const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft:  const  Radius.circular(10.0),
                    topRight: const  Radius.circular(10.0))),
            child:
            Column(children:[
              Text("Review the Picture",style: TextStyle(color: HexColor('#222222'),
                  fontWeight: FontWeight.w600,
                  //fontStyle: FontStyle.italic,
                  fontFamily: 'Barlow',
                  fontSize: 24),),
              maketxt(txt),

              Row(crossAxisAlignment:CrossAxisAlignment.center,mainAxisAlignment:MainAxisAlignment.spaceEvenly,children:[
                ButtonTheme(minWidth: 152.0,height: 40.0,child:FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                  onPressed: () {Navigator.push(
                      context,
                      //MaterialPageRoute(builder: (context) => CameraScreen(flag:true,view:'Top', side:'Right')),);
                      SlideRoute(page: WebCamera(true,'Right','Top','generic',rescan),duration: 600,direction: 'Left'));
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
                )),

                ButtonTheme(minWidth: 152.0,height: 40.0,child:FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                  onPressed: () {
                    //uploadImageFile(imageBlob);
                    txt=='21A4'? Navigator.push(context,MaterialPageRoute(builder: (context) => DisplayPictureScreen2(imgBytes: imgBytes,txt:'21A5')))
                      : txt=='21A5'? Navigator.push(context,MaterialPageRoute(builder: (context) => DisplayPictureScreen2(imgBytes: imgBytes,txt:'21A6'))):
                  WebCamera(true,'Right','Top','generic',rescan);

                    //Navigator.pushNamed(context, '/onboardMarket');
                  },

                  color: HexColor('#00CED3'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text("YES",textAlign: TextAlign.center,
                      style: TextStyle(
                          color: HexColor('#222222'),//Colors.grey[800],
                          fontWeight: FontWeight.w700,
                          //fontStyle: FontStyle.italic,
                          fontFamily: 'Barlow',
                          fontSize: 16)),
                )),
              ]),

            ])
        )),
      ],
      ),
     ),
    );
  }
}




class LoadPictureScreen extends StatelessWidget {
  final String side,view;
  final String txt;
  //final Blob imgBlob;
  final Uint8List imgBlob;

  const LoadPictureScreen({Key key,this.imgBlob,this.txt,this.side,this.view}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(backgroundColor:Colors.black,

      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Stack(alignment: Alignment.center, children:[

        Positioned(top:40/640*height,child:Text(side+' Foot: '+ view, style: TextStyle(
          fontWeight: FontWeight.w600,fontFamily: 'Barlow',fontSize: 24,color: HexColor('#FFFFFF'),
        ))),
        //Positioned(top:35/640*height,left:width-65,child:Icon(Icons.help_outline,color: HexColor('#FFFFFF'),size: 40,)),
        //Container(height:264,width:double.infinity,color:Colors.black),
      Container(width:width,
            padding:
            const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
            margin: const EdgeInsets.only(
                top: 100, left: 0.0, right: 0.0, bottom: 20.0),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(pi),
              child: RotatedBox(quarterTurns: (view=='Inner' && side== 'Right') || (view=='Outer' && side== 'Left')? 1:-1,child: Image.memory(imgBlob)),//Image.network(Url.createObjectUrlFromBlob(imgBlob))),
            ))//Image.network(Url.createObjectUrlFromBlob(imageblb))
        //RotatedBox(quarterTurns: (view=='Inner' && side== 'Right') || (view=='Outer' && side== 'Left')? -1:1,child
        //RotatedBox(quarterTurns: view=='Top' || view== 'Outline'? -1:0,child: Image.file(File(imagePath),fit: BoxFit.contain))),
        //RotatedBox(quarterTurns: (view=='Inner' && side== 'Right') || (view=='Outer' && side== 'Left')? -1:1,child: Image.network(Url.createObjectUrlFromBlob(imgBlob))),
      ],
      ),
    );
  }
}


class UploadingImageToFirebaseStorage extends StatefulWidget {
  final String side,view,txt;
  //final bool firstscan;
  final Blob imgBlob;
  //final CanvasElement imgBlob;
  const UploadingImageToFirebaseStorage({Key key, this.imgBlob,this.side,this.view,this.txt}) : super(key: key);
  @override
  _UploadingImageToFirebaseStorageState createState() =>
      _UploadingImageToFirebaseStorageState();
}

class _UploadingImageToFirebaseStorageState
    extends State<UploadingImageToFirebaseStorage> {
  File imageFile;
  String txt,message1,message2,message3;
  bool isLoading = false;
  double _size = 200;
  bool done=false;
  //Uint8List imgBytes;

  Future<Uint8List> _getBlobData(Blob blob) {
    final completer = Completer<Uint8List>();
    final reader = FileReader();
    reader.readAsArrayBuffer(blob);
    reader.onLoad.listen((_) => completer.complete(reader.result));
    return completer.future;
  }
  Future pickImage() async {
    //final pickedFile = await picker.getImage(source: ImageSource.camera);
    //imgBytes= await _getBlobData(widget.imgBlob);
    setState(() {
      //imageFile=File(widget.imagePath);
      isLoading = true;
    });
  }


  void routenav(BuildContext context){

    if(widget.side=='Right') {
      switch(widget.view) {
        case 'Top':
          //globals.is1stScan = false;
          Navigator.push(
            context,
            //MaterialPageRoute(builder: (context) => T5B()),
            SlideRoute(page: rescan==false?T5B(widget.side,false):bubble_level(view: 'Inner', side: 'Right',angle: 100, rescan: true),duration:600,direction:'Left'),
          );
          break;
        case 'Inner':

          Navigator.push(
            context,
            //MaterialPageRoute(builder: (context) => T5C(widget.side)),
            SlideRoute(page: rescan==false?T5C(widget.side,false):bubble_level(view: 'Outer', side: 'Right',angle: 70, rescan: true),duration:600,direction:'Left'),
          );
          break;
        case 'Outer':
          Navigator.push(
            context,
            //MaterialPageRoute(builder: (context) => T5D(widget.side)),
            SlideRoute(page: rescan==false?T5A('Left',false):V1E('Right',true),duration:600,direction:'Left'),
          );
          break;
        case 'Outline':
          Navigator.push(
            context,
            //MaterialPageRoute(builder: (context) => TutorialList2(arg1: 'viewed',arg2:'viewed',arg3:'current')),
            SlideRoute(page: TutorialList2(arg1: 'viewed',arg2:'viewed',arg3:'current'),duration:600,direction:'Left'),
          );
          break;
      }
    }else{
      switch(widget.view) {
        case 'Top':

          Navigator.push(
            context,
            //MaterialPageRoute(builder: (context) => T7C()),
            SlideRoute(page: rescan==false?T5B(widget.side,false):bubble_level(view: 'Inner', side: 'Left',angle:100, rescan: true),duration:600,direction:'Left'),
          );
          break;
        case 'Inner':
          Navigator.push(
            context,
            //MaterialPageRoute(builder: (context) => T7D()),
            SlideRoute(page: rescan==false?T5C(widget.side,false):bubble_level(view: 'Outer', side: 'Left',angle:70, rescan: true),duration:600,direction:'Left'),
          );
          break;
        case 'Outer':
          Navigator.push(
            context,
              MaterialPageRoute(builder: (context) =>  rescan==false?V1E('Right',false):V1E('Left',true))
            //MaterialPageRoute(builder: (context) => T5D('Left')),
            //SlideRoute(page: rescan==false?V1E('Right',false):VideoWeb('Left',true),duration:600,direction:'Left'),
          );
          break;
        case 'Outline':
          Navigator.push(
            context,
            //MaterialPageRoute(builder: (context) => S0())//TutorialList2(arg1: 'viewed',arg2:'viewed',arg3:'viewed')),
            SlideRoute(page: S0(),duration:600,direction:'Left'),
          );
          break;
      }

    }
  }

  void uploadImageFile(Blob blob,
      {String imageName}) async {
    final String side=widget.side;
    final String view=widget.view;
    final FirebaseAuth _auth = FirebaseAuth.instance;
    //final currentUser = await _auth.currentUser();
    final uid = _auth.currentUser.uid;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kkmmssEEEdMMM').format(now);
    //String fileName = basename(widget.imagePath);
    String fileName = basename(widget.side+widget.view+formattedDate);
    //String fileName = 'data.json';
    fb.StorageReference storageRef = fb.storage().ref('$uid/''$side''_$view/$fileName');
    fb.UploadTaskSnapshot uploadTaskSnapshot = await storageRef.put(blob).future;
    Uri imageUri = await uploadTaskSnapshot.ref.getDownloadURL();
    setState(() {
      uploadTaskSnapshot.ref.getDownloadURL().then(
            (value) => print("Done: $value"),
      );
      //widget.side=='left'? widget.lflag=true:widget.rflag=true;
      isLoading = false;
      //PaintingBinding.instance.imageCache.clear();
    });
    //return imageUri;
  }


  Widget mywidget(BuildContext context){
    rescan==false ? message1="Next, you’ll repeat the process to scan your left foot.\n\nFor help: tap the question mark icon.":message1="Now, we’ll perform a right foot video scan.\n\nFor help: tap the question mark icon.";
    rescan==false ? message2="We’ll guide you every step of the way for the next scans.\n\nYou’ve got this!":message2="";
    rescan==false ? message3="Next, you’ll capture video scans of each foot, starting with your right.":message3="Now, we’ll perform a left foot video scan.\n\nFor help: tap the question mark icon.";
    return Column(crossAxisAlignment:CrossAxisAlignment.center,mainAxisAlignment:MainAxisAlignment.spaceEvenly,children:[
      Text("\n\nExcellent!",textAlign: TextAlign.center,
          style: TextStyle(
              color: HexColor('#00CED3'),//Colors.grey[800],
              fontWeight: FontWeight.w600,
              fontFamily: 'Barlow',
              fontSize: 32)),
      if(widget.side=='Right' && widget.view=='Outer')
        Text(message1,textAlign: TextAlign.center,
          style: TextStyle(
              color: HexColor('#222222'),//Colors.grey[800],
              fontWeight: FontWeight.w400,
              height: 1.4,
              fontFamily: 'Barlow',
              fontSize: 18)),
      if(widget.side=='Right' && widget.view=='Top')
      Text(message2,textAlign: TextAlign.center,
          style: TextStyle(
              color: HexColor('#222222'),//Colors.grey[800],
              fontWeight: FontWeight.w400,
              height: 1.4,
              fontFamily: 'Barlow',
              fontSize: 18)),
      if(widget.side=='Left' && widget.view=='Outer')
        Text(message3,textAlign: TextAlign.center,
            style: TextStyle(
                color: HexColor('#222222'),//Colors.grey[800],
                fontWeight: FontWeight.w400,
                height: 1.4,
                fontFamily: 'Barlow',
                fontSize: 18)),
      SizedBox(height: 30,),
      ButtonTheme(minWidth: 152.0,height: 40.0,child:FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
        //
        onPressed: ()
        {
          if(widget.side=='Right' && widget.view=='Top')
          Navigator.push(
            context,
            //MaterialPageRoute(builder: (context) => T5B()),
            SlideRoute(page: rescan==false?T5B(widget.side,rescan):bubble_level(view: 'Inner', side: 'Right',rescan: true),duration: 600,direction: 'Left'),
          );
          if(widget.side=='Right' && widget.view=='Outer')
            Navigator.push(
              context,
              //MaterialPageRoute(builder: (context) => T5B()),
              SlideRoute(page: rescan==false?T5A('Left',rescan):V1E('Right',true),duration: 600,direction: 'Left'),
            );
          if(widget.side=='Left' && widget.view=='Outer')
            Navigator.push(
              context,
              //MaterialPageRoute(builder: (context) => T5B()),
              SlideRoute(page: V1E('Right',rescan),duration: 600,direction: 'Left'),
            );
          //Navigator.pushNamed(context, '/onboardMarket');
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

  Future<Blob> _convertToBlob(CanvasElement canvas) async{
    final imageBlob = await canvas.toBlob();
    return imageBlob;
  }

  @override
  Widget build(BuildContext context) {
    String txt='21A7';
    Blob blb;
    double height = MediaQuery.of(context).size.height;
    double angle=widget.view=='Inner'?100:widget.view=='Outer'?70:0;
    void _updateSize() {
      setState(() {
        _size = height-100;
        done=true;
      });
    }
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(alignment: Alignment.topCenter,
          children: <Widget>[
           FutureBuilder<Uint8List>(
            future: _getBlobData(widget.imgBlob),//_convertToBlob(widget.imgBlob), // async work
            builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting: return Center(child:CircularProgressIndicator());
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else{
                    //blb=snapshot.data;
                    return LoadPictureScreen (imgBlob: snapshot.data,side:widget.side,view:widget.view,txt:widget.txt);
                  }

              }
            },
          ),
            //LoadPictureScreen (imgBlob: imageblb,side:widget.side,view:widget.view,txt:widget.txt),

          //LoadPictureScreen (imgBlob: widget.imgBlob,side:widget.side,view:widget.view,txt:widget.txt),
          //DisplayPictureScreen2(imgBytes:widget.imgBytes),
          /*FutureBuilder<Uint8List>(
            future: _getBlobData(widget.imgBlob), // async work
            builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting: return CircularProgressIndicator();
                default:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error}');
                  else
                    return Image.memory(snapshot.data);
              }
            },
          ),*/
          AnimatedContainer(duration: Duration (seconds: 1),width:double.infinity,height:700,
              padding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
              margin: EdgeInsets.only(
                  top: height-_size, left: 0.0, right: 0.0, bottom: 0.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft:  const  Radius.circular(10.0),
                      topRight: const  Radius.circular(10.0))),
              child:
              !done? Column(crossAxisAlignment:CrossAxisAlignment.center,mainAxisAlignment:MainAxisAlignment.spaceEvenly,children:[
                Text("Review Scan",style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w600,
                    //fontStyle: FontStyle.italic,
                    fontFamily: 'Barlow',
                    fontSize: 24),),
                maketxt(widget.txt),


                Row(crossAxisAlignment:CrossAxisAlignment.center,mainAxisAlignment:MainAxisAlignment.spaceEvenly,children:[
                  !isLoading ? ButtonTheme(minWidth: 152.0,height: 40.0,child:FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                    onPressed: () {Navigator.push(
                      context,
                      //MaterialPageRoute(builder: (context) => bubble_level(view:widget.view, side:widget.side)),
                      SlideRoute(page: bubble_level(view:widget.view, side:widget.side, angle: angle,),duration: 600,direction: 'Left'),
                    );},
                    color: HexColor('#FFC40F'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child:  Text("NO, RETAKE",textAlign: TextAlign.center,
                        style: TextStyle(
                            color: HexColor('#222222'),//Colors.grey[800],
                            fontWeight: FontWeight.w700,
                            //fontStyle: FontStyle.italic,
                            fontFamily: 'Barlow',
                            fontSize: 16)),
                  )):Text("Image uploading...\nThis may take few seconds.",style: TextStyle(
                      color: HexColor('#222222'),//Colors.grey[800],
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      fontFamily: 'Barlow',
                      fontSize: 16)),
                  txt=='21A4'?
                  ButtonTheme(minWidth: 152.0,height: 40.0,child:FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                    onPressed: () {
                      setState(() {
                        txt = '21A5';
                      });
                      //Navigator.pushNamed(context, '/onboardMarket');
                    },

                    color: HexColor('#00CED3'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text("YES",textAlign: TextAlign.center,
                        style: TextStyle(
                            color: HexColor('#222222'),//Colors.grey[800],
                            fontWeight: FontWeight.w700,
                            //fontStyle: FontStyle.italic,
                            fontFamily: 'Barlow',
                            fontSize: 16)),
                  )):
                  ButtonTheme(minWidth: 152.0,height: 40.0,child: !isLoading ? FlatButton(splashColor: Colors.transparent,highlightColor: Colors.transparent,
                    //!isLoading ?
                    onPressed: ()
                    async{
                      print(_size);
                      pickImage();
                      //uploadImageToFirebase(context);
                      //blb= await _convertToBlob(widget.imgBlob);
                         //await uploadImageFile(widget.imgBlob);
                      await uploadImageFile(widget.imgBlob);
                      //await uploadImageFile(imageblb);
                      rescan==false && widget.view=='Top' && widget.side=='Right' || widget.view=='Outer' && widget.side=='Right' || rescan==false && widget.view=='Outer' && widget.side=='Left'?_updateSize():routenav(context);
                      //widget.view=='Outer' && widget.side=='Right'?_updateSize():routenav(context);
                      //widget.view=='Outer' && widget.side=='Left'?_updateSize():routenav(context);
                      //Navigator.pushNamed(context, '/onboardMarket');
                    },

                    color: HexColor('#00CED3'),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text("YES",textAlign: TextAlign.center,
                        style: TextStyle(
                            color: HexColor('#222222'),//Colors.grey[800],
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Barlow',
                            fontSize: 16)),
                  ):CircularProgressIndicator(),
                  )
                ]),

              ]):DelayedDisplay(delay: Duration(milliseconds: 200),slidingBeginOffset:const Offset(0.0, 0.0),child:mywidget(context))

          ),
        ],
      ),
     ),
    );
  }

}