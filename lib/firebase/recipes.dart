import 'package:firebase_database/firebase_database.dart';

class Recipes {
  String uid;
  String name;
  String ingred;
  String instruction;
  String about;
  String image;
  Recipes(this.uid, this.name, this.ingred, this.instruction, this.about, this.image);

  //from object to attributes
  Recipes.map(dynamic obj){
    this.uid = obj['uid'];
    this.name = obj['name'];
    this.ingred = obj['ingred'];
    this.instruction = obj['instruction'];  
    this.about = obj['about'];
    this.image = obj['image'];}

  // String get uid => uid;
  // String get name => _name;
  // String get ingred => _ingred;
  // String get instruction => _instruction;
  // String get about => _about;
  // String get image => _image;

  //from firebase to attribute, constructor fromSnapshot
  Recipes.fromSnapShot(DataSnapshot snapshot){
    uid = snapshot.key;
    name = snapshot.value['name'];
    ingred = snapshot.value['ingred'];
    instruction = snapshot.value['instruction'];
    about = snapshot.value['about'];
    image = snapshot.value['image'];
  }
  
bool contain(String filter){
return name.toLowerCase().contains(filter.toLowerCase());
}
}