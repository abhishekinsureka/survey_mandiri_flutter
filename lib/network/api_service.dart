import 'dart:developer';
import 'package:survey_mandiri/data/document_list_response.dart';
import 'package:survey_mandiri/network/api_constant.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  Future<DocumentList?> fetchDocuments(String quoteId) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.documentListEndpoint + quoteId);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        DocumentList model = documentListFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<void> uploadComplete(String snowflake,String baseUrl, String name, String relativeUrl) async {
  // Define the API endpoint
  String apiUrl = 'https://cellular-way-359305.et.r.appspot.com/api/v2/upload-complete/$snowflake/';

  // Define the JSON request body
  Map<String, dynamic> requestBody = {
    "documents": [
      {
        "base_url": baseUrl,
        "name": name,
        "relative_url": relativeUrl
      }
    ]
  };

  // Encode the JSON body
  String jsonBody = json.encode(requestBody);

  try {
    // Make the POST request
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonBody,
    );

    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Handle successful response
      print('Upload successful');
    } else {
      // Handle errors
      print('Failed to upload data. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  } catch (e) {
    // Handle exceptions
    print('Exception during upload: $e');
  }
}
}
  