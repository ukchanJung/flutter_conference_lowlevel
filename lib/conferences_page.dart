import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_conference_lowlevel/conference_detail_page.dart';
import 'package:flutter_conference_lowlevel/nation.dart';
import 'package:http/http.dart' as http;

class ConferencesPage extends StatefulWidget {
  @override
  _ConferencesPageState createState() => _ConferencesPageState();
}

class _ConferencesPageState extends State<ConferencesPage> {
  List<Nation> nations = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //변경시점을 알려주기 위하여 SetState 사용
    //감싸주는위치가 중요
    fetchNations().then((value) {
      setState(() {
        nations.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Conferences',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
              ),
            ),
            Divider(
              thickness: 2,
            ),
            Expanded(
              child: ListView(
                children: nations
                    .map((e) => ListTile( title: Text(e.name),
                          subtitle: Text(e.location), onTap: () {
                            Navigator.push( context,
                              MaterialPageRoute(builder: (context) => ConferenceDetailPage(e)), );
                          },
                        ))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<List<Nation>> fetchNations() async {
  // await: Future가 종료되는 것을 기다린다, async 키워드가 붙어있는 메서드 안에서만 사용 가능
  final http.Response response = await http.get('https://raw.githubusercontent.com/junsuk5/mock_json/main/conferences.json');

  if (response.statusCode == 200) {
    List<Nation> albums = [];
    //jsonDecode로 json 형태의 String을 Map 형태로 변환
    final Iterable json = jsonDecode(response.body);
    return json.map((e) => Nation.fromJson(e)).toList();
    // final json = jsonDecode(response.body);
    // json.foreach((element){
    //   Album album = Album.fromJson(json);
    //   albums.add(album);
    // });
    //
    // //변환된 Map형태의 json
    // return albums;
  } else {
    throw Exception('Failed to load album');
  }
}
