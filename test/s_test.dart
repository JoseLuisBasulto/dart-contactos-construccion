import 'package:test/test.dart';
import 'package:binary_tree/binary_tree.dart';
import 'package:dart_contactos_construccion/contacto_por_nombre.dart';
import 'package:dart_contactos_construccion/contacto_por_fecha.dart';
import 'package:dart_contactos_construccion/menu.dart';

void main(){
  // PRUEBA UNITARIA PARA LA REFACTRIZACIÓN 5
  test('1. Validar correctamente un nombre', () {
      final arbolPorNombre = BinaryTree<ContactoPorNombre>();
      final arbolPorFecha = BinaryTree<ContactoPorFecha>();

      Menu menu = Menu(arbolPorNombre, arbolPorFecha);

      final c1Nombre = ContactoPorNombre('Ana', DateTime(2000, 10, 15), '111', 'a@a.com');
      final c3Nombre = ContactoPorNombre('Alberto', DateTime(2000, 26, 10), '333', 'c@c.com');

      arbolPorNombre.insert(c3Nombre);

      expect(menu.nombreValido(c1Nombre.nombre), true);
      expect(menu.nombreValido(' '), false);
      expect(menu.nombreValido(c3Nombre.nombre), false);
    });
}