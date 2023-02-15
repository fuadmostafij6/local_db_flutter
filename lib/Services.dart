


import 'Model.dart';
import 'package:http/http.dart' as http;

class HttpRequest{

  Future<ProductModel?> getProduct() async {

    var request = http.Request(
        'GET', Uri.parse('https://grocery.ebasket.com.bd/api/all-products'));



    http.StreamedResponse response = await request.send();
    var responsedata = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      return productModelFromJson(responsedata.body);
    } else {
      print(response.reasonPhrase);
    }
  }
}