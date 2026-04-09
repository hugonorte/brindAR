class Wine {
  final String id;
  final String name;
  final String type;
  final String origin;
  final String vintage;
  final String score;
  final String abv;
  final String body;
  final String temperature;
  final String tag;
  final String imagePath;
  final String sommelierNote;

  Wine({
    required this.id,
    required this.name,
    required this.type,
    required this.origin,
    required this.vintage,
    required this.score,
    required this.abv,
    required this.body,
    required this.temperature,
    required this.tag,
    required this.imagePath,
    required this.sommelierNote,
  });

  factory Wine.mockRadal() => Wine(
        id: '1',
        name: 'Radal Reserve',
        type: 'Cabernet Sauvignon',
        origin: 'Colchagua Valley, Chile',
        vintage: '2021',
        score: '94 PTS',
        abv: '14.5%',
        body: 'Full',
        temperature: '18°C',
        tag: 'Melhor Custo Benefício',
        imagePath: 'assets/images/radal_reserve.png',
        sommelierNote: 'Um vinho tinto encorpado com notas de frutas vermelhas e carvalho.',
      );

  factory Wine.mockCondor() => Wine(
        id: '2',
        name: 'Condor Peak',
        type: 'Merlot',
        origin: 'Mendoza, Argentina',
        vintage: '2025',
        score: '91 PTS',
        abv: '13.5%',
        body: 'Medium',
        temperature: '16°C',
        tag: 'Favorito da Comunidade',
        imagePath: 'assets/images/condor_peak.png',
        sommelierNote: 'Elegante e suave, com taninos bem integrados.',
      );

  factory Wine.mockPueblo() => Wine(
        id: '3',
        name: 'Pueblo del Sol',
        type: 'Pinot Noir',
        origin: 'Atlântida, Uruguay',
        vintage: '2025',
        score: '92 PTS',
        abv: '13.0%',
        body: 'Light',
        temperature: '14°C',
        tag: 'Aposta do Sommelier',
        imagePath: 'assets/images/pueblo_del_sol.png',
        sommelierNote: 'Fresco e frutado, ideal para acompanhar pratos leves.',
      );
}
