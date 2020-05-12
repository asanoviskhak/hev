class Reading {
  static List<Reading> getReading() =>[
    Reading("Tesbihat", "Hello World 1", "Smth to read"),
    Reading("Cevsen", "Hello World 2", "Smth to read 2"),
    Reading("Dua", "Hello world 3", "Smth to read 3")
  ];
  String readingName;
  String toRead;
  String description;
  Reading(this.readingName, this.toRead, this.description);
}