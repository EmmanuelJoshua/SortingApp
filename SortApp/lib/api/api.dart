import 'dart:convert';

import 'package:SortApp/models/customer.dart';
import 'package:http/http.dart';

Future<CustomerList> getData() async {
  String apiUrl =
      'https://5w05g4ddb1.execute-api.ap-south-1.amazonaws.com/dev/profile/listAll';

  final Response response = await get(apiUrl);

  if (response.statusCode == 200) {
    return CustomerList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load customer data');
  }
}
