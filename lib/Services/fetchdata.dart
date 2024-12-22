import 'dart:convert';
import 'package:http/http.dart' as http;

class Fetch {
  Future<Map<String, dynamic>?> fetchContractData() async {
    try {
      final response = await http.get(
        Uri.parse('http://13.234.34.248:8083/contract'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var data = await json.decode(response.body)['data'];
        return data; // Return the contract data to the caller
      } else {
        print('Failed to load contract data. Status Code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null; // Return null if an error occurs
    }
  }
}

// A Code Written By Pranay Jha
// https://www.linkedin.com/in/pranay-jha-software/