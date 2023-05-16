import 'dart:async';

import 'package:camera/camera.dart';
import 'package:seekers/constant/constant_builder.dart';
import 'package:seekers/tflite/recognition.dart';
import 'package:seekers/tflite/box_widget.dart';
import 'package:seekers/view/impaired/texttospeech.dart';

import '../../tflite/camera_view.dart';

/// [HomeView] stacks [CameraView] and [BoxWidget]s with bottom sheet for stats
class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  /// Results to draw bounding boxes
  List<Recognition>? results;

  Timer? _timer;

  String objText = '';

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    pageSpeech();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          // Camera View
          CameraView(resultsCallback),
          
          // Bounding boxes
          boundingBoxes(results),

          // Bottom Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.maxFinite,
              height: 221,
              decoration: const BoxDecoration(
                  color: Colors.white,),
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        objText,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: fontColor,            
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white, 
                          backgroundColor: appOrange,
                          fixedSize: const Size(100, 100),
                          shape: const CircleBorder(),
                          alignment: Alignment.center,
                        ),
                        onPressed: () {
                          if(objText == ''){
                            textToSpeech("No object detected!");
                          }else{
                            textToSpeech(objText);
                          }
                        }, 
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.volume_up_rounded, size: 37,),
                            Text(
                              'Hear',
                              style: TextStyle(
                                fontSize: 18
                              ),
                            )
                          ],
                        ), 
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  


  /// Returns Stack of bounding boxes
  Widget boundingBoxes(List<Recognition>? results) {
    if (results == null) {
      return Container();
    }
    return Stack(
      children: results
          .map((e) => BoxWidget(
                result: e,
              ))
          .toList(),
    );
  }

  /// Callback to get inference results from [CameraView]
  void resultsCallback(List<Recognition> results, CameraImage image) {
    if(mounted){
      setState(() {
        this.results = results;
        if(results.isNotEmpty){
          if(objText != results.last.label){
            textToSpeech(results.last.label);
          }
          objText = results.last.label;
          clearObjText();
        }
      });
    }
  }

  void clearObjText() async{
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 2), (() =>  objText=''));
  }

  void pageSpeech(){
    textToSpeech('You are at: Explore Page!');
  }

}