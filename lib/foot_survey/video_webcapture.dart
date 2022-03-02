import 'dart:async';
import 'dart:html';
import 'dart:ui' as ui;
import 'dart:js' as js;
//import 'package:adelante_demo/gen_profile.dart';
//import 'package:adelante_demo/getUserMedia.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter/material.dart';
//import 'package:adelante_demo/clippy.dart';
//import 'package:adelante_demo/A.dart';
//import 'package:adelante_demo/PrimaryButton.dart';
//import 'package:firebase/firebase.dart' as fb;
//import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase/firebase.dart' as fb;
//import 'dart:io' as io;
//import 'package:flutter_webrtc/flutter_webrtc.dart';
//import 'dart:convert';
//import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:iambic_research/T4.dart';
import 'package:path/path.dart';
//import 'package:permission_handler/permission_handler.dart';
//import 'package:camera/camera.dart';
//import 'package:intl/intl.dart';
//import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import '/slide_transition.dart';
import 'S.dart';
import '/bubble_level.dart';
import '/camera_webplugin.dart';


StreamController streamController=StreamController<bool>.broadcast();
//bool first_vidset=true;


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
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
              child:MyCamera('Right','Inner',false,false)),
        ),
      ),
    );
  }
}

class VideoTimer extends StatefulWidget {
  const VideoTimer({Key key}) : super(key: key);
  @override
  VideoTimerState createState() => VideoTimerState();
}
class VideoTimerState extends State<VideoTimer> {
  Timer _timer;
  int _start = 0;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          _start = _start + 1;
        },
      ),
    );
  }

  void stopTimer() {
    _start = 0;
    _timer?.cancel();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: const Color(0x40000000),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.fiber_manual_record,
                size: 16.0,
                color: Colors.red,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                child: Text(
                  timeFormatter(Duration(seconds: _start)),
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String timeFormatter(Duration duration) {
    return [
      if (duration.inHours != 0) duration.inHours,
      duration.inMinutes,
      duration.inSeconds,
    ].map((seg) => seg.remainder(60).toString().padLeft(2, '0')).join(':');
  }
}


class blobUrlPlayer extends StatefulWidget {
  final String source,side;
  final Blob data;
  final bool first_vidset;
  final Stream<bool> stream;

  blobUrlPlayer({Key key, @required this.source,this.side,this.data,this.stream,this.first_vidset}) : super(key: key);

  @override
  _blobUrlPlayerState createState() => _blobUrlPlayerState();
}
class _blobUrlPlayerState extends State<blobUrlPlayer> {
  // Widget _iframeWidget;
  final videoElement = VideoElement();
  bool done=false,isLoading=false,isPlaying=false, atEnd=false;
  double _size = 250.0;
  String message1,message2;
  StreamController<bool> controller = StreamController<bool>();
  //var stream = document.getElementsByTagName('video');
  @override
  void initState() {
    super.initState();
    videoElement
      ..src = widget.source
      ..autoplay = false
      ..controls = false
      ..style.border = 'none'
      ..style.height = '100%'
      ..style.width = '100%';

    // Allows Safari iOS to play the video inline
    videoElement.setAttribute('playsinline', 'true');

    // Set autoplay to false since most browsers won't autoplay a video unless it is muted
    videoElement.setAttribute('autoplay', 'false');

    Stream stream = controller.stream;
    print(videoElement.paused);
    print(videoElement.ended);
    videoElement.onPause.listen((Event _){
      controller.add(videoElement.ended);
    });
    //controller.add(videoElement.paused);

    stream.listen((value) {
      print('Value from controller: $value');
      mySetState(value);
    });


    //if (videoElement.paused) {
    //  videoElement.play();
    //}

    //ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        widget.source, (int viewId) => videoElement);

    widget.stream.listen((flag) {
      mySetState(flag);
    });

  }

  mySetState(bool flag){
    setState(() {
      //isPlaying=flag;
      atEnd=flag;
    });
  }

  void uploadImageFile(Blob blob,
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

  Widget mywidget(BuildContext context){
    rescan==false? message1="Almost there. You’ll repeat the process for your left foot.\n\nFor help: tap the question mark icon.":message1="You’ll repeat the process for your left foot.\n\nFor help: tap the question mark icon.";
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
          if(!rescan) {
            Navigator.push(
              context,
              SlideRoute(page: widget.side == 'Right' ? S4('Left',!rescan) : S1B(false),
                  duration: 600,
                  direction: 'Left'),
            );
          }else{
            Navigator.push(
              context,
              SlideRoute(page: widget.side == 'Right' ? bubble_level(view: 'Top', side: 'Left',angle:100, rescan: rescan):S1B(false),
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    print('Value from controller: $isPlaying');
    void _updateSize() {
      setState(() {
        _size = height-100;
        done=true;
      });
    }

    return Scaffold(body:
    Stack(children:[
      Transform.rotate(child:HtmlElementView(
        key: UniqueKey(),
        viewType: widget.source,
      ),angle:3.14159),
      /*Positioned(
        left: 0,
        right: 0,
        top: 32.0,
        child: Text('Video: '+widget.side+' Foot',style:TextStyle(color: Colors.white,
            fontWeight: FontWeight.w600,
            height:1.5,
            fontFamily: 'Barlow',
            fontSize: 24),
            textAlign: TextAlign.center),
      ),*/
      if(atEnd)
        Opacity(opacity: 1, child:
        AnimatedContainer(alignment: Alignment.bottomCenter, duration: Duration (seconds: 2),width:double.infinity,height:700,
            padding:
            const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            margin: EdgeInsets.only(
                 top:height-_size,left: 0.0, right: 0.0, bottom: 0.0),
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
                  onPressed: () {
                    //_deleteFile();
                    /*Navigator.push(
                      context,
                      SlideRoute(page: VideoWebCamera(side, view, rflag, lflag)),duration: 600,direction: 'Right'),
                    );*/
                    Navigator.push(context,MaterialPageRoute(builder: (context) =>  VideoWebCamera(widget.side, 'Top',!rescan, false)));
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
                    print(rescan);
                    print(widget.first_vidset);
                    await uploadImageFile(widget.data);
                    //if(rescan==false || rescan==true && widget.side=='Right')
                     _updateSize();

                    if(widget.side == 'Left') { //&& rescan
                      SlideRoute(
                          page: S1B(false), duration: 600, direction: 'Left');
                      }
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
                ):CircularProgressIndicator()),
              ]),

            ]):DelayedDisplay(delay: Duration(milliseconds: 300),slidingBeginOffset:const Offset(0.0, 0.0),child:mywidget(context))
        )),
      /*if(atEnd)
         Center(child:IconButton(onPressed: (){
           videoElement.play();
         }, icon: Icon(Icons.play_circle_outline,size: 40)))*/
    ])
    );
  }
}

