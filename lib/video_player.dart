import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:html';
import 'dart:ui' as ui;


void main() => runApp(VideoPlayerApp());

class VideoPlayerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: UrlPlayer(source:'https://firebasestorage.googleapis.com/v0/b/webapp-dev-662f0.appspot.com/o/videoscan_instructions_v2.mp4?alt=media&token=4025a450-2034-4e12-9179-a25308d71d8e'),
      //VideoPlayerScreen(filepath:'https://firebasestorage.googleapis.com/v0/b/webapp-dev-662f0.appspot.com/o/videoscan_instructions_v2.mp4?alt=media&token=4025a450-2034-4e12-9179-a25308d71d8e'),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({Key key,this.filepath}) : super(key: key);
  final String filepath;

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    super.initState();
    _controller = VideoPlayerController.network(widget.filepath);

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.play();
    _controller.setLooping(true);
    //setState(() {});

  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(_controller),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),*/ // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class UrlPlayer extends StatefulWidget {
  final String source;
  //final Blob data;
  //final bool first_vidset;
  //final Stream<bool> stream;

  UrlPlayer({Key key, @required this.source}) : super(key: key);

  @override
  _UrlPlayerState createState() => _UrlPlayerState();
}
class _UrlPlayerState extends State<UrlPlayer> {
  // Widget _iframeWidget;
  final videoElement = VideoElement();
  //bool done=false,isLoading=false,isPlaying=false, atEnd=false;
  //double _size = 250.0;
  //String message1,message2;
  //StreamController<bool> controller = StreamController<bool>();
  //var stream = document.getElementsByTagName('video');
  @override
  void initState() {
    super.initState();
    videoElement
      ..src = widget.source
      ..autoplay = true
      ..controls = false
      ..style.border = 'none'
      ..style.height = '100%'
      ..style.width = '100%';

    // Allows Safari iOS to play the video inline
    videoElement.setAttribute('playsinline', 'true');
    videoElement.setAttribute( 'loop', '' );

    // Set autoplay to false since most browsers won't autoplay a video unless it is muted
    videoElement.setAttribute('autoplay', 'true');

    /*Stream stream = controller.stream;
    print(videoElement.paused);
    print(videoElement.ended);
    videoElement.onPause.listen((Event _){
      controller.add(videoElement.ended);
    });
    //controller.add(videoElement.paused);

    stream.listen((value) {
      print('Value from controller: $value');
      mySetState(value);
    });*/


    //if (videoElement.paused) {
    //  videoElement.play();
    //}

    //ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
        widget.source, (int viewId) => videoElement);

    /*widget.stream.listen((flag) {
      mySetState(flag);
    });*/

  }

  /*mySetState(bool flag){
    setState(() {
      //isPlaying=flag;
      atEnd=flag;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(body:
    Container(child:
      HtmlElementView(
        key: UniqueKey(),
        viewType: widget.source,
      ),
     )
    );
  }
}