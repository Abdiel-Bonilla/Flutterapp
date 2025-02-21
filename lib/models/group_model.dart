import 'package:mongo_dart/mongo_dart.dart' as mongo;

class GroupModel {
  final mongo.ObjectId id;
  String name;
  String type;
  int albums;


  GroupModel({
    required this.id,
    required this.name,
    required this.type,
    required this.albums,
  });

  //Convertir dart a Json para enviarlo a atlas
  //Se usara para insertar y editar
  Map<String, dynamic> toJson() {
    return {'_id': id,'name': name,'type': type,'albums': albums};
  }

  //Convertir de json a dart
  //Se usara para select
  factory GroupModel.fromJson(Map<String, dynamic> json) {
    var id = json['_id'];

    //verificar que sea de tipo objectid
    if (id is String) {
      try{
        id = mongo.ObjectId.fromHexString(id);
      } catch (e) {
        id = mongo.ObjectId();
      }
    }else if (id is! mongo.ObjectId) {
      id = mongo.ObjectId();
    }

    return GroupModel(
      id: id as mongo.ObjectId,
      name: json['name'] as String,
      type: json['type'] as String,
      albums: json['albums'] as int,
    );
  }

}