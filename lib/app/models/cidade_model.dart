class Cidade {
  int casos;
  int mortes;
  int populacao;
  String ultimaAtualizacao;
  double indiceMorte;

  Cidade({
    this.casos,
    this.mortes,
    this.indiceMorte,
    this.populacao,
    this.ultimaAtualizacao,
  });

  factory Cidade.fromJson(Map<String, dynamic> doc) {
    return Cidade(
        casos: doc['confirmed'],
        mortes: doc['deaths'],
        indiceMorte: doc['death_rate'],
        populacao: doc['estimated_population_2019'],
        ultimaAtualizacao: (doc['date']));
  }
}
