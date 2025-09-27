import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiConstants {
  static const String baseUrl = 'https://reqres.in/api';
  static const String usersEndpoint = '/users';
 


  
  
  static const Map<String, String> apiHeader = {
    'Content-Type': 'application/json',
   'x-api-key': 'reqres-free-v1'

  };
  

  static const int successCode = 200;
  static const int notFoundCode = 404;
  static const int serverErrorCode = 500;
  static const int unauthorizedCode = 401;
}


class ApiHelper {
  
  static String buildUrl(String endpoint, {Map<String, dynamic>? queryParams}) {
    String url = '${ApiConstants.baseUrl}$endpoint';
    
    if (queryParams != null && queryParams.isNotEmpty) {
      String queryString = queryParams.entries
          .map((e) => '${e.key}=${e.value}')
          .join('&');
      url += '?$queryString';
    }
    
    return url;
  }
  
  static Future<ApiResponse> makeGetRequest(String endpoint, {Map<String, dynamic>? queryParams}) async {
    try {
      String url = buildUrl(endpoint, queryParams: queryParams);
      
      http.Response response = await http.get(
        Uri.parse(url),
        headers: ApiConstants.apiHeader,
      );
      
      return ApiResponse(
        statusCode: response.statusCode,
        data: response.statusCode == ApiConstants.successCode 
            ? json.decode(response.body) 
            : null,
        errorMessage: response.statusCode != ApiConstants.successCode 
            ? 'Request failed with status: ${response.statusCode}'
            : null,
      );
    } catch (e) {
      return ApiResponse(
        statusCode: 0,
        data: null,
        errorMessage: 'Network error: ${e.toString()}',
      );
    }
  }
}

class ApiResponse {
  final int statusCode;
  final dynamic data;
  final String? errorMessage;
  
  ApiResponse({
    required this.statusCode,
    this.data,
    this.errorMessage,
  });
  
  bool get isSuccess => statusCode == ApiConstants.successCode;
}

class ResponseMessages {
  static const String networkError = 'Network error occurred';
  static const String serverError = 'Server error occurred';
  static const String unknownError = 'Unknown error occurred';
  static const String noDataFound = 'No data found';
}