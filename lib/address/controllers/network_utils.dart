import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';
import 'package:http/http.dart'
    as http; // Use http package for both mobile and web

class Suggestion {
  final String placeId;
  final String mainText;
  final String secondaryText;

  Suggestion(this.placeId, this.mainText, this.secondaryText);
}

class NetworkUtils {
  static final String androidKey = 'AIzaSyAlZtUVN6Q0y57hHW9hUjtzNriSbUkKojc';
  static final String iosKey = 'AIzaSyAlZtUVN6Q0y57hHW9hUjtzNriSbUkKojc';
  static final String webKey = 'AIzaSyAlZtUVN6Q0y57hHW9hUjtzNriSbUkKojc';

  final apiKey = kIsWeb
      ? webKey
      : Platform.isAndroid
          ? androidKey
          : iosKey;

  Future<List<Suggestion>> fetchSuggestions(String input) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&components=country:kh&key=$apiKey';

    final response = await http.get(Uri.parse(request)); // Use http package

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
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=geometry&key=$apiKey';

    final response = await http.get(Uri.parse(request)); // Use http package

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
