import 'dart:math';

import 'package:SortApp/api/api.dart';
import 'package:SortApp/models/customer.dart';
import 'package:SortApp/theme.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Map<String, Map<int, String>> reviews = {
    'reviewHeader': {0: 'Demo Name1', 1: 'Demo Name2', 2: 'Demo Name3'},
    'reviewText': {0: 'Onboarded', 1: 'Active', 2: 'Left'},
    'reviewerCareer': {0: '04/01/2019', 1: '01/03/2020', 2: '31/01/2020'},
    'reviewer': {0: 'M', 1: 'F', 2: 'M'}
  };

  Future<CustomerList> customerData;

  @override
  void initState() {
    super.initState();
    customerData = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryText,
          leading: IconButton(
              onPressed: () {},
              icon: Icon(CustomIcons.menu),
              color: Colors.white),
          title: Text('Sort App',
              style: TextStyle(
                  fontFamily: 'PTSans',
                  fontSize: 19,
                  color: Colors.white,
                  fontWeight: FontWeight.w600)),
        ),
        body: Container(
            color: Colors.transparent,
            //Listview builder implementation
            child: updateCustomerData()));
  }

  FutureBuilder updateCustomerData() {
    return FutureBuilder<CustomerList>(
        future: customerData,
        builder: (BuildContext context, AsyncSnapshot<CustomerList> snapshot) {
          if (snapshot.hasData) {
            CustomerList content = snapshot.data;
            return ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: content.customers.length,
                padding: EdgeInsets.only(top: 10, bottom: 20),
                separatorBuilder: (context, index) => Divider(
                      thickness: 0.9,
                    ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      margin: EdgeInsets.only(
                          left: 10, right: 10, bottom: 6, top: 8),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 20),
                                child: Text(content.customers[index].name,
                                    style: headlines),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    ' - ' + content.customers[index].status,
                                    style: leadlines),
                              ),
                            ],
                          ),
                          ListTile(
                            leading: ClipOval(
                              clipper: CircleClipper(),
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/user.png',
                                image: content.customers[index].profilePic,
                                imageErrorBuilder:
                                    (context, exception, stacktrace) {
                                  debugPrint('shit');
                                  return Image.asset('assets/images/user.png',  height: 43,
                                width: 43);
                                },
                                fit: BoxFit.fill,
                                height: 43,
                                width: 43,
                              ),
                            ),
                            title: Text(
                                'Gender: ' +
                                    content.customers[index].gender
                                        .toUpperCase(),
                                style: headlines),
                            subtitle: Text(
                                content.customers[index].date.toString(),
                                style: leadlines2),
                            // trailing: Image.asset(
                            //   'assets/images/thumbs.png',
                            //   height: 35,
                            //   width: 35,
                            // ),
                          ),
                        ],
                      ));
                });
          } else {
            return Center(
                child: CircularProgressIndicator(
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(primaryText)));
          }
        });
  }
}

class CircleClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return new Rect.fromCircle(
        center: new Offset(size.width / 2, size.height / 2),
        radius: min(size.width, size.height) / 2);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
