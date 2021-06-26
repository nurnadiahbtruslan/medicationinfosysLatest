import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicationinfosys/medicationItem.dart';
import 'package:medicationinfosys/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:medicationinfosys/constants.dart';


import 'package:medicationinfosys/auth.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'homePage';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String id;
  String name = "";
  final AuthService _auth = AuthService();

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
                  Navigator.of(context)
                      .pushReplacementNamed(HomePage.routeName);
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
                onTap: () {},
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
          FlatButton.icon(
            color: Colors.white,
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
        backgroundColor: Colors.black,
      ),
        body: Column(
          children: <Widget>[
            SearchBox(
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: (name != "" && name != null)
                    ? Firestore.instance
                        .collection("medications")
                        .where("keywords", arrayContains: name)
                        .snapshots()
                    : Firestore.instance.collection("medications").snapshots(),
                builder: (context, snapshot) {
                  // return !snapshot.hasData
                  return (snapshot.connectionState == ConnectionState.waiting)
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot data =
                                snapshot.data.documents[index];
                            return MedicationItem(
                              documentSnapshot: data,
                              id: data.documentID,
                              isFavourite: data['isFavourite'],
                              imageUrl: data['imageUrl'],
                              medicationName: data['medicationName'],
                              purpose: data['purpose'],
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ));
  }
}