// Dart has an abstract class named Comparable, which is used by the the sort method of List to sort its elements.
// Add a weight field to the provided Dog class
// Then make Dog implement Comparable so that when you have a list of Dog objects,
// calling sort on the list will sort them by weight.

// abstract class Animal {
//   bool isAlive = true;
//   void eat();

//   @override
//   String toString() {
//     return "I'm a $runtimeType";
//   }
// }

// class Dog extends Animal {
//   @override
//   void eat() {
//     print('Munch munch');
//   }

//   void bark() {
//     print('Bau bau');
//   }
// }

abstract class Animal {
  bool isAlive = true;
  void eat();

  @override
  String toString() {
    return "I'm a $runtimeType";
  }
}

class Dog extends Animal implements Comparable {
  int weight;

  Dog(this.weight);

  @override
  void eat() {
    print('Munch munch');
  }

  void bark() {
    print('Bau bau');
  }

  @override
  String toString() { // This method is used by the print() method to show the instance in the console
    return 'Dog($weight)';
  }

  // method of the Comparable class which returns a specific number based on the comparison between this instance and the "other" passed as argument
  @override
  int compareTo(other) {
    // if (this.weigth < (other as Dog).weigth) {
    //   return -1;
    // } else if (this.weigth > other.weigth) {
    //   return 1;
    // } else {
    //   return 0;
    // }
    return this.weight - (other as Dog).weight;
  }
}

void main(List<String> args) {
  
  // create two dogs
  Dog a = Dog(10);
  Dog b = Dog(9);

  if (a.compareTo(b) > 0) {
    print('A weights more than B');
  } else if (a.compareTo(b) < 0) {
    print('B weights less than A');
  } else {
    print('Both weight the same');
  }

  List<Dog> list = [a, b];
  list.sort();// the sort method in the list uses the compareTo method of the Dog class to know how to sort the items
  print(list);
}
