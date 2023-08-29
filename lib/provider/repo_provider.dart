import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/github_repository_api.dart';
import '../models/repo.dart';
import '../repositories/local_data_store.dart';

class RepoProvider extends ChangeNotifier {
  final TextEditingController _searchController = TextEditingController();
  List<RepoModel> _repos = [];
  Set<String> _favorites = {};
  bool _isLoading = false;
  late LocalDataStore _localDataStore;

  RepoProvider();

  TextEditingController get searchController => _searchController;
  LocalDataStore get localDataStore => _localDataStore;
  List<RepoModel> get repos => _repos;
  Set<String> get favorites => _favorites;
  bool get isLoading => _isLoading;

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    _localDataStore = LocalDataStore(prefs);
    final favorites = _localDataStore.getFavorites();
    _favorites.addAll(favorites);
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

  void updateFavoritesAndNotify(String favorite) async {
    bool isFavoriteExists = _favorites.contains(favorite);

    if (isFavoriteExists) {
      favorites.remove(favorite);
      await localDataStore.removeFavorite(favorite);
    } else {
      favorites.add(favorite);
      await localDataStore.addFavorite(favorite);
    }

    _favorites = Set<String>.from(favorites);

    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
