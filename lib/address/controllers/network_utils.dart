import 'dart:convert';
import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart'; // Import web package

class Suggestion {
  final String placeId;
  final String mainText;
  final String secondaryText;

  Suggestion(this.placeId, this.mainText, this.secondaryText);
}

// Define an abstract class for place details functionality
abstract class PlaceDetailsFetcher {
  Future<LatLng?> fetchPlaceDetails(String placeId);
}

class NetworkUtils {
  final client = Client();

  static final String androidKey = 'AIzaSyCG2YHIuPJYMOJzS6wSw5eZ0dTYXnhZFLs';
  static final String iosKey = 'AIzaSyCG2YHIuPJYMOJzS6wSw5eZ0dTYXnhZFLs';

  // Define your web API key here
  static final String webKey = 'AIzaSyCG2YHIuPJYMOJzS6wSw5eZ0dTYXnhZFLs';

  final String apiKey = kIsWeb
      ? webKey
      : Platform.isAndroid
          ? androidKey
          : iosKey;

  Future<List<Suggestion>> fetchSuggestions(String input) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&components=country:kh&key=$apiKey';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        return result['predictions']
            .map<Suggestion>(
              (p) => Suggestion(
                p['place_id'],
                p['structured_formatting']['main_text'],
                p['structured_formatting']['secondary_text'],
              ),
            )
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future getPlaceDetailFromId(String placeId) async {
    /**if (kIsWeb) {
      // Use the web implementation for fetching place details
      final placeDetails = await WebPlaceDetailsFetcher().fetchPlaceDetails(placeId);
      return placeDetails;
    } else {**/
    // Use the existing Android/iOS implementation for other platforms
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=geometry&key=$apiKey';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        print(response.body);
        LatLng latLng = LatLng(
          result['result']['geometry']['location']['lat'],
          result['result']['geometry']['location']['lng'],
        );
        return latLng;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}


// Create a concrete implementation for web using the google_maps_flutter_web package
/**class WebPlaceDetailsFetcher implements PlaceDetailsFetcher {
  @override
  Future<LatLng?> fetchPlaceDetails(String placeId) async {
    // Implement web-specific logic here to fetch place details
    // Example: use google_maps_flutter_web APIs to fetch details
    return null; // Placeholder for web implementation
  }
}**/
