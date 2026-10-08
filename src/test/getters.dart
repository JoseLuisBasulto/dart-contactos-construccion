import 'package:test/test.dart';
import '../bin/contacto.dart';

void main(){
  test('getters de contacto devuelven los atributos correctamente', (){
    ContactoPorNombre contacto1 = ContactoPorNombre(
      "Alberto", 
      DateTime(2000, 10, 26), 
      "9991266079", 
      "albertoosorno04@gmail.com"
    );

    ContactoPorFecha contacto2 = ContactoPorFecha(
      "Fernando", 
      DateTime(2000, 06, 11), 
      "9991266079", 
      "albertoosorno04@gmail.com"
    );

    expect(contacto1.nombre, "Alberto");
    expect(contacto1.fechaNacimiento, DateTime(2000, 10, 26));
    expect(contacto2.nombre, "Fernando");
    expect(contacto2.fechaNacimiento, DateTime(2000, 06, 11));
  });
}