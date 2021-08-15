import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:foodrecipes/screens/recipeScreen.dart';
import 'dart:async';
import 'package:foodrecipes/firebase/recipes.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

 //-------------- Variables ------------------
 TextEditingController searchController = new TextEditingController();
 var recipeRef = FirebaseDatabase.instance.reference();
 StreamSubscription<Event> _recipeAddedSub;
 List<Recipes> allRecipes = [];
 List<Recipes> allFRecipes = [];
 bool _isLoading = true;
 String _filter = "";

 //-------------- Methods --------------------
    void _showDialog(){
AlertDialog alertDialog = AlertDialog(
     title: Text("Food Recipes App",
     style: TextStyle(
        fontWeight: FontWeight.w700,
        fontFamily: "Ranga"
          ),),
     content: Text(
       "This application has made BY ABRAR LASEBAI With supervision of Eng. AMJAD ALSHRAFI, Thank you for using it, Please contact with me if you have any FeedBack: abr.lasebai@gmail.com",
       style: TextStyle(
        color: Colors.black54,
        fontSize: 15,
        fontWeight: FontWeight.w300,
        fontFamily: "Ranga"
          ),) );
   showDialog(
     context: context,
     builder: (context) => alertDialog,
   );
 }

    void initState(){
     super.initState();
      _recipeAddedSub = recipeRef.child('recipes').onChildAdded.listen(recipesEvent);
 }

    DatabaseReference getRecipeRef(){
      recipeRef = recipeRef.root();
      return recipeRef;
    }
    
    void recipesEvent(Event event){
      //listen from firebase
      Recipes recipes = new Recipes.fromSnapShot(event.snapshot);
      setState(() {
        allRecipes.add(recipes);
        _isLoading = false; }); 
    }

List<Recipes> _filterRec(){
  allFRecipes = new List.from(allRecipes);
  if (_filter.isEmpty){
    return allFRecipes;
    } else {
     List<Recipes> result = [];
      for (Recipes rec in allFRecipes) {
        if (rec.contain(_filter) == true) {
          result.add(rec);
        } }
        return result;
           }}

 //-------------- Widgets -------------------
    Widget foodCard(List<Recipes> filterrecipe) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded( 
                child: ListView.builder(             
                 itemCount: filterrecipe.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                       onTap: () {
             Navigator.push(context, 
            MaterialPageRoute(builder: (context) =>  
            RecipeScreen(
              filterrecipe[index].name,filterrecipe[index].ingred,filterrecipe[index].instruction,filterrecipe[index].image)));  },
                      child: Card( 
                        color: Colors.deepPurple[50],
                            child: Material(
                          color: Colors.white,
                          elevation: 3.0,
                          shadowColor: Colors.blueGrey,
                          borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(20.0)),
                          child: ClipRRect(
                            borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(20.0)),
                            child: FittedBox(
                              child: Material(
                                color: Colors.white,
                                elevation: 8.0,
                                shadowColor: Colors.blueGrey,
                                child: Row(
                                  children: [
                                    Container(
                                        width: 250,
                                        height: 250,
                                        child: FadeInImage.memoryNetwork(
                                            placeholder: kTransparentImage,
                                            height: 200,
                                            fit: BoxFit.fitHeight,
                                            alignment: Alignment.topLeft,
                                            image:filterrecipe[index].image )),
                                    Container(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: 180,
                                          width: 200,
                                          child: Column(children: [
                                            Text(
                                              filterrecipe[index].name,
                                              style: TextStyle(color: Colors.black54,
                                              fontSize: 20,),
                                            ),SizedBox(height: 16.0),
                                            Divider(),
                                            SizedBox(height: 16.0),
                                            Text(
                                              filterrecipe[index].about,
                                              textAlign: TextAlign.center,
                                              softWrap: true,
                                              maxLines: 3,
                                              style: TextStyle(
                                              fontSize: 14,
                                              )),]),)))]),),)))),);}))]));
                                              }

    Widget search(){
      return Container(
          child: Row(children:[
               SizedBox(width: 10),
                Expanded(child: TextField(      
                  controller: searchController,
                  onChanged: (newValue) {
                    setState(() {
                      _filter = newValue;
                    });
                    }, 
                decoration: InputDecoration(
                  isDense: true,                      
          contentPadding: EdgeInsets.all(10),
              hintText: 'Looking For A Specific Recipe?',
              hintStyle: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 13
              ), 
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
          ),
          style: TextStyle(fontSize: 14,
        ),
             ),),
            SizedBox(width: 6),
            InkWell(
              child: Container(
                child: Icon(Icons.search,
               color: Colors.deepPurple,
               )
              ) ,
            ),
            SizedBox(width: 6) ]) );
      }
  
  //-------------- Build Method ------------------
  @override
    Widget build(BuildContext context) {
      List<dynamic> filterRecipe = _filterRec();

      return WillPopScope(
        onWillPop: () async {
          if(_filter.isNotEmpty){
            setState(() {
              searchController.text = "";
              _filter = "";
            });
          return false; }
          return true;
        },
              child: Container(
          color: Colors.white,
          height: 300,
          width: 300,
          child: _isLoading ? SpinKitWave(
           color: Colors.deepPurple,
           size: 50) : 
           Scaffold(
              appBar: AppBar(
                title: Text('Recipes Menu'), 
                actions: [
                  IconButton(
                icon: const Icon(Icons.help_outline),
                tooltip: 'About us!',
                onPressed: () {
                  _showDialog(); },
              ),],
              ),
              backgroundColor: Colors.deepPurple[50],
              body: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  search(),
                  SizedBox(
                    height: 8,
                  ),
                  SizedBox(height: 6),
                  Expanded( 
                    child: foodCard(filterRecipe),
                  ),]) ) ),
      ); }

  
       void dispose(){
  super.dispose();
  _recipeAddedSub.cancel();
 }
}