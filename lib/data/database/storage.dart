import 'package:sqflite/sqflite.dart';
import 'package:stock_watchlist/data/model/search_model.dart';

late Database _db;

// Initialize the database (without using getDatabasesPath since you're focusing on single-platform)
Future<void> initializeDatabase() async {
  _db = await openDatabase(
    "stocks.db", // Database name
    version: 1,
    onCreate: (Database db, int version) async {
      // Creating the table to store stock data
      await db.execute(
        '''
        CREATE TABLE stocks (
          symbol TEXT PRIMARY KEY, 
          name TEXT, 
          type TEXT, 
          region TEXT, 
          marketOpen TEXT, 
          marketClose TEXT, 
          timezone TEXT, 
          currency TEXT, 
          matchScore TEXT
        );
        ''',
      );
    },
  );
}


// Add stock to the database
Future<void> addStock(SearchModel stock) async {
  await _db.rawInsert(
    '''
    INSERT INTO stocks (symbol, name, type, region, marketOpen, marketClose, timezone, currency, matchScore) 
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
    ''',
    [
      stock.symbol,
      stock.name,
      stock.type,
      stock.region,
      stock.marketOpen,
      stock.marketClose,
      stock.timezone,
      stock.currency,
      stock.matchScore,
    ],
  );
}

// Delete stock from the database
Future<void> deleteStock(String symbol) async {
  await _db.rawDelete('DELETE FROM stocks WHERE symbol = ?', [symbol]);
}


Future<List<Map<String, String>>> getCompanyNamesAndMatchScores() async {
  final List<Map<String, dynamic>> maps = await _db.rawQuery('SELECT name, matchScore FROM stocks');

  // Convert List<Map<String, dynamic>> to List<Map<String, String>>
  return List.generate(maps.length, (i) {
    return {
      'name': maps[i]['name'],
      'matchScore': maps[i]['matchScore'],
    };
  });
}

Future<List<SearchModel>> getAllStocks() async {
  final List<Map<String, dynamic>> maps = await _db.rawQuery('SELECT * FROM stocks');

  // Convert List<Map<String, dynamic>> to List<SearchModel>
  return List.generate(maps.length, (i) {
    return SearchModel(
      symbol: maps[i]['symbol'],
      name: maps[i]['name'],
      type: maps[i]['type'],
      region: maps[i]['region'],
      marketOpen: maps[i]['marketOpen'],
      marketClose: maps[i]['marketClose'],
      timezone: maps[i]['timezone'],
      currency: maps[i]['currency'],
      matchScore: maps[i]['matchScore'],
    );
  });
}