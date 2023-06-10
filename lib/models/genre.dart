class Genre {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });

  // Onderstaande is nodig i.v.m. gebruik DropdownButton
  @override
  bool operator ==(Object other) {
    if (other is Genre) {
      return other.id == id;
    } else {
      return false;
    }
  }

  @override
  int get hashCode {
    return Object.hash(id, name);
  }
}
