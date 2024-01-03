import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:semator/controlling.dart';
import 'package:semator/controlling/contpageone.dart';
import 'package:semator/controlling/contpagetwo.dart';
import 'package:semator/dashboard.dart';
import 'package:semator/dashboard/dashpage1.dart';
import 'package:semator/dashboard/dashpage2.dart';
import 'package:semator/homepage.dart';
import 'package:semator/wifi.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Controlling extends StatefulWidget {
  const Controlling({super.key});

  @override
  State<Controlling> createState() => _ControllingState();
}

class _ControllingState extends State<Controlling> {
  //untuk memasikan page mana yang bisa di slides
  PageController _controller = PageController();

  //last page jadi start
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar:
            AppBar(title: Text('Controlling'), backgroundColor: Colors.purple),
        drawer: Drawer(
          child: Container(
            color: Colors.purple, // Warna ungu untuk sidebar
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                SizedBox(
                  height: 70,
                ),
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Monitoring',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: (() => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Dashboard()))),
                ),
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Controlling',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: (() => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Controlling()))),
                ),
                ListTile(
                  leading: Icon(
                    Icons.wifi,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Setting Wifi',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: (() => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => wifi()))),
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  onLastPage = (index == 1);
                });
              },
              children: [contpageone(), contpagetwo()],
            ),

            //dot indicator
            Container(
                alignment: Alignment(0, 0.8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //skip
                    GestureDetector(
                        onTap: () {
                          _controller.previousPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: Text('Dehyd')),
                    //dot
                    SmoothPageIndicator(controller: _controller, count: 2),
                    GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: Text('Timer')),
                  ],
                )),
          ],
        ));
  }
}
