import 'package:FishApp/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController name = new TextEditingController();
  TextEditingController weight = new TextEditingController();
  TextEditingController price = new TextEditingController();
  TextEditingController description = new TextEditingController();

  void addFish() {
    var url = "http://192.168.1.102/Fishapp_backend/Services/addFish.php";
    http.post(url, body: {
      "name": name.text,
      "weight": weight.text,
      "price": price.text,
      "description": description.text,
    });
  }

  Widget _buildNameField() {
    return TextFormField(
      style: TextStyle(color: Colors.teal[100]),
      validator: (text) {
        return HelperValidator.nameValidate(text);
      },
      maxLength: 20,
      maxLines: 1,
      controller: name,
      decoration: InputDecoration(
          labelText: 'NAME',
          hintText: 'Enter fish name',
          hoverColor: Colors.lightBlue[800],
          labelStyle: TextStyle(color: Colors.lightBlue[200]),
          hintStyle: TextStyle(color: Colors.lightBlue[400]),
          helperStyle: TextStyle(color: Colors.white),
          fillColor: Colors.lightBlue[800],
          filled: true),
      // onSaved: (value) {
      //   _name = value;
      // },
    );
  }

  Widget _buildPriceField() {
    return TextFormField(
      validator: (text) {
        return HelperValidator.priceValidate(text);
      },
      maxLength: 20,
      maxLines: 1,
      controller: price,
      decoration: InputDecoration(
          labelText: 'PRICE',
          hintText: 'Enter Price',
          hoverColor: Colors.lightBlue[800],
          labelStyle: TextStyle(color: Colors.lightBlue[200]),
          hintStyle: TextStyle(color: Colors.lightBlue[400]),
          helperStyle: TextStyle(color: Colors.white),
          fillColor: Colors.lightBlue[800],
          filled: true),
      // onSaved: (value) {
      //   _name = value;
      // },
    );
  }

  Widget _buildWeightField() {
    return TextFormField(
      validator: (text) {
        return HelperValidator.weightValidate(text);
      },
      maxLength: 20,
      maxLines: 1,
      controller: weight,
      decoration: InputDecoration(
          labelText: 'WEIGHT',
          hintText: 'Enter Weight',
          hoverColor: Colors.lightBlue[800],
          labelStyle: TextStyle(color: Colors.lightBlue[200]),
          hintStyle: TextStyle(color: Colors.lightBlue[400]),
          helperStyle: TextStyle(color: Colors.white),
          fillColor: Colors.lightBlue[800],
          filled: true),
      // onSaved: (value) {
      //   _name = value;
      // },
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      style: TextStyle(color: Colors.teal[100]),
      maxLines: 3,
      validator: (text) {
        return HelperValidator.descriptionValidate(text);
      },
      maxLength: 20,

      controller: description,
      decoration: InputDecoration(
          labelText: 'DESCRIPTION',
          hintText: 'Enter Description',
          labelStyle: TextStyle(color: Colors.lightBlue[200]),
          hintStyle: TextStyle(color: Colors.lightBlue[400]),
          helperStyle: TextStyle(color: Colors.white),
          fillColor: Colors.lightBlue[800],
          filled: true),
      // onSaved: (value) {
      //   _name = value;
      // },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        title: Center(child: Text('Add Fish Details')),
        backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      height: 150.0,
                      width: 100.0,
                      child: Image(
                        image: AssetImage('assets/logo.png'),
                      ),
                    ),
                  ),
                  _buildNameField(),
                  SizedBox(height: 10),
                  _buildPriceField(),
                  SizedBox(height: 10),
                  _buildWeightField(),
                  SizedBox(height: 10),
                  _buildDescriptionField(),
                  SizedBox(height: 5.0),
                  Container(
                    width: 150,
                    child: RaisedButton(
                      color: Colors.blueAccent,
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      // onPressed: () {
                      //   addFish();
                      //   Navigator.of(context).push(
                      //     new MaterialPageRoute(
                      //       builder: (BuildContext context) => new Home(),
                      //     ),
                      //   );
                      // }),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          print('valid form');
                          addFish();
                          Navigator.of(context).push(
                            new MaterialPageRoute(
                              builder: (BuildContext context) => new Home(),
                            ),
                          );
                          _formKey.currentState.save();
                        } else {
                          print('not valid form');

                          return;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HelperValidator {
  static String nameValidate(String value) {
    if (value.isEmpty) {
      return "Name can't be empty";
    }
    if (value.length < 2) {
      return "Name must be at least 2 characters long";
    }
    if (value.length > 50) {
      return "Name must be less than 50 characters long";
    }
    return null;
  }

  static String priceValidate(String value) {
    if (value.isEmpty) {
      return "Price can't be empty";
    }
    return null;
  }

  static String weightValidate(String value) {
    if (value.isEmpty) {
      return "Weight can't be empty";
    }
    return null;
  }

  static String descriptionValidate(String value) {
    if (value.isEmpty) {
      return "Description can't be empty";
    }
    return null;
  }
}