class MyCamera extends StatelessWidget {
  final String side,view;
  bool rflag,lflag;
  MyCamera(this.side,this.view,this.rflag,this.lflag);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: MediaQuery.of(context).orientation == Orientation.landscape? W2X():VideoWebCamera(side, view, rflag, lflag));
        body: VideoWebCamera(side, view, rflag, lflag));
  }
}

class WebRecorder {
  static bool isNotRecording = true;
  static MediaRecorder recorder;
  Widget camera;
  VideoElement _cameraVideo;
  String key = UniqueKey().toString();
  MediaStream _localStream;
  final Function whenRecorderStart; // Function to call when recording starts
  final Function whenRecorderStop; // Function to call when recording finishs
  final Function whenReceiveData;
  //final Widget camera;
  WebRecorder({
    @required this.whenRecorderStart,
    @required this.whenRecorderStop,
    @required this.whenReceiveData,
    //@required this.camera
  });

  openRecorder() {

    WebRecorder.isNotRecording = !WebRecorder.isNotRecording;
    if(WebRecorder.isNotRecording)
      stopRecording().whenComplete(whenRecorderStop);
    else

      window.navigator.mediaDevices.getUserMedia({'audio': false, 'video':
      {'facingMode': 'environment', 'width':1280,'height':720,'frameRate': { 'exact': 15 }}})
          .then((stream) {
        _cameraVideo = VideoElement();
        //ignore: undefined_prefixed_name
        ui.platformViewRegistry
            .registerViewFactory('cameraVideo$key', (int viewId) => _cameraVideo);
        camera = HtmlElementView(key: UniqueKey(), viewType: 'cameraVideo$key');
        _cameraVideo.srcObject = stream;
        _cameraVideo.setAttribute("playsinline", "true");
        _cameraVideo.autoplay = true;
        recorder = MediaRecorder(stream);
        //var options = {'mimeType': 'video/webm; codecs=vp8'};
        //var options= {'mimeType':'video/mp4;codecs:h264'};
        //recorder = MediaRecorder(stream, options);
        //recorder = MediaRecorder(stream);
        recorder.addEventListener('dataavailable', handlerFunctionStream);

        //recorder.addEventListener(type, (event) => null)
      })
          .whenComplete((){
        startRecording().whenComplete(whenRecorderStart);
      })
          .catchError((e)=> print);


    // Register the camera to the video element
    // ignore: undefined_prefixed_name
  }


