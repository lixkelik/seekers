import 'package:seekers/constant/firebase_constant.dart';

class Game{
  String place;
  List<ItemObject> obj;
  String code;
  String createdBy;
  String playedBy;
  Timestamp createdTime;
  bool isPlayed;
  Game({required this.place, required this.obj, required this.code, required this.createdBy, required this.playedBy, required this.createdTime, required this.isPlayed});

  Map<String, dynamic> toMap() {
    return {
      'createdBy': createdBy,
      'createdTime': createdTime,
      'place': place,
      'obj': obj.map((o) => o.toMap()).toList(),
      'code': code,
      'playedBy': playedBy,
      'isPlayed': isPlayed
    };
  }
}

class ItemObject{
  String image;
  String objName;
  String description;
  String colaboratorDesc;
  ItemObject({required this.image, required this.objName, required this.description, required this.colaboratorDesc});

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'objName': objName,
      'description': description,
      'colaboratorDesc': colaboratorDesc
    };
  }
}


//for save the object to firestore
/*
import 'package:cloud_firestore/cloud_firestore.dart';

class Game {
  String place;
  List<Object> obj;
  String code;
  Game({required this.place, required this.obj, required this.code});

  // Convert the Game object to a Map
  Map<String, dynamic> toMap() {
    return {
      'place': place,
      'obj': obj.map((o) => o.toMap()).toList(),
      'code': code,
    };
  }

  // Save the Game object to Firestore
  Future<void> saveToFirestore() async {
    final gameRef = Firestore.instance.collection('games').document();
    await gameRef.setData(toMap());
  }
}

class Object {
  String image;
  String objName;
  String description;
  Object({required this.image, required this.objName, required this.description});

  // Convert the Object to a Map
  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'objName': objName,
      'description': description,
    };
  }
}

// Create a new Game object
Game game = Game(
  place: 'New York',
  obj: [
    Object(
      image: 'image1.png',
      objName: 'Object 1',
      description: 'This is object 1',
    ),
    Object(
      image: 'image2.png',
      objName: 'Object 2',
      description: 'This is object 2',
    ),
  ],
  code: '123456',
);

// Save the Game object to Firestore
await game.saveToFirestore();
*/ 