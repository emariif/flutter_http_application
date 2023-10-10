import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as myHttp;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePagePost(),
    );
  }
}

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
        title: Text('HTTP POST'),
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
              var myRespone = await myHttp.post(
                Uri.parse("https://reqres.in/api/users"),
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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String id;
  late String email;
  late String name;

  @override
  void initState() {
    id = '';
    email = '';
    name = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HTTP Application'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ID : $id',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Email : $email',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Name : $name',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  var myRespone = await myHttp
                      .get(Uri.parse('https://reqres.in/api/users/5'));
                  if (myRespone.statusCode == 200) {
                    print('berhasil get data');
                    Map<String, dynamic> data =
                        json.decode(myRespone.body) as Map<String, dynamic>;
                    print(data['data']);
                    setState(() {
                      id = data['data']['id'].toString();
                      email = data['data']['email'].toString();
                      name =
                          '${data['data']['first_name'].toString()} ${data['data']['last_name'].toString()}';
                    });
                  } else {
                    print('ERROR ${myRespone.statusCode}');
                    // setState(() {
                    //   body = "ERROR ${myRespone.statusCode}";
                    // });
                  }
                },
                child: const Text('GET DATA')),
          ],
        ),
      ),
    );
  }
}
