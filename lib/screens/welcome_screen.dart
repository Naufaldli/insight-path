import 'package:flutter/material.dart';
import 'main_navigation.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D2F24),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/image/welcome_bg.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          
          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    // ignore: deprecated_member_use
                    const Color(0xFF0D2F24).withOpacity(0.4),
                    // ignore: deprecated_member_use
                    const Color(0xFF0D2F24).withOpacity(0.2),
                    // ignore: deprecated_member_use
                    const Color(0xFF0D2F24).withOpacity(0.7),
                    const Color(0xFF0D2F24),
                  ],
                ),
              ),
            ),
          ),
          
          // Screen Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  
                  // Logo and App Title Section
                  Column(
                    children: [
                      Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              // ignore: deprecated_member_use
                              color: const Color(0xFF0D2F24).withOpacity(0.15),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              'assets/image/logo.jpeg',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'insight path',
                        style: TextStyle(
                          fontFamily: 'AppleNewYork',
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFFAFAF8),
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Ruang untuk memahami dirimu.',
                        style: TextStyle(
                          fontSize: 14,
                          // ignore: deprecated_member_use
                          color: const Color(0xFFFAFAF8).withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  
                  // Call to Action Section
                  Column(
                    children: [
                      const Text(
                        'Tarik napas\ndalam-dalam...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'AppleNewYork',
                          fontSize: 20,
                          color: Color(0xFFFAFAF8),
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 40),
                      
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFAFAF8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                            elevation: 0,
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (context, anim, secAnim) => const MainNavigation(),
                                transitionsBuilder: (context, anim, secAnim, child) =>
                                    FadeTransition(opacity: anim, child: child),
                                transitionDuration: const Duration(milliseconds: 800),
                              ),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Mulai Perjalanan',
                                style: TextStyle(
                                  color: Color(0xFF0D2F24),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward, color: Color(0xFF0D2F24), size: 18),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}