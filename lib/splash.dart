import 'package:flutter/material.dart';
import 'package:sks/webview.dart';
import 'package:sks/internet.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final InternetChecker _internetChecker = InternetChecker();

  @override
  void initState() {
    super.initState();
    _internetChecker.startMonitoring((status) async {
      if (status) {
        await Future.delayed(Duration(seconds: 3));
        _navigateToWebView();
      } else {
        _showNoInternetDialog();
      }
    });
  }

  void _navigateToWebView() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewScreen(url: "https://www.thurayarefill.com"),
      ),
    );
  }

  void _showNoInternetDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("No Internet"),
        content: Text("Please check your internet connection and try again."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _internetChecker.stopMonitoring();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF001F3F), // Deep Navy Blue
              Color(0xFF0074D9), // Light Blue
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo2.png',
                width: 200,
              ),
              const SizedBox(height: 30),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              const SizedBox(height: 20),
              const Text(
                "Loading...",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
