// lib/models/movie.dart — modelo de domínio.
//
// TASK 12: toJson() e Movie.fromJson() — o cache offline guarda cada filme como JSON.

class Movie {
  final int id;
  final String title;
  final double rating;
  final String year;

  const Movie({
    required this.id,
    required this.title,
    required this.rating,
    required this.year,
  });

  // ── TASK 12 — serialização ───────────────────────────────────────────────────────
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'rating': rating,
        'year': year,
      };

  // `as num` + toDouble/toInt: o JSON pode trazer 8 em vez de 8.0.
  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: (json['id'] as num).toInt(),
        title: json['title'] as String,
        rating: (json['rating'] as num).toDouble(),
        year: json['year'] as String,
      );
}