  Future<void> startRecording(){
    WebRecorder.recorder.start();
    return Future.value(true);
  }

  Future<void> stopRecording() async{
    WebRecorder.recorder.stop();
    return Future.value(true);
  }

  handlerFunctionStream(event) async{
    FileReader reader = FileReader();
    Blob blob = js.JsObject.fromBrowserObject(event)['data'];
    //final url = Url.createObjectUrlFromBlob(blob);
    //_controller = VideoPlayerController.network(url);
    //reader.readAsArrayBuffer(blob);
    reader.readAsDataUrl(blob);
    reader.onLoadEnd.listen((e) async {
      //setData(reader.result);
      setData(blob);
    });
  }

  setData(data) => whenReceiveData(data);

  dispose(){
    WebRecorder.recorder.removeEventListener('dataavailable', handlerFunctionStream);
    WebRecorder.recorder = null;

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
}

class VideoWebCamera extends StatefulWidget {
  final String side,view;
  bool rflag,lflag;
  VideoWebCamera(this.side,this.view,this.rflag,this.lflag);
  @override
  _VideoWebCameraState createState() => _VideoWebCameraState();
}

class _VideoWebCameraState extends State<VideoWebCamera> {
  //final ValueNotifier<bool> IS_PORTRAIT = ValueNotifier<bool>(true);
  WebRecorder webRecorder;
  String check='old';
  List<MediaDeviceInfo> _mediaDevicesList;
  Widget _camera;
  VideoElement _cameraVideo;
  //final _localRenderer = RTCVideoRenderer();
  String key = UniqueKey().toString();
  MediaStream _localStream;
  //var storageRef = firebase.storage().ref();
  bool isLoading=false;
  bool isRecording=false;
  bool videoCaptured=false;
  bool startedPlaying = false;
  String url;
  Blob dataBlob;
  MediaRecorder mediaRecorder;
  List<Blob> audioBlobParts;
  String _recordingUrl;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _timerKey = GlobalKey<VideoTimerState>();

  /*Future<Blob> takePicture() async {
    final videoWidth = _cameraVideo.videoWidth;
    final videoHeight = _cameraVideo.videoHeight;
    /*final canvas2 = CanvasElement(
      width: videoWidth,
      height: videoHeight,
    );*/
    //var stream2 = canvas2.captureStream(25);
    //var options = { 'mimeType': "video/webm; codecs=vp9" };
    //var video = document.querySelector('video');
    //. = stream2;
    //var mediaRecorder = new MediaRecorder(stream2, options);
    //mediaRecorder.start();
    //mediaRecorder.
    //var recordedVideo = document.querySelector('video#recorded');
    //var recordButton = document.querySelector('button#record');
    /*recordButton.addEventListener('click', (event) => {
    if (recordButton.onKeyPress == 'Start Recording') {
        //startRecording();
  } else {


    }
    });*/
    final canvas = CanvasElement(
      width: videoWidth,
      height: videoHeight,
    );
    canvas.context2D
      ..translate(videoWidth, 0)
      ..scale(-1, 1)
      ..drawImageScaled(_cameraVideo, 0, 0, videoWidth, videoHeight);
    final blob = await canvas.toBlob();
    return blob;
    /*return CameraImage(
      data: Url.createObjectUrl(blob),
      width: videoWidth,
      height: videoHeight,
    );*/
  }*/

