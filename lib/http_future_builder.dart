import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as myHttp;

class HttpFutureBuilder extends StatelessWidget {
  // const HttpFutureBuilder({Key? key}) : super(key: key);
  List<Map<String, dynamic>> allUser = [];

  Future getAllUser() async {
    // await Future.delayed(Duration(seconds: 3));
    try {
      var respone = await myHttp.get(Uri.parse('https://reqres.in/api/users'));
      // print(respone.body);
      List datas = (json.decode(respone.body) as Map<String, dynamic>)['data'];
      // datas.forEach((element) {
      //   allUser.add(element);
      // });
      for (var data in datas) {
        allUser.add(data);
      }
      print(allUser);
    } catch (e) {
      print('terdapat kesalahan');
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HTTP Future Builder'),
        ),
        body: FutureBuilder(
            future: getAllUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Text('Loading...'),
                );
              } else {
                return ListView.builder(
                  itemCount: allUser.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      backgroundImage: NetworkImage(allUser[index]['avatar']),
                    ),
                    title: Text('${allUser[index]['first_name']} ${allUser[index]['last_name']}'),
                    subtitle: Text('${allUser[index]['email']}'),
                  ),
                );
              }
            }));
  }
}
