import 'dart:convert';
import 'dart:developer';

import 'package:stock_watchlist/core/constant.dart';

import 'package:http/http.dart' as http;
import 'package:stock_watchlist/data/model/search_model.dart';

class SearchStockService {
  Future<List<SearchModel>> searchStock({required String searchText}) async {
    try {
      String baseUrl =
          'https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=$searchText&apikey=$apiKey';
      final response = await http.get(Uri.parse(baseUrl));

      // Decode the JSON response
      final data = jsonDecode(response.body);

      // Create a list to hold the result
      List<SearchModel> result = [];

      // Check if 'bestMatches' exists and is a list
      if (data["bestMatches"] != null) {
        for (var item in data["bestMatches"]) {
          result.add(SearchModel.fromJson(item));
        }
      }

      // Return the list of results
      return result;
    } catch (e) {
      log(e.toString());

      // Return an empty list in case of error
      return [];
    }
  }
  
}
