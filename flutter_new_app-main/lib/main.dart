import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_new_app/Scene/Home.dart';
import 'package:flutter_new_app/Scene/Profile.dart';
import 'API/PushNotificationService.dart';
import 'Scene/Message.dart';
import 'Scene/SeachView.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var initializationSettingsAndroid ;
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
        if (payload != null) {
          debugPrint('notification payload: ' + payload);
        }
      });
  runApp(MyHomePage());
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver{
  int _currentIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
   super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        // await detachedCallBack();
        break;
      case AppLifecycleState.resumed:
        // await resumeCallBack();
        break;
    }
    // WidgetsBinding.instance.removeObserver(this);
    SetNotif(DateTime.now().add(Duration(seconds: 10)));
  }


  final List<Widget> _children = [
    Home(),
    MessagePage(),
    ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {

    // if( _scaffoldKey.currentState != null ){
    //   if (_scaffoldKey.currentState.isDrawerOpen) Navigator.pop(context);
    // }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/Search': (context) => const SeachView(),
      },
      home: Scaffold(

        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          title: Text((_currentIndex == 1 ) ? "Message" : "",style: TextStyle(color: Colors.black ),),
          centerTitle: true,
          leading:  IconButton(
            icon: const Icon(
                              Icons.menu,
                              color: Colors.black,
                              size: 30.0,),
            onPressed: () =>  _scaffoldKey.currentState.openDrawer(),
          ),
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              new Container(
                  height: 250.0,
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new ExactAssetImage(
                          'assets/logoNews.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  )),
              ListTile(
                title: const Text('Profile'),
                onTap: () {
                  // Update the state of the app.
                 setState(() {
                    _currentIndex = 2 ;
                 });
                },
              ),
              ListTile(
                title: const Text('Message'),
                onTap: () {
                  setState(() {
                    _currentIndex = 1 ;
                  });
                },
              ),
              ListTile(
                title: const Text('Home'),
                onTap: () {
                  // Update the state of the app.
                  setState(() {
                    _currentIndex = 0 ;
                  });
                },
              ),
            ],
          ),
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped, // new
          currentIndex: _currentIndex, // new
          // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.mail),
              title: new Text('Messages'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('Profile')
            )
          ],
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

}

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}