  void setup() async{
    // Create the video element
    //WebRecorder webRecorder;
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
    webRecorder = WebRecorder(
        whenRecorderStart: whenRecorderStart,
        whenRecorderStop: whenRecorderStop,
        whenReceiveData: receiveData
    );
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
    PaintingBinding.instance.imageCache.clear();
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



  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    var screenSize = MediaQuery.of(context).size;
    //first_vidset=widget.rflag;
    //screenSize.width
    double angle;
    MediaRecorder recorder;
    MediaQuery.of(context).orientation == Orientation.portrait? angle=0:angle=3.14/2;
    //var elem = document.querySelector("video");
    //elem.requestFullscreen();
    //var myScreenOrientation = window.screen.orientation;
    //myScreenOrientation.lock("portrait");
    return Scaffold(body:
    Stack(alignment: Alignment.center, children:[
      !videoCaptured? Container(color:Colors.black,child:_camera): blobUrlPlayer(source: url,side: widget.side,data:dataBlob,stream: streamController.stream,first_vidset: true),/*FutureBuilder<bool>(
        future: started(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.data == true) {
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            );
          } else {
            return const Text('waiting for video to load');
          }
        },
      ),*/
      /*if (isRecording)
        Positioned(
          left: 0,
          right: 0,
          top: 90.0,
          child: VideoTimer(
            key: _timerKey,
          ),
        ),*/
      Container(alignment: Alignment.bottomCenter,child:
      !videoCaptured? Padding(padding:EdgeInsets.all(16),child:FlatButton(
          onPressed: () {
            webRecorder.openRecorder();
            setState(() {

            });
            //webRecorder.openRecorder();
          },
          /*child: Icon(
            !WebRecorder.isNotRecording ? Icons.stop_outlined:Icons.radio_button_checked,
            size: 60.0,
            color: !WebRecorder.isNotRecording ? Colors.white : Colors.red,
          ),*/
          child:WebRecorder.isNotRecording ? Icon(Icons.radio_button_checked,size: 60.0, color:Colors.red):
          DelayedDisplay(delay: Duration(milliseconds: 1000),slidingBeginOffset:const Offset(0.0, 0.0),child:Icon(Icons.stop_outlined,size: 60.0, color:Colors.white)),
          color: Colors.transparent,
          textColor: Colors.white,
          disabledColor: Colors.grey,
          disabledTextColor: Colors.black,
          padding: EdgeInsets.all(8.0),
          splashColor: Colors.transparent,
        )):null,
      ),
      if(videoCaptured)
        Positioned(top:15,left:screenSize.width-90,child:IconButton(icon:Icon(Icons.help_outline,color: HexColor('#FFFFFF'),size: 30),
          onPressed: () {
            //Navigator.of(context).pop();S4(widget.side,widget.rflag)
            Navigator.push(
                context,
            SlideRoute(page: S4(widget.side,rescan),duration: 600,direction: 'Left'));
          },)),
      if(WebRecorder.isNotRecording)
        Positioned(top:25,child:Text('Video: '+ widget.side +' Foot', style: TextStyle(
          fontWeight: FontWeight.w600,fontFamily: 'Barlow',fontSize: 24,color: HexColor('#FFFFFF'),
        ))),
    ]
    )
    );
  }
  receiveData(data){
    // TODO Your logic to use this Uint8List data
    switchCameraOff();
    dataBlob=data;
    url = Url.createObjectUrlFromBlob(data);
    //_controller = VideoPlayerController.network(url);
    setState(() {
      videoCaptured=true;
    });
    //print(url);
    //print(data);
  }

  whenRecorderStart(){
    print('Recorder Started');
    //_timerKey.currentState.startTimer();
    setState(() {
      isRecording=true;
      _camera= webRecorder.camera;
    });
  }

  whenRecorderStop(){
    print('Recorder Stopped');
    //_timerKey.currentState.stopTimer();
    webRecorder.switchCameraOff();
    setState(() {
      isRecording=false;
    });
  }
}

