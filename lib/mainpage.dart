import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lago/auth/authservice.dart';
import 'package:lago/pages/activity.dart';
import 'package:lago/pages/homepage.dart';
import 'package:lago/pages/profile.dart';
import 'package:lago/pages/services.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({Key? key}) : super(key: key);

  @override
  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  AuthService _authService = AuthService();
  int _selectedIndex = 0;

  void _onTapItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _pageOptions = <Widget>[
    HomePage(),
    Services(),
    Activity(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Laggo"),
        centerTitle: true,
        backgroundColor: Colors.orange,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                  child: ListTile(
                title: Text("Parcel arrived"),
              )),
              const PopupMenuItem(
                  child: ListTile(
                title: Text("Parcel order confirmed"),
              )),
              const PopupMenuItem(
                  child: ListTile(
                title: Text("Parcel order placed"),
              ))
            ],
            icon: Icon(
              Icons.notifications,
              size: lerpDouble(35.0, 35.0, 20.0),
            ),
          )
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pageOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: _onTapItem,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: "Services"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "Activity"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
