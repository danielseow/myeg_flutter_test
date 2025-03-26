import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:myeg_flutter_test/services/api_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  final client = http.Client();
  ref.onDispose(() {
    client.close();
  });
  return ApiService(client);
});