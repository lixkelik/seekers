import 'package:seekers/constant/constant_builder.dart';
import 'package:seekers/constant/firebase_constant.dart';
import 'package:seekers/factory/game_factory.dart';
import 'package:seekers/view/impaired/success_page.dart';
import 'package:seekers/view/impaired/texttospeech.dart';
import 'package:seekers/view/repository/firestore_repository.dart';

import 'code_generator.dart';

class LoadingPage extends StatefulWidget {
  Game gameObj;
  LoadingPage(this.gameObj, {super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState(gameObj);
}

class _LoadingPageState extends State<LoadingPage> {
  Game gameObj;
  _LoadingPageState(this.gameObj);

  @override
  void initState() {
    saveObj();
    pageSpeech();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: (gameObj.code == '')
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height: 20),
                    Text(
                      'Uploading file please wait...',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: fontColor),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              )
            : SuccessPage(gameObj));
  }

  void pageSpeech() {
    textToSpeech('Please wait, we are uploading your file to our database!');
  }

  Future<void> saveObj() async {
    String code = await codeGenerator();
    gameObj.code = code;

    gameObj.createdBy = auth.currentUser!.uid;

    List<String> downloadUrl = await uploadImage(gameObj);

    for (int i = 0; i < 5; i++) {
      gameObj.obj[i].image = downloadUrl[i];
    }

    saveToFirestore(gameObj);

    setState(() {});
  }
}
