class Item {
  final String tanggal;
  final String jam;
  final String wilayah;
  final String potensi;
  final String image;

  const Item({
    required this.tanggal,
    required this.jam,
    required this.wilayah,
    required this.potensi,
    required this.image,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      tanggal: json['Tanggal'] as String,
      jam: json['Jam'] as String,
      wilayah: json['Wilayah'] as String,
      potensi: json['Potensi'] as String,
      image: json['Shakemap'] as String,
    );
  }
}
