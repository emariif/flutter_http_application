import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as myHttp;

class HomePagePost extends StatefulWidget {
  const HomePagePost({super.key});

  @override
  State<HomePagePost> createState() => _HomePagePostState();
}

class _HomePagePostState extends State<HomePagePost> {
  TextEditingController nameC = TextEditingController();
  TextEditingController jobC = TextEditingController();

  String hasilRespone = 'Belum ada data';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HTTP PUT/PATCH'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          TextField(
            controller: nameC,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Name',
            ),
          ),
          SizedBox(
            height: 16,
          ),
          TextField(
            controller: jobC,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Job',
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              var myRespone = await myHttp.put(
                Uri.parse("https://reqres.in/api/users/2"),
                body: {"name": nameC.text, 'job': jobC.text},
              );
              Map<String,dynamic> data = json.decode(myRespone.body) as Map<String,dynamic>;
              setState(() {
                hasilRespone = "${data['name']} - ${data['job']}";
              });
            },
            child: Text('Submit'),
            style: ElevatedButton.styleFrom(padding: EdgeInsets.all(16)),
          ),
          SizedBox(
            height: 40,
          ),
          Divider(
            color: Colors.black,
          ),
          Text(hasilRespone)
        ],
      ),
    );
  }
}