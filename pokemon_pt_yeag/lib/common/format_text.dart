String formatId(String id) {
  return id.padLeft(3, '0');
}

String capitalize(String name) {
  if (name.isEmpty) return name;
  return name[0].toUpperCase() + name.substring(1);
}
