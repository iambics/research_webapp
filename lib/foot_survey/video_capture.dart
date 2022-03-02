

import 'dart:io';
import 'dart:async';
//import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
//import 'package:thumbnails/thumbnails.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:video_compress/video_compress.dart';
import 'package:hexcolor/hexcolor.dart';
import '/slide_transition.dart';
import 'S.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:intl/intl.dart';
//import 'package:path/path.dart';

//const Color barColor = const Color(0x20000000);
/*
StreamController streamController=StreamController<bool>.broadcast();

void main() {
    runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera',
      //theme: ThemeData(
        //primarySwatch: Colors.blue,
        //brightness: Brightness.dark,
        //backgroundColor: Colors.black,
        //bottomAppBarColor: barColor,
      //),
      home: VideoPage(),
    );
  }
}

class VideoPage extends StatefulWidget {

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final _cameraKey = GlobalKey<CameraScreenState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      body: CameraScreen(
        key: _cameraKey, side:'Left'
      ),
    );
  }
}

class CameraScreen extends StatefulWidget {
  CameraScreen({Key key,@required this.side}) : super(key: key);
  final String side;

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen>
    with AutomaticKeepAliveClientMixin {
  CameraController _controller;
  List<CameraDescription> _cameras;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isRecordingMode = true;
  bool _isRecording = false;
  final _timerKey = GlobalKey<VideoTimerState>();

  @override
  void initState() {
    _initCamera();
    super.initState();
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(_cameras[0], ResolutionPreset.high,enableAudio: false);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (_controller == null || !_controller.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      _controller?.dispose();
      print('inactive)');
    } else if (state == AppLifecycleState.resumed) {
      _initCamera();
      print("resumed)");
      if (_controller != null) {
        _controller.initialize().then((_) {
          if (!mounted) {
            return;
          }
          setState(() {});
        });
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown,]);
    if (_controller != null) {
      if (!_controller.value.isInitialized) {
        return Container();
      }
    } else {
      return const Center(
        child: SizedBox(
          width: 32,
          height: 32,
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (!_controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      backgroundColor: Colors.black,
      key: _scaffoldKey,
      extendBody: true,
      body: Stack(
        children: <Widget>[
          _buildCameraPreview(),
          Positioned(
            left: 0,
            right: 0,
            top: 42.0,
            child: Text('Video: '+widget.side+' Foot',style:TextStyle(color: Colors.white,
                fontWeight: FontWeight.w600,
                height:1.5,
                fontFamily: 'Barlow',
                fontSize: 24),
                textAlign: TextAlign.center),
          ),
          Positioned(
            top: 34.0,
            right: 16.0,
            child: IconButton(
              icon: Icon(
                Icons.help_outline,
                color: Colors.white,
                size: 42,
              ),
              onPressed: () {
                //Navigator.push(context, SlideRoute(page: S4B(widget.side),duration: 600,direction: 'Left'),);

                },

            ),
          ),
          if (_isRecordingMode)
            Positioned(
              left: 0,
              right: 0,
              top: 90.0,
              child: VideoTimer(
                key: _timerKey,
              ),
            )
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildCameraPreview() {
    final size = MediaQuery.of(context).size;
    return ClipRect(
      child: Container(
        //child: Transform.scale(
          //scale: _controller.value.aspectRatio / size.aspectRatio,
          //child: Center(
            //child: AspectRatio(
              //aspectRatio: _controller.value.aspectRatio,
              child:
              CameraPreview(_controller),
            ),
          //),
        //),
      //),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      color: Colors.transparent,//Theme.of(context).bottomAppBarColor,
      height: 100.0,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          FutureBuilder(
            future: getLastImage(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container(
                  width: 40.0,
                  height: 40.0,
                );
              }
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Gallery(widget.side,streamController.stream),
                  ),
                ),
                child: Container(
                  width: 40.0,
                  height: 40.0,

                ),
              );
            },
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 25.0,
            child: IconButton(
              icon: Icon(
                //(_isRecordingMode)?
                (_isRecording) ? Icons.stop : Icons.radio_button_checked,
                    //: Icons.camera_alt,
                size: 30.0,
                color: (_isRecording) ? Colors.black : Colors.red,
              ),
              onPressed: () {
                if (!_isRecordingMode) {
                  _captureImage();
                } else {
                  if (_isRecording) {
                    stopVideoRecording();
                  } else {
                    startVideoRecording();
                  }
                }
              },
            ),
          ),
          IconButton(
            icon: Icon(
              (_isRecordingMode) ? Icons.camera_alt :
              Icons.videocam,
              color: Colors.transparent,
            ),
            onPressed: () {
              setState(() {
                //_isRecordingMode = !_isRecordingMode;
              });
            },
          ),
        ],
      ),
    );
  }

  Future<FileSystemEntity> getLastImage() async {
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/media';
    final myDir = Directory(dirPath);
    List<FileSystemEntity> _images;
    _images = myDir.listSync(recursive: true, followLinks: false);
    _images.sort((a, b) {
      return b.path.compareTo(a.path);
    });
    var lastFile = _images[0];
    var extension = path.extension(lastFile.path);
    if (extension == '.jpeg') {
      return lastFile;
    } else {
      //String thumb = await Thumbnails.getThumbnail(
          //videoFile: lastFile.path, imageType: ThumbFormat.PNG, quality: 30);
      //return File(thumb);
      //return lastFile;
    }
  }

  Future<void> _onCameraSwitch() async {
    final CameraDescription cameraDescription =
    (_controller.description == _cameras[0]) ? _cameras[1] : _cameras[0];
    if (_controller != null) {
      await _controller.dispose();
    }
    _controller = CameraController(cameraDescription, ResolutionPreset.high,enableAudio: false);
    _controller.addListener(() {
      if (mounted) setState(() {});
      if (_controller.value.hasError) {
        showInSnackBar('Camera error ${_controller.value.errorDescription}');
      }
    });

    try {
      await _controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _captureImage() async {
    print('_captureImage');
    if (_controller.value.isInitialized) {
      SystemSound.play(SystemSoundType.click);
      final Directory extDir = await getApplicationDocumentsDirectory();
      final String dirPath = '${extDir.path}/media';
      await Directory(dirPath).create(recursive: true);
      final String filePath = '$dirPath/${_timestamp()}.jpeg';
      print('path: $filePath');
      await _controller.takePicture(filePath);
      setState(() {});
    }
  }

  Future<String> startVideoRecording() async {
    print('startVideoRecording');
    if (!_controller.value.isInitialized) {
      return null;
    }
    setState(() {
      _isRecording = true;
    });
    _timerKey.currentState.startTimer();

    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/media';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${_timestamp()}.mp4';

    if (_controller.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return null;
    }

    try {
     //videoPath = filePath;
      await _controller.startVideoRecording(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  Future<void> stopVideoRecording() async {
    if (!_controller.value.isRecordingVideo) {
      return null;
    }
    _timerKey.currentState.stopTimer();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Gallery(widget.side,streamController.stream),
      ),
    );
    setState(() {
      _isRecording = false;
    });

    try {
      await _controller.stopVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  String _timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  void logError(String code, String message) =>
      print('Error: $code\nError Message: $message');

  @override
  bool get wantKeepAlive => true;
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





class VideoPreview extends StatefulWidget {
  const VideoPreview({this.videoPath,this.side});

  final String videoPath;
  final String side;
  @override
  _VideoPreviewState createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _controller = VideoPlayerController.file(File(widget.videoPath))
      ..initialize().then(
            (_) {
          setState(() {});
        },
      );
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _controller?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (_controller.value.initialized) {
      return Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            right: 0,
            top: 32.0,
            child: Text('Video: '+widget.side+' Foot',style:TextStyle(color: Colors.white,
                fontWeight: FontWeight.w600,
                height:1.5,
                fontFamily: 'Barlow',
                fontSize: 24),
                textAlign: TextAlign.center),
          ),
          Container(alignment: Alignment.topCenter,
              child: Transform.scale(
                scale: _controller.value.aspectRatio / size.aspectRatio,
                   child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                ),
              ),
            ),
          //Positioned(
            //top:80,
            //left: 0,
            //right: 0,
            Center(child: VideoControls(
              videoController: _controller, side: widget.side,
            ),
          ),
          //Positioned(top:30,left:350,child:Icon(Icons.help_outline,color: HexColor('#FFFFFF'),size: 40,)),
          //Container(height:264,width:double.infinity,color:Colors.black),
        ],
      );
    } else {
      return Container();
    }
  }
}



class VideoControls extends StatefulWidget {
  const VideoControls({this.videoController,this.side});
  final VideoPlayerController videoController;
  final String side;
  //final String currentFilePath;
  //final String side;

  @override
  _VideoControlsState createState() => _VideoControlsState();

}

class _VideoControlsState extends State<VideoControls>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Color iconColor;
  //bool isLoading=false;
  //double _size = 444.0;
  //bool done=false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 10),
    );
    widget.videoController.addListener(videoListener);
    widget.videoController.setLooping(false);
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    widget.videoController?.removeListener(videoListener);
    super.dispose();
  }

  void videoListener() {
    (widget.videoController.value.isPlaying)
        ? _animationController.forward()
        : _animationController.reverse();
    (widget.videoController.value.isPlaying)
        ? streamController.add(true)
        : streamController.add(false);
    setState(() {
      widget.videoController.value.position == widget.videoController.value.duration || widget.videoController.value.position == Duration(seconds: 0, minutes: 0, hours: 0) && !widget.videoController.value.isPlaying ?
      iconColor =Colors.white: iconColor =Colors.transparent;
    });

  }

  String timeFormatter(Duration duration) {
    return [
      if (duration.inHours != 0) duration.inHours,
      duration.inMinutes,
      duration.inSeconds,
    ].map((seg) => seg.remainder(60).toString().padLeft(2, '0')).join(':');
  }

  void _handleOnPressed() {
    widget.videoController.value.isPlaying ? null : _playVideo();
  }

  void _playVideo() {
    _animationController.forward();
    widget.videoController.seekTo(Duration.zero);
    widget.videoController.play();
  }

  void _pauseVideo() {
    _animationController.reverse();
    widget.videoController.pause();
  }



  @override
  Widget build(BuildContext context) {
    return //Container(
      //height: 80,
      //color: Colors.transparent,
      //child: Column(
       // mainAxisAlignment: MainAxisAlignment.spaceAround,
       // children: <Widget>[
        /* Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(
                  '0:00',
                  style: TextStyle(color: Colors.white),
                ),
                Expanded(
                  child: VideoProgressIndicator(
                    widget.videoController,
                    allowScrubbing: true,
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    colors: VideoProgressColors(
                      playedColor: Colors.white,
                    ),
                  ),
                ),
                Text(
                  timeFormatter(widget.videoController.value.duration),
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ), */
          Center(
            child:
            IconButton(
              iconSize: 80,
              //icon: AnimatedIcon(
                //icon: AnimatedIcons.play_pause,
                //progress: _animationController,
              icon: Icon(Icons.play_circle_filled),
                color: iconColor,
              onPressed: _handleOnPressed
            ),
          );
        //],
      //),
    //);
  }
}




