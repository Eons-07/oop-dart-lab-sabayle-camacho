import 'dart:io';

class Person {
  String _name;
  int _age;

  Person(this._name, this._age);

  String get name => _name;
  int get age => _age;

  set age(int value) {
    if (value < 0) {
      throw ArgumentError('Age cannot be negative.');
    }
    _age = value;
  }

  String introduce() {
    return "Hi, I'm $_name, $_age years old.";
  }
}

class Student extends Person {
  String _course;

  Student(String name, int age, this._course) : super(name, age);

  String get course => _course;

  @override
  String introduce() {
    return "Hi, I'm $name, $age years old, studying $_course.";
  }
}

class Teacher extends Person {
  String _subject;

  Teacher(String name, int age, this._subject) : super(name, age);

  String get subject => _subject;

  @override
  String introduce() {
    return "Hi, I'm $name, $age years old, teaching $_subject.";
  }
}

class School {
  final List<Person> people = [];

  void addPerson(Person p) {
    people.add(p);
  }

  void introduceAll() {
    for (Person person in people) {
      print(person.introduce());
    }
  }
}

String getText(String prompt) {
  while (true) {
    stdout.write(prompt);
    String input = stdin.readLineSync()?.trim() ?? '';

    if (input.isNotEmpty) {
      return input;
    }

    print('Input cannot be empty. Please try again.');
  }
}

int getWholeNumber(String prompt) {
  while (true) {
    stdout.write(prompt);
    String input = stdin.readLineSync()?.trim() ?? '';

    int? number = int.tryParse(input);

    if (number != null) {
      return number;
    }

    print('Please enter a valid whole number.');
  }
}

int getAge(String prompt) {
  while (true) {
    int age = getWholeNumber(prompt);

    if (age >= 0) {
      return age;
    }

    print('Age cannot be negative. Please try again.');
  }
}

void main() {
  final School school = School();

  print('=== School Personnel Management ===');

  int studentCount = getWholeNumber('How many students will you add? ');

  for (int i = 1; i <= studentCount; i++) {
    print('-- Student #$i --');

    String name = getText('Name: ');
    int age = getAge('Age: ');
    String course = getText('Course: ');

    Student student = Student(name, age, course);
    school.addPerson(student);
  }

  int teacherCount = getWholeNumber('How many teachers will you add? ');

  for (int i = 1; i <= teacherCount; i++) {
    print('-- Teacher #$i --');

    String name = getText('Name: ');
    int age = getAge('Age: ');
    String subject = getText('Subject: ');

    Teacher teacher = Teacher(name, age, subject);
    school.addPerson(teacher);
  }

  print('=== School Roster ===');
  school.introduceAll();
}