//ignore_for_file: unused_local_variable

import 'dart:io';
import 'package:binary_tree/binary_tree.dart';
import 'contacto.dart';
import 'logica_de_archivos.dart';

void menuPrincipal(
  BinaryTree<ContactoPorNombre> arbolPorNombre,
  BinaryTree<ContactoPorFecha> arbolPorFecha,
) {
  String? opcion;

  do {
    print("=========Libreta de contactos en Dart========\n");
    print("[1] Agregar contacto");
    print("[2] Borrar contacto");
    print("[3] Consultar datos de un contacto");
    print("[4] Listar contactos por fecha de cumpleaños");
    print("[5] Listar contactos por nombre");
    print("[6] Salir");

    stdout.write("Seleccion >> ");
    opcion = stdin.readLineSync();
    print("");

    switch (opcion) {
      case '1':
        print("===============Agregar Contacto==============\n");
        agregarContacto(arbolPorNombre, arbolPorFecha);
        esperarEnter();
        break;
      case '2':
        print("================Borrar Contacto===============\n");
        borrarContacto(arbolPorNombre, arbolPorFecha);
        esperarEnter();
        break;
      case '3':
        print("==============Consultar Contacto=============\n");
        consultarContacto(arbolPorNombre);
        esperarEnter();
        break;
      case '4':
        print("======Contactos por Fecha de Cumpleaños======\n");
        print("Contactos ordenados por fecha de cumpleaños:");
        print(listarPorCumple(arbolPorFecha));
        esperarEnter();
        break;
      case '5':
        print("=============Contactos por Nombre============\n");
        listarPorNombre(arbolPorNombre);
        esperarEnter();
        break;
      case '6':
        print("Saliendo...");
        guardarArboles(arbolPorNombre);
        break;
      default:
        print("Opción inválida, intenta de nuevo");
    }
  } while (opcion != '6');
}

void agregarContacto(BinaryTree arbolPorNombre, BinaryTree arbolPorFecha) {
  print("Ingresa los datos del contacto");

  //Se lee el nombre y se verifica que no exista en el árbol
  stdout.write("Nombre: ");
  String? nombre = stdin.readLineSync();

  if (arbolPorNombre.contains(nombre)) {
    do {
      print("Este nombre ya existe? Intenta con otro.");
      stdout.write("Nombre: ");
      String? nombre = stdin.readLineSync();
    } while (arbolPorNombre.contains(nombre));
  }

  //Se lee la fecha de nacimiento
  stdout.write("Fecha de nacimiento (DD/MM): ");
  String? fechaStr = stdin.readLineSync();
  DateTime? fechaNacimiento;
  bool formatoValido = false;

  do {
    try {
      List<String> partes = fechaStr!.split("/");
      int dia = int.parse(partes[0]);
      int mes = int.parse(partes[1]);
      fechaNacimiento = DateTime(2000, mes, dia); // Año fijo para ordenar
      formatoValido = true;
    } catch (e) {
      print("Formato de fecha inválido. Usa DD/MM.");
    }

    if (!formatoValido) {
      stdout.write("Fecha de nacimiento (DD/MM): ");
      fechaStr = stdin.readLineSync();
    }
  } while (!formatoValido);

  //Se lee el telefono
  stdout.write("Teléfono: ");
  String? telefono = stdin.readLineSync();

  //Se lee el correo electrónico
  stdout.write("Correo Electrónico: ");
  String? correo = stdin.readLineSync();

  //Se crean los objetos de contacto para ambos árboles
  ContactoPorNombre nuevoContactoPorNombre = ContactoPorNombre(
    nombre!,
    fechaNacimiento!,
    telefono!,
    correo!,
  );

  ContactoPorFecha nuevoContactoPorFecha = ContactoPorFecha(
    nombre,
    fechaNacimiento,
    telefono,
    correo,
  );

  //Se insertan en ambos árboles
  arbolPorNombre.insert(nuevoContactoPorNombre);
  arbolPorFecha.insert(nuevoContactoPorFecha);

  print("\nContacto '$nombre' agregado exitosamente.");
}

void borrarContacto(
  BinaryTree<ContactoPorNombre> arbolPorNombre,
  BinaryTree<ContactoPorFecha> arbolPorFecha,
) {
  print("Ingresa el nombre del contacto a borrar");

  //Se lee el nombre del contacto a borrar
  stdout.write("Nombre: ");
  String? nombre = stdin.readLineSync();

  ContactoPorNombre? contactoAEliminarPorNombre;
  ContactoPorFecha? contactoAEliminarPorFecha;
  bool encontrado = false;

  for (var contacto in arbolPorNombre) {
    if (contacto.getNombre() == nombre) {
      contactoAEliminarPorNombre = contacto;
      encontrado = true;
      break;
    }
  }

  if (encontrado) {
    for (var contacto in arbolPorFecha) {
      if (contacto.getNombre() == nombre) {
        contactoAEliminarPorFecha = contacto;
        break;
      }
    }

    arbolPorNombre.remove(contactoAEliminarPorNombre!);
    arbolPorFecha.remove(contactoAEliminarPorFecha!);

    print("\nContacto '$nombre' borrado exitosamente.");
    return;
  } else {
    print("\nContacto '$nombre' no encontrado.");
    return;
  }
}

ContactoPorNombre? consultarContacto(BinaryTree<ContactoPorNombre> arbolPorNombre) {
  print("Ingresa el nombre del contacto a consultar");

  //Se lee el nombre del contacto a consultar
  stdout.write("Nombre: ");
  String? nombre = stdin.readLineSync();

  for (var contacto in arbolPorNombre) {
    if (contacto.getNombre() == nombre) {
      print("\nContacto '$nombre' encontrado.");
      imprimirContacto(contacto);
      return contacto;
    }
  }

  print("\nContacto '$nombre' no encontrado.");
  return null;
}

List<ContactoPorFecha> listarPorCumple(BinaryTree<ContactoPorFecha> arbolPorFecha) {
  DateTime hoy = DateTime.now();
  hoy = DateTime(
    2000,
    hoy.month,
    hoy.day,
  ); // Año fijo para comparar solo mes y día

  if (arbolPorFecha.isNotEmpty) {

    List<ContactoPorFecha> cumplesPasados = [];
    List<ContactoPorFecha> cumplesPorVenir = [];

    for (var contacto in arbolPorFecha) {
      if (contacto.getFechaNacimiento().isBefore(hoy)) {
        cumplesPasados.add(contacto);
      } else if (contacto.getFechaNacimiento().isAtSameMomentAs(hoy) ||
          contacto.getFechaNacimiento().isAfter(hoy)) {
        cumplesPorVenir.add(contacto);
      }
    }

    cumplesPorVenir.addAll(cumplesPasados);

    return cumplesPorVenir;
    
  } else {
    print("\nNo hay contactos para mostrar.");
    return new List.empty();
  }
}

void listarPorNombre(BinaryTree<ContactoPorNombre> arbolPorNombre) {
  if (arbolPorNombre.isNotEmpty) {
    print("Contactos ordenados por nombre:");
    for (var contacto in arbolPorNombre) {
      imprimirContacto(contacto);
      print("");
    }
  } else {
    print("\nNo hay contactos para mostrar.");
  }
}

void esperarEnter() {
  print("\nPresiona Enter para continuar...");
  stdin.readLineSync();
}

void imprimirContacto(Contacto contacto) {
  print("---------------------------------------------");
  print(contacto);
  print("---------------------------------------------");
}
