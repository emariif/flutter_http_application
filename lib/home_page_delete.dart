import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as myHttp;

class HomePageDelete extends StatefulWidget {
  const HomePageDelete({Key? key}) : super(key: key);

  @override
  _HomePageDeleteState createState() => _HomePageDeleteState();
}

class _HomePageDeleteState extends State<HomePageDelete> {
  String data = 'Belum ada data';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HTTP Delete'),
        actions: [
          IconButton(
            onPressed: () async {
              var response = await myHttp
                  .get(Uri.parse('https://reqres.in/api/users/2'));
              Map<String, dynamic> myBody = json.decode(response.body);
              setState(() {
                data =
                    'Akun : ${myBody['data']['first_name']} ${myBody['data']['last_name']}';
              });
            },
            icon: Icon(Icons.get_app),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(data),
          SizedBox(
            height: 35,
          ),
          ElevatedButton(
              onPressed: () async {
                var response = await myHttp
                    .delete(Uri.parse('https://reqres.in/api/users/2'));
                if (response.statusCode == 204) {
                  setState(() {
                    data = 'Berhasil menghapus data';
                  });
                }
              },
              child: Text('DELETE'))
        ],
      ),
    );
  }
}
