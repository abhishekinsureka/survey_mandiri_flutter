import 'dart:developer';
import 'package:survey_mandiri/data/document_list_response.dart';
import 'package:survey_mandiri/network/api_constant.dart';
import 'package:http/http.dart' as http;

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
}
  