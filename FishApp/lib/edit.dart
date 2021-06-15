import 'package:flutter/material.dart';
import 'package:FishApp/main.dart';
import 'package:http/http.dart' as http;

class Edit extends StatefulWidget {
  final String name;
  final String price;
  final String weight;
  final String description;
  final String id;
  Edit({Key key, this.id, this.description, this.price, this.name, this.weight})
      : super(key: key);
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  TextEditingController fid;
  TextEditingController fname;
  TextEditingController fprice;
  TextEditingController fweight;
  TextEditingController fdescription;

  void editData() {
    var url = "http://192.168.1.102/Fishapp_backend/Services/editFish.php";

    http.post(url, body: {
      "id": fid.text,
      "name": fname.text,
      "price": fprice.text,
      "weight": fweight.text,
      "description": fdescription.text,
    });
    print(fid.text);
  }

  void initState() {
    fid = new TextEditingController(text: "${widget.id}");
    fname = new TextEditingController(text: "${widget.name}");
    fprice = new TextEditingController(text: "${widget.price}");
    fweight = new TextEditingController(text: "${widget.weight}");
    fdescription = new TextEditingController(text: "${widget.description}");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: new AppBar(
        title: Text("Edit Fish Details"),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                Container(
                  height: 200.0,
                  width: 150.0,
                  child: Image(
                    image: AssetImage('assets/logo.png'),
                  ),
                ),
                // new TextField(
                //   controller: bid,
                //   decoration: new InputDecoration(
                //     hintText: "UID",
                //     labelText: "UID",
                //   ),
                // ),
                new TextField(
                  controller: fname,
                  style: TextStyle(color: Colors.teal[100]),
                  decoration: new InputDecoration(
                      hoverColor: Colors.lightBlue[800],
                      //border: OutlineInputBorder(),
                      hintText: "Name",
                      labelText: "NAME",
                      labelStyle: TextStyle(color: Colors.lightBlue[200]),
                      hintStyle: TextStyle(color: Colors.lightBlue[400]),
                      helperStyle: TextStyle(color: Colors.white),
                      fillColor: Colors.lightBlue[800],
                      filled: true),
                ),
                SizedBox(height: 10),
                new TextField(
                  controller: fprice,
                  style: TextStyle(color: Colors.teal[100]),
                  decoration: new InputDecoration(
                      // border: OutlineInputBorder(),
                      hintText: "Price",
                      labelText: "PRICE",
                      hoverColor: Colors.lightBlue[800],
                      labelStyle: TextStyle(color: Colors.lightBlue[200]),
                      hintStyle: TextStyle(color: Colors.lightBlue[400]),
                      helperStyle: TextStyle(color: Colors.white),
                      fillColor: Colors.lightBlue[800],
                      filled: true),
                ),
                SizedBox(height: 10),
                new TextField(
                  controller: fweight,
                  style: TextStyle(color: Colors.teal[100]),
                  decoration: new InputDecoration(
                      //border: OutlineInputBorder(),
                      hintText: "Weight",
                      labelText: "WEIGHT",
                      hoverColor: Colors.lightBlue[800],
                      labelStyle: TextStyle(color: Colors.lightBlue[200]),
                      hintStyle: TextStyle(color: Colors.lightBlue[400]),
                      helperStyle: TextStyle(color: Colors.white),
                      fillColor: Colors.lightBlue[800],
                      filled: true),
                ),
                SizedBox(height: 10),
                new TextField(
                  style: TextStyle(color: Colors.teal[100]),
                  maxLines: 3,
                  controller: fdescription,
                  decoration: new InputDecoration(
                      hintText: " Enter Description",
                      labelText: "DESCRIPTION",
                      labelStyle: TextStyle(color: Colors.lightBlue[200]),
                      hintStyle: TextStyle(color: Colors.lightBlue[400]),
                      helperStyle: TextStyle(color: Colors.white),
                      fillColor: Colors.lightBlue[800],
                      filled: true),
                ),

                new Padding(padding: EdgeInsets.all(10.0)),
                new RaisedButton(
                  color: Colors.blueAccent,
                  onPressed: () {
                    editData();
                    Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (BuildContext context) => new Home(),
                      ),
                    );
                  },
                  child: new Text(
                    "Update",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
