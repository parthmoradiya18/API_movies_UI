import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:api_movies_ui/Model/Movies_Model.dart';
import 'package:api_movies_ui/view/Movies_Page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Api_ui(),
    debugShowCheckedModeBanner: false,
  ));
}

class Api_ui extends StatefulWidget {
  const Api_ui({Key? key}) : super(key: key);

  @override
  State<Api_ui> createState() => _Api_uiState();
}

class _Api_uiState extends State<Api_ui> {
  List l = [];
  get_Api() async {
    var url = Uri.parse('https://dummyapi.online/api/movies');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    l = jsonDecode(response.body);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_Api();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.grey,
      body: ListView.builder(
        itemCount: l.length,
        itemBuilder: (context, index) {
          Model a = Model.fromJson(l[index]);
          return Card(color: Colors.indigo[300],
            child: ListTile(
                title: Text("${a.movie}",style: TextStyle(color: Colors.black,
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),),
                leading: Text("${a.id}",style: TextStyle(color: Colors.black,
                    fontSize: 25,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),),
                trailing:
                IconButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Movies_Page(a.imdbUrl,a.movie);
                  },));
                }, icon: Icon(Icons.movie,color: Colors.black,size: 35,))
            ),
          );
        },
      ),
    );
  }
}
