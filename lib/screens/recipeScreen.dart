import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class RecipeScreen extends StatelessWidget { 
  String name;
  String ingred; 
  String instruction;
  String image;

  RecipeScreen(this.name, this.ingred, this.instruction, this.image);
   
  //-------------- Methods --------------------
  DraggableScrollableSheet _draggableScrollableSheet(){
    return DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.6 ,
        maxChildSize: 1,
          builder: (BuildContext context, ScrollController scrollController){
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(24),
                height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.deepPurple[50],
            border: Border.all(
              color: Colors.deepPurple[300]
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)
            ) ),              
              child: Container(  
              child: ListView(
          children: [
            Row(children: [
                  Center(
                  child: Text(this.name, 
                    textAlign: TextAlign.center,                 
                          style: TextStyle(
                      color: Colors.black54,
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Ranga"
                        ),
                      ),
                  ),],),
                    SizedBox(height: 10),
                    Divider(),
                    Align(alignment: Alignment.centerLeft,
                  child: Text("What Do you Need",                 
                        style: TextStyle(
                    color: Colors.black,
                    fontSize: 23, fontWeight: FontWeight.w400,
                    fontFamily: "Ranga"
                    ),
                    ),),
                    SizedBox(height: 4),
                  Text(this.ingred,                 
                        style: TextStyle(
                    color: Colors.grey, fontSize: 20,
                    fontFamily: "Ranga",
                    fontWeight: FontWeight.w300)),
                    Divider(),
                    Align(alignment: Alignment.centerLeft,
                  child: Text("How To Prepare",               
                      style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w400,
                    fontFamily: "Ranga",
                    fontSize: 23 ),
                    ),),
                      SizedBox(height: 4),
                      Text(this.instruction,                                
                          style: TextStyle(
                      color: Colors.grey,fontFamily: "Ranga", fontSize: 20)),
                       SizedBox(height: 280),
                    ]) ) ),
            );    }); }
  
  Widget detailsSheet(){
    return Stack(
      children: [
        Positioned(
          top: 0, bottom: 200,
          right: 0, left: 0,
          child: Container(
            color: Colors.deepPurple[100],
            child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  fit: BoxFit.cover,
                    image:
                    this.image),
              )),
              _draggableScrollableSheet()
                ]);
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      backgroundColor: Colors.deepPurple[300],
      body: 
        detailsSheet()  );
 }
}