import 'package:bmkg_rest/controllerLogin.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import 'package:bmkg_rest/api/model.dart';
import 'package:bmkg_rest/api/api_service.dart';
import 'package:http/http.dart' as http;

final GoogleSignIn gSignIn = GoogleSignIn();

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.black87,
  primary: Colors.blue,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  loginUIController() {
    return Consumer<ControllerLogin>(builder: (context, model, child) {
      if (model.userDetailsModel != null) {
        return Center(
          child: alreadyLoggedInScreen(model),
        );
      } else {
        return NotLoggedInScreen();
      }
    });
  }

  NotLoggedInScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Image.network(
              'https://cdn.bmkg.go.id/Web/Logo-BMKG-new-242x300.png', //Static file image network
              height: 200,
              width: 200,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton.icon(
            onPressed: () {
              Provider.of<ControllerLogin>(context, listen: false)
                  .allowUserToLogin();
            },
            icon: Icon(
              // <-- Icon
              Icons.login,
              size: 24.0,
            ),
            label: Text('Login With Google'), // <-- Text
          ),
          // GestureDetector(
          //   onTap: () {
          //     Provider.of<ControllerLogin>(context, listen: false)
          //         .allowUserToLogin();
          //   },
          //   child: Image.asset(
          //     "assets/images/search.png",
          //     width: 250,
          //   ),
          // ),
        ],
      ),
    );
  }

  alreadyLoggedInScreen(ControllerLogin model) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gempa Bumi"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Provider.of<ControllerLogin>(context, listen: false)
                  .allowUserToLogout();
            },
            icon: const Icon(Icons.logout_outlined),
            tooltip: 'Logout',
          )
        ],
      ),
      body: FutureBuilder<List<Item>>(
        future: fetchItems(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return ItemList(items: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: loginUIController(),
    );
  }
}

class ItemList extends StatelessWidget {
  const ItemList({Key? key, required this.items});

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: RichText(
                  text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                    TextSpan(
                        text: "Tanggal : " + items[index].tanggal,
                        style: TextStyle(color: Colors.black.withOpacity(0.9)))
                  ])),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: RichText(
                  text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                    TextSpan(
                        text: "Jam : " + items[index].jam,
                        style: TextStyle(color: Colors.black.withOpacity(0.9)))
                  ])),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: RichText(
                  text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                    TextSpan(
                        text: "Wilayah : " + items[index].wilayah,
                        style: TextStyle(color: Colors.black.withOpacity(0.9)))
                  ])),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: RichText(
                  text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                    TextSpan(
                        text: "Potensi : " + items[index].potensi,
                        style: TextStyle(color: Colors.black.withOpacity(0.9)))
                  ])),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Image.network(
                items[index].image,
                // width: 110,
                // height: 110,
              ),
            ),
          ],
        );
      },
    );
  }
}
