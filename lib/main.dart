import 'package:flutter/material.dart';

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
                    hintText: 'ex. cats, dogs, coffee...',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
              ),
              new ListTile(
                title: new Material(
                  color: Colors.blue,
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(10),
                  child: new MaterialButton(
                      onPressed: () {},
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
