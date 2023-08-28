import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class LocalDataStore {
  final Database database;

  LocalDataStore(this.database);

  final StoreRef<int, Map<String, dynamic>> favoriteStore =
      intMapStoreFactory.store("favorites");

  final StoreRef<int, Map<String, dynamic>> historyStore =
      intMapStoreFactory.store("search_history");

  Future<void> addFavorite(Map<String, dynamic> favorite) async {
    await favoriteStore.add(database, favorite);
  }

  Future<void> removeFavorite(int id) async {
    await favoriteStore.record(id).delete(database);
  }

  Future<List<RecordSnapshot<int, Map<String, dynamic>>>> getFavorites() async {
    final finder = Finder(sortOrders: [SortOrder(Field.key)]);
    final snapshots = await favoriteStore.find(database, finder: finder);
    return snapshots;
  }

  Future<void> saveSearchHistory(Map<String, dynamic> searchQuery) async {
    await historyStore.add(database, searchQuery);
  }

  Future<List<RecordSnapshot<int, Map<String, dynamic>>>>
      getSearchHistory() async {
    final finder = Finder(sortOrders: [SortOrder(Field.key)]);
    final snapshots = await historyStore.find(database, finder: finder);
    return snapshots;
  }
}

Future<LocalDataStore> initializeDatabase() async {
  final appDocumentDir = await getApplicationDocumentsDirectory();
  final dbPath = join(appDocumentDir.path, 'repo_search_app.db');

  final database = await databaseFactoryIo.openDatabase(dbPath);

  return LocalDataStore(database);
}
