import 'package:test/test.dart';
import '../bin/contacto.dart';
import '../bin/menus.dart';
import 'package:binary_tree/binary_tree.dart';

void main(){
  test('consultarContacto() devuelve el contacto consultado correctamente', () {
    final arbolPorNombre = BinaryTree<ContactoPorNombre>();

    ContactoPorNombre contacto1 = ContactoPorNombre(
      "Alberto", 
      DateTime(2000, 10, 26), 
      "9991266079", 
      "albertoosorno04@gmail.com"
    );
    ContactoPorNombre contacto2 = ContactoPorNombre(
      "Fernando", 
      DateTime(2000, 10, 26), 
      "9991266079", 
      "albertoosorno04@gmail.com"
    );
    ContactoPorNombre contacto3 = ContactoPorNombre(
      "Joel", 
      DateTime(2000, 10, 26), 
      "9991266079", 
      "albertoosorno04@gmail.com"
    );

    arbolPorNombre.insert(contacto1);
    arbolPorNombre.insert(contacto3);

    expect(consultarContacto(arbolPorNombre, contacto1), contacto1);
    expect(consultarContacto(arbolPorNombre, contacto3), contacto3);
    expect(consultarContacto(arbolPorNombre, contacto2), null);
  });
}