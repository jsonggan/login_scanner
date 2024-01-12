import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_scanner/src/display_user/api_response_model.dart';

class Testing extends StatelessWidget {
  const Testing({super.key});

  static const routeName = "/testing";

  void onPressed() async {
    var uri = Uri.parse('https://cimbwealthsymposium.com/?event_qr_code=1&ticket_id=4922&event_id=4591&security_code=b8933f8bf6&path=wp-json%2Ftribe%2Ftickets%2Fv1%2Fqr');
    var queryParams = uri.queryParameters;

    // Extracted parameters
    String eventQrCode = queryParams['event_qr_code'] ?? '';
    String ticketId = queryParams['ticket_id'] ?? '';
    String eventId = queryParams['event_id'] ?? '';
    String securityCode = queryParams['security_code'] ?? '';
    String path = queryParams['path'] ?? '';

    // API key
    String apiKey = 'e04e6b86';

    // Construct API URL
    var apiUrl = Uri.parse('https://cimbwealthsymposium.com/$path')
      .replace(queryParameters: {
        'event_qr_code': eventQrCode,
        'ticket_id': ticketId,
        'event_id': eventId,
        'security_code': securityCode,
        'api_key': apiKey
      });

    print(apiUrl);
    var response;
    // Make the GET request
    try {
      response = await http.get(apiUrl);
      print("print the response body");
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 403) {
        // Handle the API response
        print('Success: ${response.body}');
      } else {
        // Handle errors
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      print('An error occurred: $e');
    }

    AttendeeResponse attendeeResponse = AttendeeResponse.fromJson(jsonDecode(response.body));

    print(attendeeResponse.message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ElevatedButton(onPressed: onPressed, child: Text('press')));
  }
}