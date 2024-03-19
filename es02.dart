// Design a series of classes to simulate a hospital management system.
// The system should handle patient-doctor interactions including regular visits, hospitalizations, and surgeries.

// Begin by creating an abstract class called Person with attributes such as age and gender.
// Create subclasses Patient and Doctor inheriting from Person. Patient should include additional attributes
// like disease, while Doctor should include specialization.
//
// Implement a class named Visit to represent a general patient-doctor interaction.
// Include attributes such as date, cause, and result. Also, implement a method run_tests which should be
// overridden in subclasses.
//
// Create subclasses Hospitalization and Surgery, both inheriting from Visit.
// Hospitalization should include an additional attribute for duration, while Surgery should include
// an attribute for the type of surgery.
//
// Design a class called Hospital to represent a hospital.
// Include important data such as the hospital's name, number of rooms, and number of beds.
// Implement a method to check room and bed availability during visit creation.
//
// Write a main program to create a hospital instance, generate patient and doctor objects,
// and simulate various interactions including regular visits, hospitalizations, and surgeries.
// Use polymorphism to handle different types of visits.

// class describing a generic Person
abstract class Person {
  int age;
  String gender;
  Person({required this.age, required this.gender});
}
// class Patient extending Person, adding the disease as field
class Patient extends Person {
  String disease;
  Patient({required this.disease, required super.age, required super.gender});
}
// class Doctor extending Person, adding the specialization as field
class Doctor extends Person {
  String specialization;
  
  // this constructor does not use the "this" and "super" keywords but we write it verbose
  Doctor(
      {required String specializationdoc,
      required int agedoc,
      required String genderdoc})
      : specialization = specializationdoc.toUpperCase(),
        super(age: agedoc, gender: genderdoc);

  Doctor.pediatrician({required super.age, required super.gender})
      : specialization = 'pediatrics';
}

// class Visit
class Visit {
  DateTime date;
  String cause;
  String result;
  Patient patient;
  Doctor doctor;

  Visit(
      {required this.doctor,
      required this.patient,
      required this.cause,
      required this.date,
      required this.result});

  // general implementation for the Visit class
  String run_test() {
    return 'all ok';
  }
}
// Surgery is a subclass of Visit with type field added
class Surgery extends Visit {
  Surgery(
      {required super.cause,
      required super.date,
      required super.result,
      required this.type,
      required super.doctor,
      required super.patient});

  String type;

  // specific implementation of run_test method for Surgery
  @override
  String run_test() {
    return 'Surgery went well';
  }
}

// Hospitalization is a subclass of Visit with duration field added
class Hospitalization extends Visit {
  Duration duration;

  Hospitalization(
      {required super.cause,
      required super.date,
      required super.result,
      required this.duration,
      required super.doctor,
      required super.patient});

  // specific implementation of run_test method for Hospitalization
  @override
  String run_test() {
    String out = 'Lab test are ' + super.run_test();
    return out;
  }
}

class Hospital {
  String name;
  // total number of beds (for hospitalization)
  int beds;
  // currently available beds
  int bedsfree;
  // total number of rooms (for surgery and generic visits)
  int rooms;
  // currently available rooms
  int roomsfree;
  // list of currently ongoing visits
  List<Visit> ongoingVisits = [];


  Hospital({required this.beds, required this.name, required this.rooms})
      : bedsfree = beds, // initially all beds are free
        roomsfree = rooms; // initially all rooms are free

  // method to add a new visit, first checking the availability of rooms/beds and then returning a boolean
  bool addVisit(Visit visit) {
    if (visit is Hospitalization) {
      if (checkBedsAvailable()) {
        ongoingVisits.add(visit);
        roomsfree--;
        return true;
      } else {
        return false;
      }
    } else {
      if (checkRoomAvailable()) {
        ongoingVisits.add(visit);
        bedsfree--;
        return true;
      } else {
        return false;
      }
    }
  }
  // method to run all visits at once, it will use the correct run_test using polymorphism
  void runVisits() {
    ongoingVisits.forEach((element) {
      print(element.run_test());
    });
  }

  bool checkBedsAvailable() {
    return bedsfree > 0;
  }

  bool checkRoomAvailable() {
    return roomsfree > 0;
  }
}

void main(List<String> args) {
  Patient p1 = Patient(age: 3, gender: 'male', disease: 'dis1');
  Patient p2 = Patient(age: 4, gender: 'female', disease: 'dis2');
  Doctor d1 = Doctor(agedoc: 3, genderdoc: 'male', specializationdoc: 'spec1');
  Doctor d2 = Doctor.pediatrician(age: 30, gender: 'female');

  Hospital h = Hospital(beds: 10, name: 'testh', rooms: 10);
  h.addVisit(Surgery(
      cause: 'cause',
      date: DateTime.now(),
      result: 'result',
      type: 'type',
      doctor: d1,
      patient: p1));
  h.addVisit(Hospitalization(
      cause: 'cause',
      date: DateTime.now(),
      result: 'result',
      duration: Duration(days: 3),
      doctor: d2,
      patient: p2));
  h.runVisits(); // this will print 
  // Surgery went well
  // Lab test are all ok
}
