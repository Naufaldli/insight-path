import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/journal_provider.dart';

class InsightScreen extends StatelessWidget {
  const InsightScreen({super.key});

  Widget _getEleganMoodImage(String mood, {double size = 48}) {
    String assetPath;
    switch (mood) {
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

  String _getDynamicSummary(String mood) {
    switch (mood) {
      case 'Bahagia':
        return 'Pikiranmu dipenuhi oleh energi positif yang melimpah hari ini. Manfaatkan momentum ini untuk mengapresiasi hal-hal kecil di sekitarmu.';
      case 'Sedih':
        return 'Merasa mendung di dalam hati adalah hal yang sepenuhnya valid. Berikan dirimu ruang dan waktu ekstra untuk memulihkan energi emosionalmu perlahan.';
      case 'Marah':
        return 'Ada riak emosi yang cukup intens dalam pikiranmu. Tarik napas dalam-dalam; ruang ini aman untuk melepaskan seluruh ketegangan tanpa penghakiman.';
      case 'Lelah':
        return 'Tubuh dan pikiranmu sedang mengirimkan sinyal untuk melambat. Hari ini telah kamu lewati dengan baik, sekarang saatnya mengistirahatkan seluruh penat.';
      case 'Cemas':
        return 'Pikiranmu mungkin sedang berjalan terlalu cepat melompati hari esok. Mari bawa kembali kesadaranmu ke momen saat ini, langkah demi langkah saja.';
      case 'Bersyukur':
        return 'Ruang batinmu berada di titik keseimbangan yang sangat indah. Menyadari berkah sekecil apa pun adalah jangkar terbaik untuk ketenangan jiwamu.';
      default:
        return 'Pikiranmu berada di titik keseimbangan yang sangat baik hari ini. Ruang yang tenang dan jernih untuk berefleksi secara mendalam.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final journalProvider = context.watch<JournalProvider>();
    final currentMood = journalProvider.detectedMood;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAF8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF0D2F24), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Insight AI',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0D2F24)),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined, color: Color(0xFF0D2F24)),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          children: [
            const Text(
              'Analisis Emosimu',
              style: TextStyle(fontSize: 14, color: Color(0xFF626262), letterSpacing: 0.5),
            ),
            const SizedBox(height: 8),
            Text(
              currentMood,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF0D2F24)),
            ),
            const SizedBox(height: 32),

            // Indikator Visual Mood Lingkaran Konsentris
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  // ignore: deprecated_member_use
                  border: Border.all(color: const Color(0xFF0D2F24).withOpacity(0.03), width: 1),
                  boxShadow: [
                    BoxShadow(
                      // ignore: deprecated_member_use
                      color: const Color(0xFF0D2F24).withOpacity(0.01),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAFAF8),
                    shape: BoxShape.circle,
                    // ignore: deprecated_member_use
                    border: Border.all(color: const Color(0xFF0D2F24).withOpacity(0.05), width: 1),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: const Color(0xFF0D2F24).withOpacity(0.04),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: _getEleganMoodImage(currentMood, size: 80),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),

            // Ringkasan Analisis AI
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: const Color(0xFFFFF1E8).withOpacity(0.6),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ringkasan AI',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Color(0xFF0D2F24)),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _getDynamicSummary(currentMood),
                    style: const TextStyle(fontSize: 14, height: 1.6, color: Color(0xFF334E45)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Kutipan Filosofis
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF0D2F24),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  const Text(
                    '"You have power over your mind - not outside events. Realize this, and you will find strength."',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Newsreader',
                      fontSize: 16,
                      color: Color(0xFFFAFAF8),
                      height: 1.5,                      
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '— Marcus Aurelius',
                    style: TextStyle(
                      fontSize: 12, 
                      // ignore: deprecated_member_use
                      color: const Color(0xFFFAFAF8).withOpacity(0.6), 
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const CrossFadeLeadingHeader(title: 'Pertanyaan Refleksi'),
            const SizedBox(height: 12),
            _buildReflectionTile('1. Apa yang bisa kamu lepaskan hari ini?'),
            const SizedBox(height: 8),
            _buildReflectionTile('2. Apa hal kecil yang membuatmu tersenyum tadi?'),
          ],
        ),
      ),
    );
  }

  Widget _buildReflectionTile(String question) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        // ignore: deprecated_member_use
        border: Border.all(color: const Color(0xFF0D2F24).withOpacity(0.04)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              question,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF0D2F24)),
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Color(0xFF8DAA91)),
        ],
      ),
    );
  }
}

class CrossFadeLeadingHeader extends StatelessWidget {
  final String title;
  const CrossFadeLeadingHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          // ignore: deprecated_member_use
          color: const Color(0xFF0D2F24).withOpacity(0.4),
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}