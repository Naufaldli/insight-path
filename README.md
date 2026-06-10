# Insight Path 🍃

**Insight Path** adalah aplikasi jurnal refleksi diri dan pelacakan emosi (*mood tracking*) berbasis mobile yang dirancang untuk memberikan ruang aman bagi pengguna dalam memahami kondisi emosional mereka. Aplikasi ini mengombinasikan antarmuka yang intuitif dan premium dengan analisis emosi lokal serta penyimpanan data yang aman secara *offline*.

---

## 🚀 Alur Pembuatan & Arsitektur Aplikasi

Proses pengembangan **Insight Path** dilakukan secara terstruktur dengan menerapkan prinsip pemisahan tanggung jawab (*Separation of Concerns*) menggunakan arsitektur **MVVM (Model-View-ViewModel)** yang dimodifikasi untuk ekosistem Flutter (menggunakan *Provider*).

Berikut adalah detail tahapan alur pembuatan dan arsitektur aplikasinya:

### 1. Perancangan Struktur Direktori (Clean Folder Structure)
Untuk menjaga kode tetap modular, mudah dirawat (*maintainable*), dan siap untuk skala produksi, struktur folder dibagi menjadi beberapa layer utama:
* `core/database/`: Menangani persistensi data lokal (SQLite).
* `providers/`: Bertindak sebagai *State Management* (Controller/ViewModel) yang mengatur logika bisnis dan menjembatani UI dengan data.
* `screens/`: Berisi layer presentasi (View) atau antarmuka halaman aplikasi.
* `assets/`: Menyimpan aset statis seperti gambar latar belakang (`.jpeg`) dan font kustom (`AppleNewYork`).

### 2. Implementasi Persistensi Data Lokal (`DatabaseHelper`)
* **Teknologi:** Menggunakan SQLite melalui paket `sqflite`.
* **Alur:** Membuat kelas *Singleton* `DatabaseHelper` untuk mengelola koneksi database secara terpusat. Lapisan ini bertanggung jawab untuk menginisialisasi tabel jurnal, menangani operasi *Insert* saat pengguna menyimpan refleksi baru, serta *Fetch/Query* untuk memuat seluruh riwayat jurnal yang tersimpan.

### 3. Logika Bisnis & Analisis Emosi (`JournalProvider`)
State management menggunakan `Provider` dan `ChangeNotifier` untuk memastikan sinkronisasi data yang reaktif antara kodingan logika dan tampilan layar.
* **Analisis Emosi Lokal:** Mengimplementasikan algoritma berbasis heuristik teks (pemetaan kata kunci) untuk mendeteksi 7 kondisi emosi utama (*Bahagia, Sedih, Marah, Lelah, Cemas, Bersyukur,* dan *Tenang*) secara *real-time* saat pengguna mengetik.
* **Transformasi Data Visual:** * Mengonversi string emosi menjadi representasi visual berupa Emoji kustom secara dinamis.
  * Memetakan data tanggal aktif dari database SQLite ke format array yang kompatibel dengan komponen Kalender.
  * Mentransformasikan riwayat emosi menjadi skor koordinat numerik (`0.2` hingga `0.8`) untuk menghasilkan kurva grafik tren mingguan yang akurat.

### 4. Pengembangan Antarmuka Pengguna (UI Layer / Screens)
* **WelcomeScreen:** Halaman pembuka dengan desain premium menggunakan *Stack layout*, *Gradient Overlay* untuk menjaga kontras teks, serta transisi navigasi kustom (*Fade Transition*) berdurasi 800ms menuju halaman utama untuk memberikan impresi ketenangan sejak awal aplikasi dibuka.
* **MainNavigation:** Menggunakan `BottomNavigationBar` bertipe *fixed* dengan modifikasi pembatas garis (*border top*) yang halus untuk mengatur alur navigasi utama antar halaman tanpa *re-rendering* yang berat.
* **Dashboard & Canvas Input:** Mengintegrasikan *input text* secara langsung dengan `JournalProvider` agar perubahan teks memicu analisis emosi secara instan (*reactive UI*).
* **Archive & Profile Screen:** Menampilkan visualisasi data berupa kalender aktivitas jurnal dan grafik tren emosi mingguan yang datanya diambil langsung dari hasil kalkulasi di layer Provider.

---

## 🛠️ Tech Stack yang Digunakan

* **Framework:** Flutter (Dart)
* **State Management:** Provider (ChangeNotifier)
* **Local Database:** SQLite (`sqflite` & `path`)
* **UI & Styling:** Custom Font Layouts, Linear Gradients, Squircle Containers, and Custom PageRoute Transitions.

---

## ⚙️ Cara Menjalankan Proyek Secara Lokal

1. Clone repositori ini ke komputer Anda:
   ```bash
   git clone [https://github.com/Naufaldli/insight-path.git](https://github.com/Naufaldli/insight-path.git)

2. Masuk ke direktori proyek:

Bash
cd insight-path
3. Unduh semua dependensi package Dart:

Bash
flutter pub get
4. Jalankan aplikasi pada emulator atau perangkat fisik Anda:

Bash
flutter run
