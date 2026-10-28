import 'package:test/test.dart';
import 'package:binary_tree/binary_tree.dart';
import 'package:dart_contactos_construccion/contacto.dart';
import 'package:dart_contactos_construccion/menu.dart';

void main(){
  // PRUEBA UNITARIA PARA LA REFACTRIZACIÓN 5
  test('1. Validar correctamente un nombre', () {
      final arbolPorNombre = BinaryTree<ContactoPorNombre>();

      final c1Nombre = ContactoPorNombre('Ana', DateTime(2000, 10, 15), '111', 'a@a.com');
      final c3Nombre = ContactoPorNombre('Alberto', DateTime(2000, 26, 10), '333', 'c@c.com');

      arbolPorNombre.insert(c3Nombre);

      expect(nombreValido(c1Nombre.nombre, arbolPorNombre), true);
      expect(nombreValido(' ', arbolPorNombre), false);
      expect(nombreValido(c3Nombre.nombre, arbolPorNombre), false);
    });
}