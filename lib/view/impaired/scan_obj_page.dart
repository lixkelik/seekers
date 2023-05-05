import 'package:camera/camera.dart';
import 'package:seekers/constant/constant_builder.dart';
import 'package:seekers/factory/game_factory.dart';
import 'package:seekers/tflite/image_utils.dart';
import 'package:seekers/tflite/recognition.dart';
import 'package:seekers/tflite/box_widget.dart';
import 'package:seekers/view/impaired/describe_page.dart';
import 'package:seekers/view/impaired/texttospeech.dart';

import '../../tflite/camera_view.dart';

/// [HomeView] stacks [CameraView] and [BoxWidget]s with bottom sheet for stats
class ScanObjectPage extends StatefulWidget {

  String title;
  List<ItemObject> objects;
  

  ScanObjectPage(this.title, this.objects, {super.key});

  @override
  // ignore: no_logic_in_create_state
  _ScanObjectPageState createState() => _ScanObjectPageState(title, objects);
}

class _ScanObjectPageState extends State<ScanObjectPage> {

  String title;
  List<ItemObject> objects; 

  _ScanObjectPageState(
    this.title,
    this.objects
  );

  /// Results to draw bounding boxes
  List<Recognition>? results;
  CameraImage? _currentImage;

  String objText = '';

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

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
              height: 280,
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
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: TextButton.icon(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white, 
                                  backgroundColor: appOrange,
                                  alignment: Alignment.center,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(0)), // remove border radius
                                  ),
                                ),
                                onPressed: () => textToSpeech(objText), 
                                icon: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.volume_up_rounded, size: 50,),
                                    Text(
                                      'Speak',
                                      style: TextStyle(
                                        fontSize: 25
                                      )
                                    )
                                  ],
                                ), 
                                label: const SizedBox.shrink()
                              ),
                            ),
                          ),

                          const SizedBox(width: 5),

                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: TextButton.icon(
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white, 
                                  backgroundColor: appOrange,
                                  alignment: Alignment.center,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(0)), // remove border radius
                                  ),
                                ),
                                onPressed: () async {
                                  if(objText != ''){
                                    bool flag = true;
                                    for(var obj in objects){
                                      if(obj.objName == objText){
                                        flag = false;
                                        break;
                                      }
                                    }
                                    if(flag){
                                      if (_currentImage != null) {
                                        final rgbImage = ImageUtils.convertCameraImage(_currentImage!);
                                        if (rgbImage != null) {
                                          try {
                                            String image = await ImageUtils.saveImage(rgbImage, objText);
                                            if(image != ''){
                                              textToSpeech('$objText Saved! Now let\'s describe the object by touching it. You can describe the texture, the weight, the size, or the function of the object!');
                                              // ignore: use_build_context_synchronously
                                              Navigator.pushReplacement(
                                                context, 
                                                MaterialPageRoute(builder: (context) => DescribePage(title, image, objects, objText)),
                                              );
                                            }
                                          } catch (e) {
                                            textToSpeech('An error occured, please try again later.');
                                          }
                                        }
                                      }
                                    }else{
                                      textToSpeech('Object duplicated, please find another object!');
                                    }
                                  }else{
                                    textToSpeech('No object detected!');
                                  }
                                }, 
                                icon: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.photo_camera, size: 50,),
                                    Text(
                                      'Save',
                                      style: TextStyle(
                                        fontSize: 25
                                      )
                                    )
                                  ],
                                ), 
                                label: const SizedBox.shrink()
                              ),
                            ),
                          ),

                        ],
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

  void stopCamera(CameraController cameraController){
    if(cameraController.value.isStreamingImages){
      cameraController.stopImageStream();
    }
  }

  /// Callback to get inference results from [CameraView]
  void resultsCallback(List<Recognition> results, CameraImage image) {
    bool lastChecker = true;
    if(this.results != null && results.isNotEmpty){
      if(this.results!.isNotEmpty){
        if(this.results!.last.label == results.last.label){
          lastChecker = false;
        }
      }
    }
    if(mounted){
      setState(() {
        this.results = results;
        if(lastChecker){
          if(results.isNotEmpty){
            textToSpeech(results.last.label);
            objText = results.last.label;
            _currentImage = image;
          }
        }
      });
    }
  }
}