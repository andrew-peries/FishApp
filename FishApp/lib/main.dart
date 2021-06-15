import 'package:FishApp/fish.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'addFish.dart';
import 'edit.dart';

void main() => runApp(new MaterialApp(
      title: "My Fish Store",
      home: new Home(),
      debugShowCheckedModeBanner: false,
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Fish>> fetchFish() async {
    final response = await http
        .get("http://192.168.1.102/Fishapp_backend/Services/getFish.php");

    return fishFromJson(response.body);
  }

  void deleteData(String _id) async {
    print(_id);
    var url = "http://192.168.1.102/Fishapp_backend/Services/deleteFish.php";
    print(_id);
    var data = {"id": _id};
    var res = await http.post(url, body: data);
    print(res);
  }

  void confirm(String id) {
    print(id);
    AlertDialog alertDialog = new AlertDialog(
      content: Text("Are you sure you want to delete this item?"),
      actions: <Widget>[
        new RaisedButton(
          child: Text(
            "Delete",
            style: new TextStyle(color: Colors.red),
          ),
          color: Colors.white,
          onPressed: () {
            deleteData(id);
            Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context) => new Home(),
              ),
            );
          },
        ),
        new RaisedButton(
          child: Text(
            "Cancel",
            style: new TextStyle(color: Colors.black),
          ),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: new AppBar(
        title: new Text(
          "Fish Mart",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[900],
      ),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent[300],
        onPressed: () => Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (BuildContext context) => new AddData(),
          ),
        ),
        child: new Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: new FutureBuilder<List>(
            future: fetchFish(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length < 1) {
                  return Center(
                    child: Image(
                      image: AssetImage("assets/fish.JPG"),
                    ),
                  );
                } else
                  return Column(children: <Widget>[
                    Container(
                      height: 200.0,
                      width: 150.0,
                      child: Image(
                        image: AssetImage('assets/logo.png'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, index) {
                          Fish fish = snapshot.data[index];
                          String id = "${fish.id}";

                          var des = "${fish.description}";
                          String fname = "${fish.name}";
                          String fweight = "${fish.weight}";
                          var fprice = "${fish.price}";
                          return Column(children: <Widget>[
                            // Divider(
                            //   color: Colors.blue[900],
                            //   thickness: 1.0,
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue[800],
                                ),
                                child: ListTile(
                                  hoverColor: Colors.blueGrey[400],
                                  title: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 4, 0, 10),
                                    child: Text(
                                      '${fish.name}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22.0,
                                          letterSpacing: 1.0,
                                          fontWeight: FontWeight.bold,
                                          height: 1.0),
                                    ),
                                  ),
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Weight: ${fish.weight} KG",
                                        style: TextStyle(
                                          color: Colors.greenAccent,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      Text(
                                        'Price: ${fish.price} Rupees',
                                        style: TextStyle(
                                          color: Colors.blueGrey[100],
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  leading: new Icon(
                                    Icons.directions_boat,
                                    color: Colors.black,
                                  ),
                                  onTap: () => Navigator.of(context).push(
                                    new MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          new Description(
                                              descripition: des,
                                              name: fname,
                                              price: fprice,
                                              weight: fweight),
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          size: 20.0,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  new Edit(
                                                      id: id,
                                                      description: des,
                                                      name: fname,
                                                      price: fprice,
                                                      weight: fweight),
                                            ),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          size: 20.0,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          confirm(id);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5.0),
                            // Divider(
                            //   color: Colors.blue[900],
                            //   thickness: 1.0,
                            // )
                          ]);
                        },
                      ),
                    ),
                  ]);
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class Description extends StatefulWidget {
  final String descripition;
  final String name;
  final String price;
  final String weight;

  Description({Key key, this.descripition, this.name, this.price, this.weight})
      : super(key: key);
  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      resizeToAvoidBottomInset: false,
      appBar: new AppBar(
        backgroundColor: Colors.blue[900],
        title: Text(
          "${widget.name}",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Column(
            children: <Widget>[
              Container(
                height: 270.0,
                width: 200.0,
                child: Image(
                  image: AssetImage('assets/logo.png'),
                ),
              ),

              //         Padding(
              //           padding: const EdgeInsets.all(12.0),
              //           child: Text(
              //             "${widget.descripition}",
              //             style: TextStyle(
              //               fontSize: 22.0,
              //               color: Colors.black,
              //             ),
              //           ),
              //         ),

              Center(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 60),
                  child: ExpansionCard(
                    borderRadius: 20,
                    //margin: EdgeInsets.fromLTRB(25, 15, 5, 25),
                    // backgroundColor: Colors.lightBlue[900],
                    background: Image.asset(
                      "assets/fishbck2.JPG",
                      fit: BoxFit.cover,
                    ),
                    title: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10),
                          Text(
                            "${widget.name}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    children: <Widget>[
                      Text(
                        "Price: ${widget.price} Rupees",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.blueGrey[100],
                        ),
                      ),
                      Text(
                        "Weight: ${widget.weight} KG",
                        style:
                            TextStyle(fontSize: 22, color: Colors.greenAccent),
                      ),
                      SizedBox(height: 10),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 7),
                        child: Text("     ${widget.descripition}",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
