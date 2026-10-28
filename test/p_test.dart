import 'package:test/test.dart';
import 'package:binary_tree/binary_tree.dart';
import 'package:dart_contactos_construccion/contacto.dart';
import 'package:dart_contactos_construccion/menu.dart';

void main() {
  // ESTAS PRUEBAS UNITARIAS SIRVEN PARA LAS REFACTORIZACIONES: 1,2,3,4,10
  group('Pruebas Unitarias - Funcionamiento para Agregar, Consultar, Borrar y Listar', () {
    late BinaryTree<ContactoPorNombre> arbolPorNombre;
    late BinaryTree<ContactoPorFecha> arbolPorFecha;

    // Para asegurar arboles limpios en cada prueba
    setUp(() {
      arbolPorNombre = BinaryTree<ContactoPorNombre>();
      arbolPorFecha = BinaryTree<ContactoPorFecha>();
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

      agregarContacto(arbolPorNombre, arbolPorFecha, contactoNombre, contactoFecha);

      expect(arbolPorNombre.isNotEmpty, isTrue);
      expect(buscarPorNombre(arbolPorNombre, 'Juan Pérez'), isNotNull);
      expect(buscarPorNombre(arbolPorNombre, 'Juan Pérez'), contactoNombre);
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

      agregarContacto(arbolPorNombre, arbolPorFecha, contactoNombre, contactoFecha);

      // Consultar usando la función de consulta
      final resultado = consultarContacto(arbolPorNombre, contactoNombre);
      
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

      agregarContacto(arbolPorNombre, arbolPorFecha, contactoNombre, contactoFecha);
      // Verificamos que se agregó correctamente
      expect(buscarPorNombre(arbolPorNombre, 'Carlos Ruiz'), isNotNull);
      expect(buscarPorFecha(arbolPorFecha, 'Carlos Ruiz'), isNotNull);
      expect(buscarPorNombre(arbolPorNombre, 'Carlos Ruiz'), contactoNombre);
      expect(buscarPorFecha(arbolPorFecha, 'Carlos Ruiz'), contactoFecha);

      // Eliminar uno que no se encuentra en el árbol
      borrarContacto(arbolPorNombre, arbolPorFecha, ContactoPorNombre('Juan', DateTime(2000, 1, 1), '123', 'carlos@email.com'));
      expect(arbolPorNombre.length, equals(1));
      expect(arbolPorFecha.length, equals(1));

      // Eliminar uno que si se encuentra en el árbol
      borrarContacto(arbolPorNombre, arbolPorFecha, contactoNombre);

      // Verificar que ya no existe en el árbol
      expect(buscarPorNombre(arbolPorNombre, 'Carlos Ruiz'), isNull);
      expect(buscarPorFecha(arbolPorFecha, 'Carlos Ruiz'), isNull);
    });

    test('4. Listar y ordenar contactos por fecha de cumpleaños', () {
      final c1Nombre = ContactoPorNombre('Ana', DateTime(2000, 10, 15), '111', 'a@a.com');
      final c1Fecha = ContactoPorFecha('Ana', DateTime(2000, 10, 15), '111', 'a@a.com');
      
      final c2Nombre = ContactoPorNombre('Bruno', DateTime(2000, 1, 5), '222', 'b@b.com');
      final c2Fecha = ContactoPorFecha('Bruno', DateTime(2000, 1, 5), '222', 'b@b.com');

      agregarContacto(arbolPorNombre, arbolPorFecha, c1Nombre, c1Fecha);
      agregarContacto(arbolPorNombre, arbolPorFecha, c2Nombre, c2Fecha);

      final lista = recorrerPorCumple(arbolPorFecha);
      
      expect(lista.length, equals(2));
      expect(lista[0].nombre, 'Bruno');
      expect(lista[1].nombre, 'Ana');
    });
  });
}