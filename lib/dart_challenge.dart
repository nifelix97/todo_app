// Dart Logic Challenge

// 1. Reverse a string
String reverseString(String input) => input.split('').reversed.join();

// 2. Filter a list for unique values
List<T> uniqueValues<T>(List<T> list) => list.toSet().toList();
// 3. Find the maximum value in a list
T? findMax<T extends Comparable<T>>(List<T> list) {
  if (list.isEmpty) return null;
  T max = list.first;
  for (T item in list) {
    if (item.compareTo(max) > 0) max = item;
  }
  return max;
}
void main() {
  print(reverseString("flutter")); // expected output: rettulf
  print(uniqueValues([1, 2, 2, 3, 4, 4, 5])); // expected output: [1, 2, 3, 4, 5]
  print(findMax([1, 3, 2, 5, 4])); // expected output: 5
}
