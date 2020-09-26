import 'package:flutter/material.dart';
import 'scr.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(new MaterialApp(
    // debugShowCheckedModeBanner: false,
    home: FirstPage(),
  ));
}

class FirstPage extends StatelessWidget {
  var _categoryNameController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        color: Colors.white,
        child: Center(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(30),
              ),
              new Image.asset(
                'images/logo.jpg',
                width: 200,
                height: 200,
              ),
              new ListTile(
                title: new TextFormField(
                  controller: _categoryNameController,
                  decoration: new InputDecoration(
                    labelText: 'Search images',
                    hintText: 'Ex. cars, cats, cubes,... ',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
              ),
              new ListTile(
                title: new Material(
                  color: Colors.deepPurple,
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(10),
                  child: new MaterialButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(new MaterialPageRoute(builder: (context) {
                          return new ViewResult(
                            search: _categoryNameController.text,
                          );
                        }));
                      },
                      child: Text(
                        'Search',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ViewResult extends StatefulWidget {
  String search;
  ViewResult({this.search});
  @override
  _ViewResultState createState() => _ViewResultState();
}

class _ViewResultState extends State<ViewResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'Photo Search App',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: new FutureBuilder(
          future: getPhotos(widget.search),
          builder: (context, snapShot) {
            Map data = snapShot.data;
            if (snapShot.hasError) {
              print(snapShot.error);
              return Text(
                'Failed to get response from the server!',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              );
            } else if (snapShot.hasData) {
              return new Center(
                child: new ListView.builder(
                    itemCount: data['hits'].length,
                    itemBuilder: (context, index) {
                      return new Column(
                        children: <Widget>[
                          new Container(
                            child: new InkWell(
                              onTap: () {},
                              child: new Image.network(
                                  '${data['hits'][index]['largeImageURL']}'),
                            ),
                          ),
                          new Padding(padding: const EdgeInsets.all(5)),
                        ],
                      );
                    }),
              );
            } else if (!snapShot.hasData) {
              return new Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

Future<Map> getPhotos(String search) async {
  String url =
      'https://pixabay.com/api/?key=$apiKey&q=$search&image_type=photo&pretty=true';
  http.Response response = await http.get(url);
  return json.decode(response.body);
}
