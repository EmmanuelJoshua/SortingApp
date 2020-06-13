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
  Future<CustomerList> customerData;

  void getCustomerData() {
    customerData = getData();
  }

  Future<void> _getCustomerData1() async {
    setState(() {
      getCustomerData();
    });
  }

  @override
  void initState() {
    super.initState();
    getCustomerData();
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
          Widget demo;

          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              CustomerList content = snapshot.data;

              demo = RefreshIndicator(
                onRefresh: _getCustomerData1,
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemCount: content.customers.length,
                    padding: EdgeInsets.only(top: 10, bottom: 20),
                    separatorBuilder: (context, index) => Divider(
                          thickness: 0.9,
                        ),
                    itemBuilder: (BuildContext context, int index) {
                      String dateString =
                          content.customers[index].date.day.toString() +
                              '/' +
                              content.customers[index].date.month.toString() +
                              '/' +
                              content.customers[index].date.year.toString();
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
                                      return Image.asset(
                                          'assets/images/user.png',
                                          height: 43,
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
                                subtitle: Text(dateString, style: leadlines2),
                                // trailing: Image.asset(
                                //   'assets/images/thumbs.png',
                                //   height: 35,
                                //   width: 35,
                                // ),
                              ),
                            ],
                          ));
                    }),
              );
            } else {
              demo = Center(
                child: IconButton(
                  icon: Icon(
                    Icons.refresh,
                    size: 35,
                    color: primaryText,
                  ),
                  onPressed: () {
                    setState(() {
                      _getCustomerData1();
                    });
                  },
                ),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            demo = Center(
                child: CircularProgressIndicator(
                    valueColor:
                        new AlwaysStoppedAnimation<Color>(primaryText)));
          }
          return demo;
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
