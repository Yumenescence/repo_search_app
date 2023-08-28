import 'package:flutter/material.dart';

import '../api/github_repository_api.dart';
import '../models/repo.dart';
import '../repositories/local_data_store.dart';

class RepoProvider extends ChangeNotifier {
  late LocalDataStore _database;
  final TextEditingController _searchController = TextEditingController();
  List<RepoModel> _repos = [];
  final Set<String> _favorites = {};
  bool _isLoading = false;

  RepoProvider();

  TextEditingController get searchController => _searchController;
  List<RepoModel> get repos => _repos;
  Set<String> get favorites => _favorites;
  bool get isLoading => _isLoading;

  Future<void> initialize() async {
    _database = await initializeDatabase();
    final favorites = await _database.getFavorites();
    _favorites.addAll(favorites.map((e) => RepoModel.fromJson(e.value).name));
    notifyListeners();
  }

  Future<void> searchRepositories() async {
    _setLoading(true);
    _repos = await _fetchRepositories();
    _setLoading(false);
  }

  Future<List<RepoModel>> _fetchRepositories() async {
    return await getRepositoriesByName(_searchController.text);
  }

  void updateFavoritesAndNotify(RepoModel favorite) async {
    bool isFavoriteExists = _favorites.contains(favorite.name);

    if (isFavoriteExists) {
      _favorites.remove(favorite.name);
      await _database.removeFavorite(favorite.id);
    } else {
      _favorites.add(favorite.name);
      await _database.addFavorite(favorite.toJson());
    }
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
