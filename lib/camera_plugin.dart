import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
//import 'package:iambic_research/Genprofile.dart';
import 'T4.dart';
import 'bubble_level.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' show join;
import 'clippy.dart';
import 'package:path/path.dart';
import 'package:hexcolor/hexcolor.dart';
import 'Tutorial.dart';
import 'slide_transition.dart';
import 'package:delayed_display/delayed_display.dart';
import 'foot_survey/S.dart';
import 'package:intl/intl.dart';
import 'package:image/image.dart' as img;
import 'package:exif/exif.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accelerometer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CameraScreen(flag:true,view:'Top', side:'Right',txt:'generic'),
    );
  }
}


class CameraScreen extends StatefulWidget {
  const CameraScreen({Key key,@required this.flag,@required this.view,@required this.side,this.txt}) : super(key: key);
  final bool flag;
  final String view,side,txt;

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  CameraController _controller;
  List<CameraDescription> _cameras;
  Future<void> _initializeControllerFuture;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //final _timerKey = GlobalKey<VideoTimerState>();

  @override
  void initState() {
    super.initState();
    _initCamera();
    WidgetsBinding.instance.addObserver(this);
  }

  /*
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _controller != null
          ? _initializeControllerFuture = _controller.initialize()
          : null; //on pause camera disposed so we need call again "issue is only for android"
    }
  }*/

  Future<void> _initCamera() async {
    _cameras = await availableCameras();
    _controller = CameraController(_cameras[0], ResolutionPreset.high,enableAudio: false);
    //_initializeControllerFuture = _controller.initialize();
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
    WidgetsBinding.instance.removeObserver(this);
  }


  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    //super.build(context);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,]);
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

    Widget _buildCameraPreview() {
      final size = MediaQuery.of(context).size;
      return ClipRect(
        child: Container(
          child: Transform.scale(
            scale: _controller.value.aspectRatio/size.aspectRatio,
            child: Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: CameraPreview(_controller),
              ),
            ),
          ),
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
      body: Stack(alignment: Alignment.center,
        children: <Widget>[
          _buildCameraPreview(),
           Positioned(top:50,child:Text(widget.side+" Foot: "+widget.view,style: TextStyle(fontWeight: FontWeight.w600,
                                fontFamily: 'Barlow',fontSize: 24,color: HexColor('#FFFFFF')))),

          if (widget.flag == true)
            new Center(
                child:Container(
                  //width: 284,
                  //height: 366,
                  child:PathExample(view:widget.view,side:widget.side),
                )
            ),
          if (widget.flag == true)
            new GestureDetector(
              onTap: () async {
                // Take the Picture in a try / catch block. If anything goes wrong,
                // catch the error.
                try {
                  // Ensure that the camera is initialized.
                  //await _initializeControllerFuture;

                  // Construct the path where the image should be saved using the
                  // pattern package.
                  final path = join(
                    // Store the picture in the temp directory.
                    // Find the temp directory using the `path_provider` plugin.
                    (await getTemporaryDirectory()).path,
                    '${DateTime.now()}.png',
                  );

                  // Attempt to take a picture and log where it's been saved.
                  await _controller.takePicture(path);
                  await(fixExifRotation(path,widget.side,widget.view));
                  //final img.Image capturedImage = img.decodeImage(await File(path).readAsBytes());
                  //final img.Image orientedImage = img.bakeOrientation(capturedImage);
                  //await File(path).writeAsBytes(img.encodeJpg(orientedImage));
                  // If the picture was taken, display it on a new screen.
                  Navigator.push(
                    context,
                    //MaterialPageRoute(builder: (context) => UploadingImageToFirebaseStorage (imagePath: path,side:widget.side,view:widget.view,txt:widget.txt),),
                    SlideRoute(page: UploadingImageToFirebaseStorage (imagePath: path,side:widget.side,view:widget.view,txt:widget.txt),duration: 600,direction: 'Left'),

                  );
                } catch (e) {
                  // If an error occurs, log the error to the console.
                  print(e);
                }


              },
            ),

        ],
      ),
      //bottomNavigationBar: _buildBottomNavigationBar(),
    );

    //bottomNavigationBar: _buildBottomNavigationBar(),

  }


  //String _timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  void logError(String code, String message) =>
      print('Error: $code\nError Message: $message');

  @override
  bool get wantKeepAlive => true;
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath),fit: BoxFit.contain),
    );
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
            TextSpan(text: "Does the picture "),
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
            TextSpan(text: "Is the paper "),
            TextSpan(text: "free of wrinkles",style: TextStyle(fontWeight: FontWeight.w600)),
            TextSpan(text: " ?"),
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
            TextSpan(text: "Does the picture avoid heavy shadows?\n            Is the paper wrinkle-free?\n   Are there at least 3 corners visible? "),
          ],
        ),
      ));
      break;

  }
}



