import 'package:test/test.dart';
import '../bin/contacto.dart';
import '../bin/menus.dart';
import 'package:binary_tree/binary_tree.dart';

void main(){
  test('listarPorCumple() muestra los contactos correctamente', (){
    final tree = BinaryTree<ContactoPorFecha>();

    ContactoPorFecha contacto1 = ContactoPorFecha(
      "Alberto", 
      DateTime(2000, 10, 26), 
      "9991266079", 
      "albertoosorno04@gmail.com");

    ContactoPorFecha contacto2 = ContactoPorFecha(
      "Basulto", 
      DateTime(2000, 07, 22), 
      "9991266079", 
      "albertoosorno04@gmail.com");

    ContactoPorFecha contacto3 = ContactoPorFecha(
      "Joel", 
      DateTime(2000, 12, 28), 
      "9991266079", 
      "albertoosorno04@gmail.com");

    tree.insert(contacto1);
    tree.insert(contacto2);
    tree.insert(contacto3);

    List<ContactoPorFecha> contactos = listarPorCumple(tree);

    expect(contactos[0].nombre, "Alberto");
    expect(contactos[1].nombre, "Joel");
    expect(contactos[2].nombre, "Basulto");
  });
}