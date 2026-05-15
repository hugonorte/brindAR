class Wine {
  final String id;
  final String barcode; // EAN-13 (13 digits) or UPC-A (12 digits)
  final String name;
  final String type; // grape variety
  final String origin; // country
  final String region;
  final String vintage;
  final String score;
  final String abv;
  final String body; // Light / Medium / Full
  final String temperature;
  final String tag;
  final String sommelierNote;
  final String imageUrl;

  Wine({
    required this.id,
    required this.barcode,
    required this.name,
    required this.type,
    required this.origin,
    required this.region,
    required this.vintage,
    required this.score,
    required this.abv,
    required this.body,
    required this.temperature,
    required this.tag,
    required this.sommelierNote,
    required this.imageUrl,
  });

  /// Serializes to a SQLite-compatible map.
  Map<String, dynamic> toMap() => {
        'id': id,
        'barcode': barcode,
        'name': name,
        'type': type,
        'origin': origin,
        'region': region,
        'vintage': vintage,
        'score': score,
        'abv': abv,
        'body': body,
        'temperature': temperature,
        'tag': tag,
        'sommelierNote': sommelierNote,
        'imageUrl': imageUrl,
      };

  /// Deserializes from a SQLite row map.
  factory Wine.fromMap(Map<String, dynamic> map) => Wine(
        id: map['id'] as String? ?? '',
        barcode: map['barcode'] as String? ?? '',
        name: map['name'] as String? ?? '',
        type: map['type'] as String? ?? '',
        origin: map['origin'] as String? ?? '',
        region: map['region'] as String? ?? '',
        vintage: map['vintage'] as String? ?? '',
        score: map['score'] as String? ?? '',
        abv: map['abv'] as String? ?? '',
        body: map['body'] as String? ?? '',
        temperature: map['temperature'] as String? ?? '',
        tag: map['tag'] as String? ?? '',
        sommelierNote: map['sommelierNote'] as String? ?? '',
        imageUrl: map['imageUrl'] as String? ?? '',
      );

  Wine copyWith({
    String? id,
    String? barcode,
    String? name,
    String? type,
    String? origin,
    String? region,
    String? vintage,
    String? score,
    String? abv,
    String? body,
    String? temperature,
    String? tag,
    String? sommelierNote,
    String? imageUrl,
  }) =>
      Wine(
        id: id ?? this.id,
        barcode: barcode ?? this.barcode,
        name: name ?? this.name,
        type: type ?? this.type,
        origin: origin ?? this.origin,
        region: region ?? this.region,
        vintage: vintage ?? this.vintage,
        score: score ?? this.score,
        abv: abv ?? this.abv,
        body: body ?? this.body,
        temperature: temperature ?? this.temperature,
        tag: tag ?? this.tag,
        sommelierNote: sommelierNote ?? this.sommelierNote,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  // ── Seed data for MVP ────────────────────────────────────────────────────────

  static Wine seedRadal() => Wine(
        id: 'seed-1',
        barcode: '7804320100014',
        name: 'Radal Reserve',
        type: 'Cabernet Sauvignon',
        origin: 'Chile',
        region: 'Colchagua Valley',
        vintage: '2021',
        score: '94 PTS',
        abv: '14.5%',
        body: 'Full',
        temperature: '18°C',
        tag: 'Melhor Custo Benefício',
        sommelierNote:
            'Um vinho tinto encorpado com notas de frutas vermelhas e carvalho.',
        imageUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuAzFdh7aPHLu8Eh3tMZqJSL7wTyZenwPbtdNKxwXqp-DCmcphjugIbUKl66-sAB6hHw7gkncXpfvLyKBUNkVgAQr_P03zQi8gSGNwAT4MnnnfP0F6x97FEl6xnl5upRT90uU3FuBFDDOWQTKhRC8W1D-Lv_TG_qBGMNz6vbrGAtar-sx85DJO_QklQE3i6PIKq9W-o2U_LgmURD2JaJaVHN9aRqMdS3LNoU6vJSfJwKZQSpot3NFuTEUC5e1TYA_4XwFs9hebJmg_g',
      );

  static Wine seedCondor() => Wine(
        id: 'seed-2',
        barcode: '7790070038047',
        name: 'Condor Peak',
        type: 'Merlot',
        origin: 'Argentina',
        region: 'Mendoza',
        vintage: '2022',
        score: '91 PTS',
        abv: '13.5%',
        body: 'Medium',
        temperature: '16°C',
        tag: 'Favorito da Comunidade',
        sommelierNote: 'Elegante e suave, com taninos bem integrados.',
        imageUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCzLDNWrcs0CFyfalNy4YeCJiSjQWrztRQT6iKb8Yo5mrOFmCB7tyUhxnF_sAd1GQNt2KR5P5igjrNL4-HBZUMdAIamDFrPlF_Iqs81nzF0-U5sanQ__UdAnw9GhViSF7Qg0IHW17NlN0V2vdZ6epEBeiTJQaiRUkstMGeyQLkq9uV8CMIfGmnI-k2S00k--jszyX9wpagVVkb1ihFm_i4JsGqwIxnOf8OKYgVnfhEI2K3ze7UOJO3O2E-jwQr-hUrg0XhYy-g5n2U',
      );

  static Wine seedPueblo() => Wine(
        id: 'seed-3',
        barcode: '7730100012348',
        name: 'Pueblo del Sol',
        type: 'Pinot Noir',
        origin: 'Uruguai',
        region: 'Atlântida',
        vintage: '2023',
        score: '92 PTS',
        abv: '13.0%',
        body: 'Light',
        temperature: '14°C',
        tag: 'Aposta do Sommelier',
        sommelierNote: 'Fresco e frutado, ideal para acompanhar pratos leves.',
        imageUrl:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuDChnEoTD5VVurOyI8nswxNz2-bkIrZtbENSsBWbL4c7P6mUnobBZLfyMi6B_gVRHLJwN7nj8PPObm3X6quU7KQkfNpFoVnB3yr-VQBhLkJseeeg--WwrWUkx4sq5PdZouJLvbE0LSD_SGtzjeBTFTbdcH1g2xMgMMLZTH1Yx_GYszbDXJcSf7LZuSxZkVgjq2e8hth-FlWmDFiavJ6hy06LWcY6C_FGjN_E1zleT3Hwfs6jfm2R7VjXk1KEobbpeYVEMMy0kytLY8',
      );
}
