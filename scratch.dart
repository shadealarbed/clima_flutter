//@dart=2.9
import 'dart:io';

void main() {
  performTasks();
}

void performTasks() async {
  task1();
  String inputTask2 = await task2();
  task3(inputTask2);
}

void task1() {
  String result = 'task 1 data';
  print('Task 1 complete');
}

Future task2() async{
  String result;
  Duration three = Duration(seconds: 3);
  await Future.delayed(three, () {
    result = 'task 2 data';
    print('Task 2 complete');
  });
  return result;
}

void task3(String task2input) {
  String result = 'task 3 data';
  print('Task 3 complete with $task2input');
}
