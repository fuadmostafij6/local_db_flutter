


import 'Model.dart';
import 'package:http/http.dart' as http;

class HttpRequest{

  Future<ProductModel?> getProduct() async {

    var request = http.Request(
        'GET', Uri.parse('https://grocery.ebasket.com.bd/api/all-products'));

//fe

    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      // print("RESPONSE --${responsedata.body}");
      // print("RESPONSE --${responsedata.reasonPhrase}");
      return productModelFromJson(responsedata.body);
    } else {
      print(response.reasonPhrase);
    }
  }
}