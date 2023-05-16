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
                  children: [
                    const CircularProgressIndicator(color: appOrange, ),
                    const SizedBox(height: 20),
                    Text(
                      'Uploading file please wait...',
                      style: styleB15,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              )
            : SuccessPage(gameObj));
  }

  void pageSpeech() {
    textToSpeech('Please wait, we are uploading your file! We will let you know when it\'s finished');
  }

  Future<void> saveObj() async {
    String code;
    DocumentSnapshot<Object?> docSnapshot;

    do{
      code = await codeGenerator();
      DocumentReference docRef = db.collection('games').doc(code);
      docSnapshot = await docRef.get();
    }while(docSnapshot.exists);
    
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
