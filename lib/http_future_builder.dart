import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_http_application/models/user_with_quick.dart';
import 'package:http/http.dart' as myHttp;

class HttpFutureBuilder extends StatelessWidget {
  List<UserModel> allUser = [];
  HttpFutureBuilder({Key? key}) : super(key: key);

  Future getAllUser() async {
    // await Future.delayed(Duration(seconds: 3));
    try {
      var respone =
          await myHttp.get(Uri.parse('https://reqres.in/api/users?page=1'));
      // print(respone.body);
      List datas = (json.decode(respone.body) as Map<String, dynamic>)['data'];
      datas.forEach((element) {
        allUser.add(UserModel.fromJson(element));
      });
      // for (var data in datas) {
      //   allUser.add(UserModel(
      //     id: data['id'],
      //     email: data['email'],
      //     firstName: data['firstName'],
      //     lastName: data['lastName'],
      //     avatar: data['avatar'],
      //   ));
      // }
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
                if (allUser.isEmpty) {
                  //isEmpty = 0
                  return const Center(
                    child: Text('Tidak ada data...'),
                  );
                }
                return ListView.builder(
                  itemCount: allUser.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      backgroundImage: NetworkImage(allUser[index].avatar),
                    ),
                    title: Text(
                        '${allUser[index].firstName} ${allUser[index].lastName}'),
                    subtitle: Text('${allUser[index].email}'),
                  ),
                );
              }
            }));
  }
}