class DisplayPictureScreen2 extends StatelessWidget {
  final String imagePath;
  final String txt;
  const DisplayPictureScreen2({Key key,this.imagePath,this.txt}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(backgroundColor:Colors.black,

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
              top: 136, left: 0.0, right: 0.0, bottom: 0.0),
            child:Image.file(File(imagePath),fit: BoxFit.contain)
          //RotatedBox(quarterTurns: -1,child: Image.file(File(imagePath),fit: BoxFit.contain)
          ),//),
         Container(
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
             //maketxt(txt),

            Row(crossAxisAlignment:CrossAxisAlignment.center,mainAxisAlignment:MainAxisAlignment.spaceEvenly,children:[
              ButtonTheme(minWidth: 152.0,height: 40.0,child:FlatButton(
                onPressed: () {Navigator.push(
                  context,
                  //MaterialPageRoute(builder: (context) => CameraScreen(flag:true,view:'Top', side:'Right')),);
                    SlideRoute(page: CameraScreen(flag:true,view:'Top', side:'Right'),duration: 600,direction: 'Left'));
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

              ButtonTheme(minWidth: 152.0,height: 40.0,child:FlatButton(
                onPressed: () {txt=='21A4'? Navigator.push(context,MaterialPageRoute(builder: (context) => DisplayPictureScreen2(imagePath: imagePath,txt:'21A5')))
                : txt=='21A5'? Navigator.push(context,MaterialPageRoute(builder: (context) => DisplayPictureScreen2(imagePath: imagePath,txt:'21A6'))):
                CameraScreen(flag:true,view:'Top', side:'Right',txt:'21A6');

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
        ),
              ],
            ),
          );
  }
}

Future<File> fixExifRotation(String imagePath, String side, String view) async {
  final originalFile = File(imagePath);
  List<int> imageBytes = await originalFile.readAsBytes();
  final originalImage = img.decodeImage(imageBytes);

  final height = originalImage.height;
  final width = originalImage.width;

  // Let's check for the image size
  if (height >= width) {
    // I'm interested in portrait photos so
    // I'll just return here
    return originalFile;
  }

  // We'll use the exif package to read exif data
  // This is map of several exif properties
  // Let's check 'Image Orientation'
  final exifData = await readExifFromBytes(imageBytes);
  img.Image fixedImage;

  try {
    if (height < width) {
      //logger.logInfo('Rotating image necessary');
      // rotate
      if (exifData['Image Orientation'].printable.contains('Horizontal')) {
        fixedImage = img.copyRotate(originalImage, 90);
      } else if (exifData['Image Orientation'].printable.contains('180')) {
        fixedImage = img.copyRotate(originalImage, -90);
      } else if (exifData['Image Orientation'].printable.contains('CCW')) {
        fixedImage = img.copyRotate(originalImage, 180);
      } else {
        fixedImage = img.copyRotate(originalImage, 0);
      }
    }
  } catch (e) {
    print('error');
    (view=='Outer' && side== 'Right') || (view=='Inner' && side== 'Left')? fixedImage = img.copyRotate(originalImage, -90):fixedImage = img.copyRotate(originalImage, 90);

}

  // Here you can select whether you'd like to save it as png
  // or jpg with some compression
  // I choose jpg with 100% quality
  final fixedFile = await originalFile.writeAsBytes(img.encodeJpg(fixedImage));
  return fixedFile;
}


class LoadPictureScreen extends StatelessWidget {
  final String imagePath,side,view;
  final String txt;

  const LoadPictureScreen({Key key,this.imagePath,this.txt,this.side,this.view}) : super(key: key);
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
                top: 136, left: 0.0, right: 0.0, bottom: 20.0),
            child:RotatedBox(quarterTurns: (view=='Inner' && side== 'Right') || (view=='Outer' && side== 'Left')? -1:1,child: Image.file(File(imagePath),fit: BoxFit.contain))),
            //RotatedBox(quarterTurns: view=='Top' || view== 'Outline'? -1:0,child: Image.file(File(imagePath),fit: BoxFit.contain))),
      ],
      ),
    );
  }
}

class UploadingImageToFirebaseStorage extends StatefulWidget {
  final String imagePath,side,view,txt;
  const UploadingImageToFirebaseStorage({Key key, this.imagePath,this.side,this.view,this.txt}) : super(key: key);
  @override
  _UploadingImageToFirebaseStorageState createState() =>
      _UploadingImageToFirebaseStorageState();
}

