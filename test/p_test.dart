import 'package:test/test.dart';
import 'package:binary_tree/binary_tree.dart';
import 'package:dart_contactos_construccion/contacto_por_nombre.dart';
import 'package:dart_contactos_construccion/contacto_por_fecha.dart';
import 'package:dart_contactos_construccion/menu.dart';

void main() {
  // ESTAS PRUEBAS UNITARIAS SIRVEN PARA LAS REFACTORIZACIONES: 1,2,3,4,10
  group('Pruebas Unitarias - Funcionamiento para Agregar, Consultar, Borrar y Listar', () {
    late Menu menu;

    setUp(() {
      final arbolPorNombre = BinaryTree<ContactoPorNombre>();
      final arbolPorFecha = BinaryTree<ContactoPorFecha>();

      // Instancia nueva de menu por cada prueba
      menu = Menu(arbolPorNombre, arbolPorFecha);
    });

    test('1. Agregar un contacto correctamente', () {
      final contactoNombre = ContactoPorNombre(
        'Juan Pérez',
        DateTime(2000, 5, 12),
        '555-1234',
        'juan@email.com',
      );
      final contactoFecha = ContactoPorFecha(
        'Juan Pérez',
        DateTime(2000, 5, 12),
        '555-1234',
        'juan@email.com',
      );

      menu.agregarContactos(contactoNombre, contactoFecha);

      expect(menu.arbolPorNombre.isNotEmpty, isTrue);
      expect(menu.buscarPorNombre('Juan Pérez'), isNotNull);
      expect(menu.buscarPorNombre('Juan Pérez'), contactoNombre);
    });

    test('2. Consultar y buscar un contacto existente', () {
      final contactoNombre = ContactoPorNombre(
        'María López',
        DateTime(2000, 8, 20),
        '555-5678',
        'maria@email.com',
      );
      final contactoFecha = ContactoPorFecha(
        'María López',
        DateTime(2000, 8, 20),
        '555-5678',
        'maria@email.com',
      );

      menu.agregarContactos(contactoNombre, contactoFecha);

      final resultado = menu.obtenerContacto(contactoNombre);
      
      expect(resultado, isNotNull);
      expect(resultado?.nombre, equals('María López'));
      expect(resultado?.telefono, equals('555-5678'));
      expect(resultado?.correoElectronico, equals('maria@email.com'));
    });

    test('3. Borrar un contacto correctamente', () {
      final contactoNombre = ContactoPorNombre(
        'Carlos Ruiz',
        DateTime(2000, 3, 10),
        '555-9999',
        'carlos@email.com',
      );
      final contactoFecha = ContactoPorFecha(
        'Carlos Ruiz',
        DateTime(2000, 3, 10),
        '555-9999',
        'carlos@email.com',
      );

      menu.agregarContactos(contactoNombre, contactoFecha);
      // Verificamos que se agregó correctamente
      expect(menu.buscarPorNombre('Carlos Ruiz'), isNotNull);
      expect(menu.buscarPorFecha('Carlos Ruiz'), isNotNull);
      expect(menu.buscarPorNombre('Carlos Ruiz'), contactoNombre);
      expect(menu.buscarPorFecha('Carlos Ruiz'), contactoFecha);

      // Eliminar uno que no se encuentra en el árbol
      menu.eliminarContacto(ContactoPorNombre('Juan', DateTime(2000, 1, 1), '123', 'carlos@email.com'));
      expect(menu.arbolPorNombre.length, equals(1));
      expect(menu.arbolPorFecha.length, equals(1));

      // Eliminar uno que si se encuentra en el árbol
      menu.eliminarContacto(contactoNombre);

      // Verificar que ya no existe en el árbol
      expect(menu.buscarPorNombre('Carlos Ruiz'), isNull);
      expect(menu.buscarPorFecha('Carlos Ruiz'), isNull);
    });

    test('4. Listar y ordenar contactos por fecha de cumpleaños', () {
      final c1Nombre = ContactoPorNombre('Ana', DateTime(2000, 10, 15), '111', 'a@a.com');
      final c1Fecha = ContactoPorFecha('Ana', DateTime(2000, 10, 15), '111', 'a@a.com');
      
      final c2Nombre = ContactoPorNombre('Bruno', DateTime(2000, 1, 5), '222', 'b@b.com');
      final c2Fecha = ContactoPorFecha('Bruno', DateTime(2000, 1, 5), '222', 'b@b.com');

      menu.agregarContactos(c1Nombre, c1Fecha);
      menu.agregarContactos(c2Nombre, c2Fecha);

      final lista = menu.recorrerPorCumple();
      
      expect(lista.length, equals(2));
      expect(lista[0].nombre, 'Bruno');
      expect(lista[1].nombre, 'Ana');
    });
  });
}