//ignore_for_file: unused_local_variable
import 'dart:io';

import 'package:binary_tree/binary_tree.dart';

import 'contacto.dart';
import 'contacto_por_nombre.dart';
import 'contacto_por_fecha.dart';
import 'logica_de_archivos.dart';

class Menu {
  int anioParaComparar = 2000;
  BinaryTree<ContactoPorNombre> arbolPorNombre;
  BinaryTree<ContactoPorFecha> arbolPorFecha;

  Menu(this.arbolPorNombre, this.arbolPorFecha);

  void empezar() {
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
          registraContacto();
          esperarEnter();
          break;
        case '2':
          print("================Borrar Contacto===============\n");
          borrarContacto();
          esperarEnter();
          break;
        case '3':
          print("==============Consultar Contacto=============\n");
          consultarContacto();
          esperarEnter();
          break;
        case '4':
          print("======Contactos por Fecha de Cumpleaños======\n");
          listarPorCumple(recorrerPorCumple());
          esperarEnter();
          break;
        case '5':
          print("=============Contactos por Nombre============\n");
          listarPorNombre(recorrerPorNombre());
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

  void agregarContactos(
    ContactoPorNombre contactoNombre,
    ContactoPorFecha contactoFecha,
  ) {
    arbolPorNombre.insert(contactoNombre);
    arbolPorFecha.insert(contactoFecha);
  }

  DateTime? validarYParsearFecha(String fecha) {
    try {
      List<String> partes = fecha.split("/");
      if (partes.length != 2) return null; // si son más de 2 campos

      int dia = int.parse(partes[0]);
      int mes = int.parse(partes[1]);

      return DateTime(anioParaComparar, mes, dia);
    } catch (e) {
      return null;
    }
  }

  bool nombreValido(String nombre) {
    if (nombre.trim().isEmpty) return false;

    // Si existe entonces no es válido
    return buscarPorNombre(nombre) == null;
  }

  void registraContacto() {
    String nombreContacto;
    while (true) {
      stdout.write("Nombre: ");
      String? nombreIngresado = stdin.readLineSync();

      if (nombreIngresado != null && nombreValido(nombreIngresado)) {
        nombreContacto = nombreIngresado;
        break;
      } else {
        print("Este nombre es inválido o ya existe. Intentar con otro.");
      }
    }

    DateTime? fechaContacto;
    while (true) {
      stdout.write("Fecha de nacimiento (DD/MM): ");
      String? fechaStr = stdin.readLineSync();

      if (fechaStr != null) {
        fechaContacto = validarYParsearFecha(fechaStr);
        if (fechaContacto != null) {
          break;
        }
      }
      print("Formato de fecha inválido. Usa DD/MM.");
    }

    stdout.write("Teléfono: ");
    String? telefono = stdin.readLineSync();

    stdout.write("Correo Electrónico: ");
    String? correo = stdin.readLineSync();

    ContactoPorNombre nuevoContactoNombre = ContactoPorNombre(
      nombreContacto,
      fechaContacto,
      telefono!,
      correo!,
    );

    ContactoPorFecha nuevoContactoFecha = ContactoPorFecha(
      nombreContacto,
      fechaContacto,
      telefono,
      correo,
    );

    agregarContactos(nuevoContactoNombre, nuevoContactoFecha);
  }

  void eliminarContacto(ContactoPorNombre? contactoNombre) {
    ContactoPorNombre? contactoNombreBorrado = buscarPorNombre(
      contactoNombre!.nombre,
    );

    if (contactoNombreBorrado == null) return;

    arbolPorNombre.remove(contactoNombreBorrado);

    ContactoPorFecha? contactoFechaBorrado = buscarPorFecha(
      contactoNombre.nombre,
    );

    // difícil que sea null ya que sabemos que existe en arbolPorNombre, por lo tanto también en el arbolPorFecha
    if (contactoFechaBorrado != null) {
      arbolPorFecha.remove(contactoFechaBorrado);
    }
  }

  void borrarContacto() {
    ContactoPorNombre? contactoNombre = buscarPorNombre(leerNombre());

    if (contactoNombre == null) {
      print("No se encontró el contacto con ese nombre.");
      return;
    } else {
      eliminarContacto(contactoNombre);
      print("Contacto eliminado exitosamente.");
    }
  }

  ContactoPorFecha? buscarPorFecha(String nombre) {
    for (var contactoActual in arbolPorFecha) {
      if (contactoActual.nombre == nombre) {
        return contactoActual;
      }
    }
    return null;
  }

  ContactoPorNombre? obtenerContacto(ContactoPorNombre? contactoConsultado) {
    return buscarPorNombre(contactoConsultado!.nombre);
  }

  void consultarContacto() {
    ContactoPorNombre? contactoNombre = buscarPorNombre(leerNombre());

    if (contactoNombre != null) {
      imprimirContacto(contactoNombre);
    } else {
      print("No se encontró el contacto con ese nombre.");
    }
  }

  ContactoPorNombre? buscarPorNombre(String nombre) {
    for (var contactoActual in arbolPorNombre) {
      if (contactoActual.nombre == nombre) {
        return contactoActual;
      }
    }
    return null;
  }

  List<ContactoPorFecha> recorrerPorCumple() {
    DateTime hoy = DateTime.now();
    DateTime fechaActual = DateTime(anioParaComparar, hoy.month, hoy.day);

    if (arbolPorFecha.isEmpty) {
      return List.empty();
    }

    List<ContactoPorFecha> listaOrdenada = arbolPorFecha.toList();

    listaOrdenada.sort((a, b) {
      DateTime fechaA = DateTime(
        anioParaComparar,
        a.fechaNacimiento.month,
        a.fechaNacimiento.day,
      );
      DateTime fechaB = DateTime(
        anioParaComparar,
        b.fechaNacimiento.month,
        b.fechaNacimiento.day,
      );

      bool esFuturaA = !fechaA.isBefore(fechaActual);
      bool esFuturaB = !fechaB.isBefore(fechaActual);

      if (esFuturaA && !esFuturaB) {
        return -1; // A va antes que B
      } else if (!esFuturaA && esFuturaB) {
        return 1;  // B va antes que A
      } else {
        return fechaA.compareTo(fechaB);
      }
    });

    return listaOrdenada;
  }

  void listarPorCumple(List<ContactoPorFecha> contactosPorCumple) {
    if (contactosPorCumple.isEmpty) {
      print("\nNo hay contactos para mostrar.");
      return;
    }

    for (var contacto in contactosPorCumple) {
      imprimirContacto(contacto);
    }
  }

  List<ContactoPorNombre> recorrerPorNombre(){
    if(arbolPorNombre.isEmpty){
      return List.empty();
    }

    List<ContactoPorNombre> contactos = [];
    for(var contacto in arbolPorNombre){
      contactos.add(contacto);
    }
    
    return contactos;
  }

  void listarPorNombre(List<ContactoPorNombre> listaDeContactos) {
    if (listaDeContactos.isEmpty) {
      print("\nNo hay contactos para mostrar.");
      return;
    }

    for (var contacto in listaDeContactos) {
      imprimirContacto(contacto);
    }
  }

  String leerNombre() {
    String nombreContacto;
    while (true) {
      stdout.write("Nombre: ");
      String? nombreIngresado = stdin.readLineSync();

      if (nombreIngresado != null && nombreIngresado.trim().isNotEmpty) {
        nombreContacto = nombreIngresado;
        break;
      } else {
        print("Este nombre es inválido. Intente con otro.");
      }
    }
    return nombreContacto;
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
}
