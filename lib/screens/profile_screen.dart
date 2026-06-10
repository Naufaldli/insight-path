import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/journal_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget _getGraphMoodIcon(String mood, {double size = 20}) {
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
        Icons.circle, 
        size: size - 4, 
        color: const Color(0xFFE0A96D),
      ),
    );
  }

  Widget _buildGraphPoint(String day, String mood, double topPadding) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: (130 - topPadding).clamp(0, 120)),
          child: _getGraphMoodIcon(mood, size: 22),
        ),
        const SizedBox(height: 4),
        Text(
          day, 
          style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildSettingTile(
    BuildContext context, {
    required IconData icon, 
    required String title, 
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF0D2F24), size: 22),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF0D2F24)),
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _showActionDialog(BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: const Color(0xFFFAFAF8),
        title: Text(title, style: const TextStyle(color: Color(0xFF0D2F24), fontWeight: FontWeight.bold)),
        content: Text(description, style: const TextStyle(color: Color(0xFF626262))),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup', style: TextStyle(color: Color(0xFF0D2F24), fontWeight: FontWeight.bold)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0D2F24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text('Konfirmasi', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final journalProvider = Provider.of<JournalProvider>(context);

    final int totalJurnal = journalProvider.journals.length;
    final int hariBeruntun = journalProvider.journals.isEmpty ? 0 : 12; 

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAF8),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Profil',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0D2F24)),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Color(0xFF0D2F24)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Membuka Pengaturan Aplikasi...')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Header Info
            Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color(0xFF0D2F24),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.person_outline, color: Colors.white, size: 40),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Naufal',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF0D2F24)),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Jalan refleksimu\nsejak 18 Mei 2026',
                      // ignore: deprecated_member_use
                      style: TextStyle(fontSize: 14, color: const Color(0xFF0D2F24).withOpacity(0.6), height: 1.2),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 28),

            // Statistics Dashboard Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: const Color(0xFF0D2F24),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '$hariBeruntun',
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Hari Beruntun',
                          // ignore: deprecated_member_use
                          style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.7)),
                        ),
                      ],
                    ),
                  ),
                  // ignore: deprecated_member_use
                  Container(width: 1, height: 40, color: Colors.white.withOpacity(0.2)),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '$totalJurnal',
                          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Total Jurnal',
                          // ignore: deprecated_member_use
                          style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.7)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Mood Tracking Graph Section
            Text(
              'Perjalanan Emosimu',
              // ignore: deprecated_member_use
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0D2F24).withOpacity(0.4)),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                // ignore: deprecated_member_use
                border: Border.all(color: const Color(0xFF0D2F24).withOpacity(0.05)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Minggu ini',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF0D2F24)),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 150,
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(6, (index) => Container(
                            height: 1,
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.03),
                          )),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: ['100', '80', '60', '40', '20', '0']
                              .map((val) => Text(val, style: const TextStyle(fontSize: 10, color: Colors.grey))).toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 32.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _buildGraphPoint('Mo', 'Sedih', 110),
                              _buildGraphPoint('Tu', 'Lelah', 100),
                              _buildGraphPoint('We', 'Bahagia', 40),
                              _buildGraphPoint('Th', 'Tenang', 70),
                              _buildGraphPoint('Fr', 'Marah', 80),
                              _buildGraphPoint('Sa', 'Cemas', 75),
                              _buildGraphPoint('Su', 'Bersyukur', 25),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(width: 12, height: 3, color: const Color(0xFF9FA8DA)),
                      const SizedBox(width: 6),
                      const Text('Mood', style: TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500)),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Settings Interactive Section
            Text(
              'Pengaturan',
              // ignore: deprecated_member_use
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: const Color(0xFF0D2F24).withOpacity(0.4)),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                // ignore: deprecated_member_use
                border: Border.all(color: const Color(0xFF0D2F24).withOpacity(0.05)),
              ),
              child: Column(
                children: [
                  _buildSettingTile(
                    context,
                    icon: Icons.notifications_none_outlined,
                    title: 'Notifikasi',
                    onTap: () {
                      _showActionDialog(context, 'Notifikasi', 'Mengatur jadwal pengingat harian menulis jurnal.');
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    // ignore: deprecated_member_use
                    child: Divider(height: 1, color: const Color(0xFF0D2F24).withOpacity(0.05)),
                  ),
                  _buildSettingTile(
                    context,
                    icon: Icons.psychology_outlined,
                    title: 'Personalisasi AI',
                    onTap: () {
                      _showActionDialog(context, 'Personalisasi AI', 'Menyesuaikan gaya respon dari model agen analisis emosimu.');
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    // ignore: deprecated_member_use
                    child: Divider(height: 1, color: const Color(0xFF0D2F24).withOpacity(0.05)),
                  ),
                  _buildSettingTile(
                    context,
                    icon: Icons.palette_outlined,
                    title: 'Tema',
                    onTap: () {
                      _showActionDialog(context, 'Tema Aplikasi', 'Mengganti skema palet warna batin (Dark/Light/Warm).');
                    },
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