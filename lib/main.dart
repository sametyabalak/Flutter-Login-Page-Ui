import 'package:d8_flutter_splashscreen_login_ui/Animations/FadeAnimation.dart';
import 'package:d8_flutter_splashscreen_login_ui/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController _scaleController;
  AnimationController _scale2Controller;
  AnimationController _widthController;
  AnimationController _positionController;

  Animation<double> _scaleAnimation;
  Animation<double> _scale2Animation;
  Animation<double> _widthAnimation;
  Animation<double> _positionAnimation;

  bool hideIcon = false;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.8,
    ).animate(_scaleController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _widthController.forward();
        }
      });

    _scale2Controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _scale2Animation = Tween<double>(
      begin: 1.0,
      end: 32.0,
    ).animate(_scale2Controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.push(
              context,
              PageTransition(
                  child: LoginPage(), type: PageTransitionType.fade));
        }
      });

    _widthController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );

    _widthAnimation = Tween<double>(
      begin: 80.0,
      end: 300.0,
    ).animate(_widthController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _positionController.forward();
        }
      });

    _positionController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
    );

    _positionAnimation = Tween<double>(
      begin: 0.0,
      end: 220.0,
    ).animate(_positionController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            hideIcon = true;
          });
          _scale2Controller.forward();
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 8, 23, 1),
      body: Container(
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: FadeAnimation(
                1,
                Container(
                  width: width,
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/one.png'),
                    fit: BoxFit.fitHeight,
                  )),
                ),
              ),
            ),
            Positioned(
              top: -50,
              left: 0,
              child: FadeAnimation(
                1.3,
                Container(
                  width: width,
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/one.png'),
                    fit: BoxFit.fitHeight,
                  )),
                ),
              ),
            ),
            Positioned(
              top: -100,
              left: 0,
              child: FadeAnimation(
                1.6,
                Container(
                  width: width,
                  height: 400,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/images/one.png'),
                    fit: BoxFit.fitHeight,
                  )),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(
                    1,
                    Text(
                      "Welcome",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                    1.3,
                    Text(
                      "We promise that you'll have the most \nfuss-free time with us ever.",
                      style: TextStyle(
                          color: Colors.white.withOpacity(.5), height: 1.4),
                    ),
                  ),
                  SizedBox(
                    height: 180,
                  ),
                  FadeAnimation(
                    1.6,
                    AnimatedBuilder(
                      animation: _scaleController,
                      builder: (context, child) => Transform.scale(
                        scale: _scaleAnimation.value,
                        child: AnimatedBuilder(
                          animation: _widthController,
                          builder: (context, child) => Center(
                            child: Container(
                              width: _widthAnimation.value,
                              height: 80,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: Colors.blue.withOpacity(.4),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  _scaleController.forward();
                                },
                                child: Stack(
                                  children: <Widget>[
                                    AnimatedBuilder(
                                      animation: _positionController,
                                      builder: (context, child) => Positioned(
                                        left: _positionAnimation.value,
                                        child: AnimatedBuilder(
                                          animation: _scale2Controller,
                                          builder: (context, child) =>
                                              Transform.scale(
                                            scale: _scale2Animation.value,
                                            child: Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.blue,
                                              ),
                                              child: hideIcon == false
                                                  ? Icon(
                                                      Icons.arrow_forward,
                                                      color: Colors.white60,
                                                    )
                                                  : Container(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
