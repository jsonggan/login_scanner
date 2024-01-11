import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_scanner/src/display_user/api_response_model.dart';
import 'package:login_scanner/src/display_user/display_user_view.dart';
import 'package:http/http.dart' as http;

class QrReaderView extends StatefulWidget {
  const QrReaderView({
    super.key,
  });

  @override
  State<QrReaderView> createState() => _QrReaderViewState();
}

class _QrReaderViewState extends State<QrReaderView> {
  final FocusNode _focusNode = FocusNode();
  String _scannedCode = '';

  @override
  void dispose() {
    // _focusNode.dispose();
    super.dispose();
  }

  void _handleKey(RawKeyEvent event) async {
    if (event is RawKeyDownEvent) {
      final key = event.data.logicalKey;

      if (key == LogicalKeyboardKey.enter) {
        // Do something when ENTER key is pressed
        print('Scanned QR Code: $_scannedCode');
        String finalCode = _scannedCode;
        
        setState(() {
          _scannedCode = '';
        });
        
        if (finalCode[0] == '[') {
          // implement logic to update url and api key
          Navigator.pushReplacementNamed(context, DisplayUserView.routeName, arguments: "Replace URL and API KEY with latest value.",);
        } else {
          // logic to make call for user login status
          // Extract parameters from finalCode
          var uri = Uri.parse('https://cimbwealthsymposium.com/?event_qr_code=1&ticket_id=5176&event_id=4591&security_code=faca84815d&path=wp-json%2Ftribe%2Ftickets%2Fv1%2Fqr');
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


          Navigator.pushNamed(
            context,
            DisplayUserView.routeName,
            arguments: attendeeResponse,
          );
        }
        
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        
        
      } else {
        // Check if the key is a character key
        final String keyLabel = key.keyLabel;
        if (keyLabel.length == 1 && event.data is RawKeyEventDataAndroid) {
          final RawKeyEventDataAndroid data = event.data as RawKeyEventDataAndroid;
          String char = keyLabel;
          
          // Handle shift key for capitalization
          if (data.isShiftPressed) {
            char = char.toUpperCase();
          } else {
            char = char.toLowerCase();
          }
          
          setState(() {
            _scannedCode += char;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      autofocus: true,
      focusNode: _focusNode,
      onKey: _handleKey,
      child: Container(),
    );
  }
}