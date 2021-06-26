import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicationinfosys/operations.dart';
import 'package:flutter/material.dart';

class MedicationItem extends StatefulWidget {
  final String medicationName;
  final String imageUrl;
  final bool isFavourite;
  final String id;
  final String purpose;
  final DocumentSnapshot documentSnapshot;
  MedicationItem({
    @required this.imageUrl,
    @required this.documentSnapshot,
    @required this.id,
    @required this.isFavourite,
    @required this.medicationName,
    @required this.purpose,
  });

  @override
  _MedicationItemState createState() => _MedicationItemState();
}

class _MedicationItemState extends State<MedicationItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Container(
              height: 100,
              width: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          widget.medicationName,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          widget.purpose,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                      ),
                    
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
               
                  
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          editMedication(widget.isFavourite, widget.id);
                        },
                        icon: widget.isFavourite
                            ? Icon(
                                Icons.favorite,
                                color: Colors.greenAccent,
                              )
                            : Icon(
                                Icons.favorite_border,
                                color: Colors.greenAccent,
                              ),
                      ),
                     
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
      ),
    );
  }
}
