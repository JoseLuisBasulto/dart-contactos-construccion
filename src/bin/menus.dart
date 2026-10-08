//ignore_for_file: unused_local_variable
import 'dart:io';
import 'package:binary_tree/binary_tree.dart';
import 'contacto.dart';
import 'logica_de_archivos.dart';

const int anioParaComparar = 2000;


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
        //agregarContacto(arbolPorNombre, arbolPorFecha);
        esperarEnter();
        break;
      case '2':
        print("================Borrar Contacto===============\n");
        //borrarContacto(arbolPorNombre, arbolPorFecha);
        esperarEnter();
        break;
      case '3':
        print("==============Consultar Contacto=============\n");
        //consultarContacto(arbolPorNombre);
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

void agregarContacto(
  BinaryTree<ContactoPorNombre> arbolPorNombre,
  BinaryTree<ContactoPorFecha> arbolPorFecha, 
  ContactoPorNombre nuevoContactoNombre, 
  ContactoPorFecha nuevoContactoFecha
  ) {

  arbolPorNombre.insert(nuevoContactoNombre);
  arbolPorFecha.insert(nuevoContactoFecha);
}

bool validarNombre(String nombre, BinaryTree<ContactoPorNombre> arbolPorNombre){
  if(nombre.trim().isEmpty) return false;

  ContactoPorNombre? contactoEcontrado = buscarPorNombre(arbolPorNombre, nombre);

  if(contactoEcontrado == null){
    return true;
  }else{
    return false;
  }
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

void registraContacto(
  BinaryTree<ContactoPorNombre> arbolPorNombre,
  BinaryTree<ContactoPorFecha> arbolPorFecha
  ) {
  print("Ingresa los datos del contacto");

  String nombre;
  while (true) {
    stdout.write("Nombre: ");
    String? nombreIngresado = stdin.readLineSync();
    
    if (nombreIngresado != null && validarNombre(nombreIngresado, arbolPorNombre)) {
      nombre = nombreIngresado;
      break;
    } else {
      print("Este nombre es inválido o ya existe. Intentar con otro.");
    }
  }

  DateTime? fechaNacimiento;
  while (true) {
   stdout.write("Fecha de nacimiento (DD/MM): ");
    String? fechaStr = stdin.readLineSync();
    
    if (fechaStr != null) {
      fechaNacimiento = validarYParsearFecha(fechaStr);
      if (fechaNacimiento != null) {
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
    nombre, fechaNacimiento, telefono!, correo!
  );
  
  ContactoPorFecha nuevoContactoFecha = ContactoPorFecha(
    nombre, fechaNacimiento, telefono, correo
  );

  agregarContacto(arbolPorNombre, arbolPorFecha, nuevoContactoNombre, nuevoContactoFecha);
}

void borrarContacto(
  BinaryTree<ContactoPorNombre> arbolPorNombre,
  BinaryTree<ContactoPorFecha> arbolPorFecha,
  ContactoPorNombre contactoNombre,
) {
  ContactoPorNombre? contactoNombreBorrado = buscarPorNombre(arbolPorNombre, contactoNombre.nombre);

  if(contactoNombreBorrado == null) return;

  arbolPorNombre.remove(contactoNombreBorrado);

  ContactoPorFecha? contactoFechaBorrado = buscarPorFecha(arbolPorFecha, contactoNombre.nombre);

  // difícil que sea null ya que sabemos que existe en arbolPorNombre, por lo tanto también en el arbolPorFecha
  if(contactoFechaBorrado != null){
    arbolPorFecha.remove(contactoFechaBorrado);
  }
}

ContactoPorFecha? buscarPorFecha(BinaryTree<ContactoPorFecha> arbolPorFecha, String nombre) {
  for (var contactoActual in arbolPorFecha) {
    if (contactoActual.nombre == nombre) {
      return contactoActual;
    }
  }
  return null;
}

ContactoPorNombre? consultarContacto(
  BinaryTree<ContactoPorNombre> arbolPorNombre,
  ContactoPorNombre contactoConsultado) {

  return buscarPorNombre(arbolPorNombre, contactoConsultado.nombre);
}

ContactoPorNombre? buscarPorNombre(BinaryTree<ContactoPorNombre> arbolPorNombre, String nombre) {
  for (var contactoActual in arbolPorNombre) {
    if (contactoActual.nombre == nombre) {
      return contactoActual;
    }
  }
  return null;
}

List<ContactoPorFecha> listarPorCumple(BinaryTree<ContactoPorFecha> arbolPorFecha) {
  DateTime hoy = DateTime.now();

  DateTime fechaActual = DateTime(
    anioParaComparar,
    hoy.month,
    hoy.day,
  );

  if(arbolPorFecha.isEmpty){
    return List.empty();
  }

  List<ContactoPorFecha> listaOrdenada = [];
  int cumplesPasados = 0; // contador para saber cuantas personas cumplen antes o en la misma fecha que la actual

  for (var contacto in arbolPorFecha) {
    var fechaNac = contacto.fechaNacimiento;

    if(fechaNac.isBefore(fechaActual)){
      listaOrdenada.add(contacto);
      cumplesPasados++;
    }else{
      int posicion = listaOrdenada.length - cumplesPasados;
      listaOrdenada.insert(posicion, contacto); // se coloca el contacto justo antes de los cumpleaños pasados
    }
  }

  return listaOrdenada;
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
