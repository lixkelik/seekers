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
  String colaboratorUid;
  ItemObject({required this.image, required this.objName, required this.description, required this.colaboratorDesc, required this.colaboratorUid});

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'objName': objName,
      'description': description,
      'colaboratorDesc': colaboratorDesc,
      'colaboratorUid': colaboratorUid
    };
  }
}