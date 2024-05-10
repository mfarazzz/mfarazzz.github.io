import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GalleryController extends GetxController {
  RxList<dynamic> images = <dynamic>[].obs;
  RxBool hasMore = true.obs;
  int currentPage = 1;
  String currentSearch = 'all';
  Timer? _debounce;
  final int pageSize = 20;

  @override
  void onInit() {
    fetchImages('all');
    super.onInit();
  }

  void onSearchChanged(String query) {
    currentSearch = query;
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      images.clear();
      currentPage = 1;
      hasMore.value = true;
      fetchImages(query);
    });
  }

  void fetchImages(String query) async {
    if (!hasMore.value) return;
    var url =
        'https://pixabay.com/api/?key=43814678-2c3ebe31e0e4fd543a1d148bc&q=$query&image_type=photo&page=$currentPage&per_page=$pageSize';
    try {
      final response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body);
      var newImages = data['hits'] as List;
      if (newImages.isEmpty) {
        hasMore.value = false;
      } else {
        images.addAll(newImages);
        currentPage++;
      }
    } catch (e) {
      // Handle errors or set state to show error messages
      print('Error fetching data: $e');
    }
  }

  void loadMore() {
    if (currentSearch.isNotEmpty) {
      fetchImages(currentSearch);
    }
  }
}
