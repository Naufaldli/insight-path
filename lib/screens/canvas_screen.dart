import 'package:flutter/material.dart';
import 'package:insight_path/screens/insight_screen.dart';
import 'package:provider/provider.dart';
import '../providers/journal_provider.dart';

class CanvasScreen extends StatefulWidget {
  const CanvasScreen({super.key});

  @override
  State<CanvasScreen> createState() => _CanvasScreenState();
}

class _CanvasScreenState extends State<CanvasScreen> {
  final TextEditingController _textController = TextEditingController();

  Widget _getEleganMoodImage(String mood, {double size = 40}) {
    String assetPath;
    switch (mood) {
      case 'Tenang': assetPath = 'assets/image/tenang.png'; break;
      case 'Bahagia': assetPath = 'assets/image/bahagia.png'; break;
      case 'Sedih': assetPath = 'assets/image/sedih.png'; break;
      case 'Marah': assetPath = 'assets/image/marah.png'; break;
      case 'Lelah': assetPath = 'assets/image/lelah.png'; break;
      case 'Cemas': assetPath = 'assets/image/cemas.png'; break;
      case 'Bersyukur': assetPath = 'assets/image/bersyukur.png'; break;
      default: assetPath = 'assets/image/tenang.png';
    }

    return Image.asset(
      assetPath,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) => Icon(
        Icons.sentiment_satisfied, 
        size: size, 
        color: const Color(0xFF0D2F24),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final journalProvider = Provider.of<JournalProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAF8),
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Color(0xFF0D2F24), size: 26),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Column(
                    children: [
                      Text(
                        'Senin, 25 Mei',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF0D2F24)),
                      ),
                      Text(
                        '20.45',
                        style: TextStyle(fontSize: 12, color: Color(0xFF626262)),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      journalProvider.saveJournal();
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Selesai',
                      style: TextStyle(
                        fontSize: 15, 
                        fontWeight: FontWeight.w600, 
                        color: Color(0xFF8DAA91),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Input Workspace
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Apa yang sedang\nkamu rasakan hari ini?',
                      style: TextStyle(
                        fontSize: 26, 
                        fontWeight: FontWeight.bold, 
                        color: Color(0xFF0D2F24),
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _textController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      onChanged: (text) {
                        if (journalProvider.canAnalyzeLocally) {
                          journalProvider.analyzeMoodLocally(text);
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: 'Mulai menulis di sini...',
                        hintStyle: TextStyle(fontSize: 16, color: Color(0xFFB4B4B4)),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        fontSize: 15, 
                        color: Color(0xFF0D2F24), 
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Panel Actions
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      // ignore: deprecated_member_use
                      border: Border.all(color: const Color(0xFF0D2F24).withOpacity(0.06)),
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mood terdeteksi',
                              style: TextStyle(
                                fontSize: 12, 
                                fontWeight: FontWeight.w600, 
                                // ignore: deprecated_member_use
                                color: const Color(0xFF0D2F24).withOpacity(0.5)
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              journalProvider.detectedMood.isEmpty ? 'Tenang' : journalProvider.detectedMood,
                              style: const TextStyle(
                                fontSize: 16, 
                                fontWeight: FontWeight.bold, 
                                color: Color(0xFF0D2F24)
                              ),
                            ),
                          ],
                        ),
                        _getEleganMoodImage(
                          journalProvider.detectedMood.isEmpty ? 'Tenang' : journalProvider.detectedMood, 
                          size: 44
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, anim, secAnim) => const InsightScreen(),
                            transitionsBuilder: (context, anim, secAnim, child) => FadeTransition(opacity: anim, child: child),
                            transitionDuration: const Duration(milliseconds: 500),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0D2F24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Analisis Emosi',
                        style: TextStyle(
                          color: Colors.white, 
                          fontSize: 15, 
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}