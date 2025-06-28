import 'package:hive/hive.dart';

part 'quote.g.dart';

@HiveType(typeId: 1)
class Quote {
  Quote({required this.quote, required this.author, required this.date});

  @HiveField(0)
  String quote;

  @HiveField(1)
  String author;

  @HiveField(2)
  String date;
}