class _UploadingImageToFirebaseStorageState
    extends State<UploadingImageToFirebaseStorage> {
  File imageFile;
  String txt;
  bool isLoading = false;
  double _size = 250;
  bool done=false;

  Future pickImage() async {
    //final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      imageFile=File(widget.imagePath);
      isLoading = true;
    });
  }

  void routenav(BuildContext context){

    if(widget.side=='Right'){
      switch(widget.view) {
        case 'Top':
          Navigator.push(
            context,
            //MaterialPageRoute(builder: (context) => T5B()),
              SlideRoute(page: T5B(widget.side,true),duration:600,direction:'Left'),
          );
          break;
        case 'Inner':
          Navigator.push(
            context,
            //MaterialPageRoute(builder: (context) => T5C(widget.side)),
            SlideRoute(page: T5C(widget.side,true),duration:600,direction:'Left'),
          );
          break;
        case 'Outer':
          Navigator.push(
            context,
            //MaterialPageRoute(builder: (context) => T5D(widget.side)),
            SlideRoute(page: T5D(widget.side),duration:600,direction:'Left'),
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
            SlideRoute(page: T5B(widget.side,true),duration:600,direction:'Left'),
          );
          break;
        case 'Inner':
          Navigator.push(
            context,
            //MaterialPageRoute(builder: (context) => T7D()),
            SlideRoute(page: T5C(widget.side,true),duration:600,direction:'Left'),
          );
          break;
        case 'Outer':
          Navigator.push(
            context,
            //MaterialPageRoute(builder: (context) => T5D('Left')),
            SlideRoute(page: T5D(widget.side),duration:600,direction:'Left'),
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

  Future uploadImageToFirebase(BuildContext context) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    //FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    //final uid = firebaseUser.uid;
    final User user = auth.currentUser;
    final uid = user.uid;
    final String side=widget.side;
    final String view=widget.view;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kkmmssEEEdMMM').format(now);
    //String fileName = basename(widget.imagePath);
    String fileName = basename(widget.side+widget.view+formattedDate);
    FirebaseStorage storage=FirebaseStorage.instance;
    Reference ref = storage.ref().child('UserId/$uid/footimages/$side/$view/$fileName');
    UploadTask uploadTask =ref.putFile(imageFile);
    var taskSnapshot = await uploadTask;
    //StorageReference firebaseStorageRef =
    //FirebaseStorage.instance.ref().child('$uid/footimages/$side/$view/$fileName');
    //StorageUploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
    //StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    setState(() {
      taskSnapshot.ref.getDownloadURL().then(
            (value) => print("Done: $value"),
      );
      isLoading = false;
    });
  }

  Widget mywidget(BuildContext context){
    return Column(crossAxisAlignment:CrossAxisAlignment.center,mainAxisAlignment:MainAxisAlignment.spaceEvenly,children:[
      Text("\n\nExcellent!",textAlign: TextAlign.center,
          style: TextStyle(
              color: HexColor('#00CED3'),//Colors.grey[800],
              fontWeight: FontWeight.w600,
              fontFamily: 'Barlow',
              fontSize: 32)),
      Text("We’ll keep you informed  every step of the way for the remaining five scans.\n\nYou’ve got this!",textAlign: TextAlign.center,
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
          Navigator.push(
            context,
            //MaterialPageRoute(builder: (context) => T5B()),
            SlideRoute(page: T5B(widget.side,true),duration: 600,direction: 'Left'),
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

  @override
  Widget build(BuildContext context) {
    String txt='21A7';
    double height = MediaQuery.of(context).size.height;
    void _updateSize() {
      setState(() {
        _size = height-100;
        done=true;
      });
    }
    return Scaffold(
      body: Stack(
        children: <Widget>[
          LoadPictureScreen (imagePath: widget.imagePath,side:widget.side,view:widget.view,txt:widget.txt),
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
                Text("Review the Picture",style: TextStyle(color: HexColor('#222222'),
                    fontWeight: FontWeight.w600,
                    //fontStyle: FontStyle.italic,
                    fontFamily: 'Barlow',
                    fontSize: 24),),
                maketxt(widget.txt),


                Row(crossAxisAlignment:CrossAxisAlignment.center,mainAxisAlignment:MainAxisAlignment.spaceEvenly,children:[
                  ButtonTheme(minWidth: 152.0,height: 40.0,child:FlatButton(
                    onPressed: () {Navigator.push(
                      context,
                      //MaterialPageRoute(builder: (context) => bubble_level(view:widget.view, side:widget.side)),
                      SlideRoute(page: bubble_level(view:widget.view, side:widget.side),duration: 600,direction: 'Left'),
                    );},
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
                  txt=='21A4'?
                  ButtonTheme(minWidth: 152.0,height: 40.0,child:FlatButton(
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
                  ButtonTheme(minWidth: 152.0,height: 40.0,child: !isLoading ? FlatButton(
                    //
                    onPressed: ()
                    async{
                      print(_size);
                      pickImage();
                      uploadImageToFirebase(context);
                      widget.view=='Top' && widget.side=='Right'?_updateSize():routenav(context);
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
    );
  }

}