class Gallery extends StatefulWidget {
   final String side;
   final Stream<bool> stream;
   //VideoPlayerController videoController;
   Gallery(this.side,this.stream);
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> {
  String currentFilePath;
  bool isLoading=false;
  double _size = 250.0;
  bool done=false;
  bool isPlaying=false;

  @override
  void initState() {
    super.initState();
    widget.stream.listen((flag) {
        mySetState(flag);
    });
  }

  mySetState(bool flag){
    setState(() {
      isPlaying=flag;
    });
  }

  compressvideo(String videopath) async{
    await VideoCompress.setLogLevel(0);
    //await VideoCompress.deleteAllCache();
    try {
      MediaInfo mediaInfo = await VideoCompress.compressVideo(
        videopath,
        //quality: VideoQuality.MediumQuality,
        deleteOrigin: false,
        //includeAudio: true,
        frameRate: 15,
      );
      return mediaInfo.path;
    }catch(e){
      return currentFilePath;
    }
  }

  Future uploadImageToFirebase(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser;
    //final user = auth.currentUser;
    //FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final uid = user.uid;
    final videofile=File(currentFilePath);
    final compvideofile=await compressvideo(currentFilePath);
    //final String side=widget.side;
    //final String view=widget.view;
    //String fileName = basename(widget.imagePath);
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    String fileName = widget.side+timestamp+'.mp4';
    FirebaseStorage storage=FirebaseStorage.instance;
    Reference ref = storage.ref().child('UserId/$uid/footvideos/$fileName');
    UploadTask uploadTask2 =ref.putFile(File(compvideofile));
    var taskSnapshot2 = await uploadTask2;

    setState(() {
      taskSnapshot2.ref.getDownloadURL().then(
            (value) => print("Done: $value"),
      );
      isLoading = false;
    });
    final dir = Directory(compvideofile);
    dir.deleteSync(recursive: true);
  }
  _deleteFile() {
    final dir = Directory(currentFilePath);
    dir.deleteSync(recursive: true);
    print('deleted');
    setState(() {});
  }


  Widget mywidget(BuildContext context){
    return Column(crossAxisAlignment:CrossAxisAlignment.center,mainAxisAlignment:MainAxisAlignment.spaceEvenly,children:[
      Text("\n\nExcellent!",textAlign: TextAlign.center,
          style: TextStyle(
              color: HexColor('#00CED3'),//Colors.grey[800],
              fontWeight: FontWeight.w600,
              fontFamily: 'Barlow',
              fontSize: 32)),
      widget.side =='Right'? Text("Almost there. Now that you’ve captured your right foot, the left foot is the final step!\n\nYou’ve got this! ",textAlign: TextAlign.center,
          style: TextStyle(
              color: HexColor('#222222'),//Colors.grey[800],
              fontWeight: FontWeight.w400,
              height: 1.4,
              fontFamily: 'Barlow',
              fontSize: 24)):
      Text("Your scans are complete!\nYour participation in our research app gets us one step closer to mastering the art of footwear fit.  ",textAlign: TextAlign.center,
          style: TextStyle(
              color: HexColor('#222222'),//Colors.grey[800],
              fontWeight: FontWeight.w400,
              height: 1.4,
              fontFamily: 'Barlow',
              fontSize: 24)),
      SizedBox(height: 30,),
      ButtonTheme(minWidth: 152.0,height: 40.0,child:FlatButton(
        //
        onPressed: ()
        {
          //Navigator.push(context, SlideRoute(page: widget.side =='Right'? S4B('Left'):S1C(),duration: 600,direction: 'Right'),
          //);
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
    void _updateSize() {
      setState(() {
        _size = height-100;
        done=true;
      });
    }
    return Scaffold(
      backgroundColor: Colors.black,
      //appBar: AppBar(
        //backgroundColor: Colors.black,
      //),
      body: Stack(children:[
        FutureBuilder(
        future: _getAllImages(),
        builder: (context, AsyncSnapshot<List<FileSystemEntity>> snapshot) {
          if (!snapshot.hasData || snapshot.data.isEmpty) {
            return Container();
          }
          print('${snapshot.data.length} ${snapshot.data}');
          if (snapshot.data.length == 0) {
            return Center(
              child: Text('No images found.'),
            );
          }

          return PageView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              currentFilePath = snapshot.data[index].path;
              var extension = path.extension(snapshot.data[index].path);
              if (extension == '.jpeg') {
                return Container(
                  height: 300,
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Image.file(
                    File(snapshot.data[index].path),
                  ),
                );
              } else {
                return VideoPreview(
                  videoPath: snapshot.data[index].path, side: widget.side,
                );
              }
            },
          );
        },
      ),
        if(!isPlaying)
        Opacity(opacity: 1, child:
        AnimatedContainer(duration: Duration (seconds: 1),width:double.infinity,height:700,
            padding:
            const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            margin: EdgeInsets.only(
                top:height-_size, left: 0.0, right: 0.0, bottom: 0.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                    topLeft:  const  Radius.circular(10.0),
                    topRight: const  Radius.circular(10.0))),
            child:
            !done? Column(crossAxisAlignment:CrossAxisAlignment.center,mainAxisAlignment:MainAxisAlignment.spaceEvenly,children:[
              Text("Review the Video",style: TextStyle(color: HexColor('#222222'),
                  fontWeight: FontWeight.w600,
                  //fontStyle: FontStyle.italic,
                  fontFamily: 'Barlow',
                  fontSize: 24),),
              Text("Your entire foot consistently within the frame?\nCapture a full circle around your foot?\nRemain still?",textAlign: TextAlign.center, style: TextStyle(color: HexColor('#222222'),
                  fontWeight: FontWeight.w400,
                  height:1.5,
                  fontFamily: 'Barlow',
                  fontSize: 16)),

              Row(crossAxisAlignment:CrossAxisAlignment.center,mainAxisAlignment:MainAxisAlignment.spaceEvenly,children:[
                !isLoading? ButtonTheme(minWidth: 152.0,height: 40.0,child:FlatButton(
                  onPressed: () {
                    _deleteFile();
                    Navigator.push(
                      context,
                      SlideRoute(page: CameraScreen(side:widget.side),duration: 600,direction: 'Right'),
                    );
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
                )):Text("Video uploading...\nThis may take a moment."),

                ButtonTheme(minWidth: 152.0,height: 40.0,child: !isLoading? FlatButton(
                  onPressed: () async{
                    setState((){
                      isLoading=true;
                    });
                    await uploadImageToFirebase(context);
                    _updateSize();
                    _deleteFile();

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
        )) 
      ]
      )
    );
  }

  Future<List<FileSystemEntity>> _getAllImages() async {
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/media';
    final myDir = Directory(dirPath);
    List<FileSystemEntity> _images;
    _images = myDir.listSync(recursive: true, followLinks: false);
    _images.sort((a, b) {
      return b.path.compareTo(a.path);
    });
    return _images;
  }
}*/

