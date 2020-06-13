import 'package:intl/intl.dart';

class CustomerList {
  final List<Customer> customers;

  CustomerList({this.customers});

  // @override
  // int compareTo(Customer other) {
  //   int order = other.date.compareTo(other.date);
  //   // if(order == 0)
  //   return order;
  // }

  factory CustomerList.fromJson(Map<String, dynamic> json) {
    var list = json['list'] as List;
    print(list.runtimeType);
    List<Customer> customerList =
        list.map((i) => Customer.fromJson(i)).toList();

    customerList.sort((a, b) {
      var ad = a.date;
      var bd = b.date;
      var s = ad.compareTo(bd);
      // if (s == 0) {
      //   return b.status.compareTo(a.status);
      // } else {
      return s;
      // }
    });

    List<Customer> customerList2 = customerList;

    customerList2.sort((a, b) {
      var ad = a.status;
      var bd = b.status;
      var s = ad.compareTo(bd);
      return s;
    });

    return CustomerList(customers: customerList2);
  }
}

class Customer {
  final String name;
  final int age;
  final String gender;
  final String profilePic;
  final DateTime date;
  final String status;

  Customer(
      {this.name,
      this.age,
      this.gender,
      this.profilePic,
      this.date,
      this.status});

  factory Customer.fromJson(Map<dynamic, dynamic> json) {
    var parsedDate =
        (new DateFormat('dd/MM/yyyy').parse(json['date'].toString()));
    return Customer(
      name: json['name'],
      age: json['age'],
      gender: json['gender'],
      profilePic: json['img'],
      date: parsedDate,
      status: json['status'],
    );
  }
}
