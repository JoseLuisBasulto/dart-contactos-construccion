import 'package:test/test.dart';
import '../bin/contacto.dart';
import '../bin/menus.dart';
import 'package:binary_tree/binary_tree.dart';

void main(){
  test('borrarContacto() elimina un contacto correctamente', () {
    final arbolPorNombre = BinaryTree<ContactoPorNombre>();
    final arbolPorFecha = BinaryTree<ContactoPorFecha>();

    ContactoPorNombre contacto1 = ContactoPorNombre(
      "Alberto", 
      DateTime(2000, 10, 26), 
      "9991266079", 
      "albertoosorno04@gmail.com"
    );

    ContactoPorFecha contacto2 = ContactoPorFecha(
      "Alberto", 
      DateTime(2000, 10, 26), 
      "9991266079", 
      "albertoosorno04@gmail.com"
      
    );

     ContactoPorNombre contacto3 = ContactoPorNombre(
      "Fernando", 
      DateTime(2000, 10, 26), 
      "9991266079", 
      "albertoosorno04@gmail.com"
    );

    arbolPorNombre.insert(contacto1);
    arbolPorFecha.insert(contacto2);

    borrarContacto(arbolPorNombre, arbolPorFecha, contacto1);

    expect(consultarContacto(arbolPorNombre, contacto1), null);

    arbolPorNombre.insert(contacto1);
    arbolPorFecha.insert(contacto2);

    borrarContacto(arbolPorNombre, arbolPorFecha, contacto3);

     expect(arbolPorFecha.isEmpty, false);
     expect(arbolPorNombre.isEmpty, false);
  });
}