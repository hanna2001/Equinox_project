import 'package:equinox_project/alert_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController keywordController = TextEditingController();
  String keyword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MayDay'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icon.png',
              width: 80,
              height: 80,
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                onChanged: (val) {
                  setState(() {
                    keyword = val;
                    //print(val);
                  });
                },
                cursorColor: Colors.black,
                controller: keywordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'keyword',
                ),
              ),
            ),
            Container(
                height: 60,
                width: 360,
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                // ignore: deprecated_member_use
                child: RaisedButton(
                  padding: EdgeInsets.all(10),
                  textColor: Colors.white,
                  color: Colors.amber,
                  child: Text(
                    'Set Keyword',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    //print(keyword);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AlertPage(
                          keyword: keyword,
                        ),
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
