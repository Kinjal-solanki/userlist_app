import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:user_list_app/Model/Model.dart';
import 'package:user_list_app/user_detail.dart';
import 'dart:convert';

void main() {
  runApp(const UserApp());
}

class UserApp extends StatelessWidget {
  const UserApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const UserListWidget(),
    );
  }
}

class UserListWidget extends StatefulWidget {
  const UserListWidget({super.key});

  @override
  State<UserListWidget> createState() => _UserListWidgetState();
}

class _UserListWidgetState extends State<UserListWidget> {
  late Future<UserList> futureAlbum;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureAlbum = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureAlbum,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Text("User List"),
              ),
              body: _mainList(snapshot.data!.results)
            );
          } else if (snapshot.hasError) {
            return Icon(Icons.error_outline);
          } else {
            return CircularProgressIndicator();
          }
        });
  }
//
  Widget _mainList(List<User> results) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
               itemCount: results.length,
               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 2,
                 childAspectRatio: 0.8,
                 crossAxisSpacing: 10,
                 mainAxisSpacing: 10,
               ),
            itemBuilder: (BuildContext context, int index) {
              return GridTile(
              child: GestureDetector(
                child: Image.network('${results[index].picture.large}',
                  fit: BoxFit.cover),
                onTap: () => {
                  openDetailPage(results[index], index)
                },
              ),
            );
          },
         ),
    );
  }
  
  Future<UserList> fetchUsers() async {
    final response = await http
        .get(Uri.parse('https://randomuser.me/api/?results=50'));

    if (response.statusCode == 200) {
      Map<String, dynamic> itemListData = Map<String, dynamic>.from(json.decode(response.body));
      return UserList.fromJson(itemListData);
    } else {
      throw Exception('Failed to load album');
    }
  }

  openDetailPage(User user, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return UserDetail(user: user);
      }),
    );
  }
}
