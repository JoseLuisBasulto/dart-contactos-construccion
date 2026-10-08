import 'package:test/test.dart';
import '../bin/contacto.dart';
import '../bin/menus.dart';
import 'package:binary_tree/binary_tree.dart';

void main() {
  /*test('agregarContacto() verifica que se agregue correctamente', () {
    final arbolPorNombre = BinaryTree<ContactoPorNombre>();
    final arbolPorFecha = BinaryTree<ContactoPorFecha>();

    agregarContacto(arbolPorNombre, arbolPorFecha);

    expect(arbolPorNombre.isEmpty, isFalse);
    expect(arbolPorFecha.isEmpty, isFalse);
  });

  test('getters de contacto devuelven los atributos correctamente', (){
    ContactoPorNombre contacto1 = ContactoPorNombre(
      "Alberto", 
      DateTime(2000, 10, 26), 
      "9991266079", 
      "albertoosorno04@gmail.com");

      ContactoPorFecha contacto2 = ContactoPorFecha(
      "Alberto", 
      DateTime(2000, 10, 26), 
      "9991266079", 
      "albertoosorno04@gmail.com");

      expect(contacto1.getNombre(), "Alberto");
      expect(contacto2.getFechaNacimiento(), DateTime(2000, 10, 26));
  });

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

      expect(contactos[0].getNombre(), "Alberto");
      expect(contactos[1].getNombre(), "Joel");
      expect(contactos[2].getNombre(), "Basulto");
  });*/
  test('consultarContacto() devuelve el contacto consultado correctamente', () {
    final arbolPorNombre = BinaryTree<ContactoPorNombre>();

    ContactoPorNombre contacto = ContactoPorNombre(
      "Alberto", 
      DateTime(2000, 10, 26), 
      "9991266079", 
      "albertoosorno04@gmail.com");

    arbolPorNombre.insert(contacto);
    ContactoPorNombre? nombre = consultarContacto(arbolPorNombre);
    expect(nombre?.getNombre(), "Alberto");

    nombre = consultarContacto(arbolPorNombre);
    expect(nombre?.getNombre(), isNull);

  });
  /*test('borrarContacto() elimina un contacto correctamente', () {
    final arbolPorNombre = BinaryTree<ContactoPorNombre>();
    final arbolPorFecha = BinaryTree<ContactoPorFecha>();

    ContactoPorNombre contacto1 = ContactoPorNombre(
      "Alberto", 
      DateTime(2000, 10, 26), 
      "9991266079", 
      "albertoosorno04@gmail.com");

    ContactoPorFecha contacto2 = ContactoPorFecha(
      "Alberto", 
      DateTime(2000, 10, 26), 
      "9991266079", 
      "albertoosorno04@gmail.com");

      arbolPorNombre.insert(contacto1);
      arbolPorFecha.insert(contacto2);

      borrarContacto(arbolPorNombre, arbolPorFecha);

    expect(consultarContacto(arbolPorNombre), isNull);
  });*/
}
