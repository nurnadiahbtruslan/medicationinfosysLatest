import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicationinfosys/medicationItem.dart';
import 'package:medicationinfosys/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:medicationinfosys/constants.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'homePage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: 80,
              width: double.infinity,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 30),
                    child: Icon(
                      Icons.list,
                      color: Colors.orangeAccent,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0, left: 30),
                    child: Text(
                      "MedInfoSys",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
              color: Colors.black,
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: Colors.orangeAccent,
              ),
              title: Text(
                "Dashboard",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(HomePage.routeName);
              },
            ),
            Divider(
              height: 10,
              color: Colors.black,
              indent: 65,
            ),
            ListTile(
              leading: Icon(
                Icons.add_box,
                color: Colors.orangeAccent,
              ),
              title: Text(
                "My Medication",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                
              },
            ),
            Divider(
              height: 10,
              indent: 65,
              color: Colors.black,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.filter_b_and_w,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
        backgroundColor: Colors.black,
      ),
      body: 
      Column(children: <Widget>[
      SearchBox(
        onChanged: (value) {},
      ),
      Expanded(child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection("medications").snapshots(),
        builder: (context, snapshot) {
          return !snapshot.hasData
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot data = snapshot.data.documents[index];
                    return MedicationItem(
                      documentSnapshot: data,
                      id: data.documentID,
                      isFavourite: data['isFavourite'],
                      imageUrl: data['imageUrl'],
                      medicationName: data['medicationName'],
                      
                    );
                  },
                );
        },
      ),
      ), 
      ]), 
    );

  }
}
