import 'package:flutter/material.dart';
import 'package:FishApp/main.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

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
  bool nameValidate = true;
  bool weightValidate = true;
  bool priceValidate = true;

  void editData() {
    var url = "http://172.18.208.1/Fishapp_backend/Services/editFish.php";

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
    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20), primary: Colors.white);
    final TextStyle errorStyle = TextStyle(fontSize: 16.0, color: Colors.white);
    final TextStyle inputStyle = TextStyle(color: Colors.teal[100], fontSize: 18, fontWeight: FontWeight.w500);
    final TextStyle labelStyle = TextStyle(color: Colors.lightBlue[200], fontSize: 16);
    final TextStyle hintStyle = TextStyle(color: Colors.lightBlue[400]);
    final TextStyle  helperStyle = TextStyle(color: Colors.white);
    
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
                new TextFormField(
                  controller: fname,
                  style: inputStyle,
                  decoration: new InputDecoration(
                      hoverColor: Colors.lightBlue[800],
                      hintText: "Name",
                      labelText: "NAME",
                      labelStyle: labelStyle,
                      hintStyle: hintStyle,
                      helperStyle: helperStyle,
                      fillColor: Colors.lightBlue[800],
                      filled: true,
                      errorText: (nameValidate == false) ? 'name cannot be empty': null,
                      errorStyle: errorStyle,
                      ),
                      onChanged: (value)=> {
                          setState((){
                            nameValidate= value.isNotEmpty;
                          })
                      },
                ),
                SizedBox(height: 10),
                new TextFormField(
                  controller: fprice,
                  style: inputStyle,
                  decoration: new InputDecoration(
                      hintText: "Price",
                      labelText: "PRICE (RS)",
                      hoverColor: Colors.lightBlue[800],
                      labelStyle: labelStyle,
                      hintStyle: hintStyle,
                      helperStyle: helperStyle,
                      fillColor: Colors.lightBlue[800],
                      filled: true, 
                      errorText: (priceValidate == false) ? 'price cannot be empty': null,
                      errorStyle: errorStyle,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value)=> {
                          setState((){
                            priceValidate= value.isNotEmpty;
                          })
                      },
 
                ),
                SizedBox(height: 10),
                new TextFormField(
                  controller: fweight,
                  style: inputStyle,
                  decoration: new InputDecoration(
                      hintText: "Weight",
                      labelText: "WEIGHT (KG)",
                      hoverColor: Colors.lightBlue[800],
                      labelStyle: labelStyle,
                      hintStyle: hintStyle,
                      helperStyle: helperStyle,
                      fillColor: Colors.lightBlue[800],
                      filled: true,
                      errorText: (weightValidate == false) ? 'weight cannot be missing or empty': null,
                      errorStyle: errorStyle,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value)=> {
                      
                          setState((){
                            weightValidate= value.isNotEmpty;
                          })
                     
                      },

                ),
                SizedBox(height: 10),
                new TextField(
                  style: inputStyle,
                  maxLines: 3,
                  controller: fdescription,
                  decoration: new InputDecoration(
                      hintText: " Enter Description",
                      labelText: "DESCRIPTION",
                      labelStyle: labelStyle,
                      hintStyle: hintStyle,
                      helperStyle: helperStyle,
                      fillColor: Colors.lightBlue[800],
                      filled: true),
                ),

                new Padding(padding: EdgeInsets.all(10.0)),
                new ElevatedButton(
                  style: buttonStyle,
                  onPressed: () {
                    if (nameValidate && weightValidate && priceValidate){
                      editData();
                      Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context) => new Home(),
                        ),
                      );
                    }else{
                      Fluttertoast.showToast(
                        msg: "cannot be updated",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.white70,
                        textColor: Colors.blue[400],
                        fontSize: 16.0
    );
                    }
                  },
                  child: new Text(
                    "Update",
                    style: TextStyle(color: Colors.blue[900], fontSize: 18),
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
