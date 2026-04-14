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
      };

  /// Deserializes from a SQLite row map.
  factory Wine.fromMap(Map<String, dynamic> map) => Wine(
        id: map['id'] as String,
        barcode: map['barcode'] as String,
        name: map['name'] as String,
        type: map['type'] as String,
        origin: map['origin'] as String,
        region: map['region'] as String,
        vintage: map['vintage'] as String,
        score: map['score'] as String,
        abv: map['abv'] as String,
        body: map['body'] as String,
        temperature: map['temperature'] as String,
        tag: map['tag'] as String,
        sommelierNote: map['sommelierNote'] as String,
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
      );
}
