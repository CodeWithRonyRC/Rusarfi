package com.rusarfi.app;

import com.rusarfi.model.Producto;
import jakarta.persistence.*;

import java.math.BigDecimal;
import java.util.Scanner;

public class AppProducto {

    public static void main(String[] args) {

        EntityManagerFactory emf = Persistence.createEntityManagerFactory("appRusarfi");
        EntityManager em = emf.createEntityManager();

        Scanner scanner = new Scanner(System.in);
        int opcion = 0;

        while (opcion != 6) {
            System.out.println("\n-- CRUD PRODUCTOS --");
            System.out.println("1. Crear");
            System.out.println("2. Buscar");
            System.out.println("3. Mostrar");
            System.out.println("4. Eliminar");
            System.out.println("5. Actualizar");
            System.out.println("6. Salir");
            System.out.print("Elija una opción: ");
            opcion = scanner.nextInt();
            scanner.nextLine();

            switch (opcion) {
                case 1:
                    Producto p = new Producto();
                    System.out.print("Nombre del producto: ");
                    p.setNombre(scanner.nextLine());

                    System.out.print("Precio: ");
                    p.setPrecio(scanner.nextBigDecimal());

                    System.out.print("Stock: ");
                    p.setStock(scanner.nextInt());

                    em.getTransaction().begin();
                    em.persist(p);
                    em.getTransaction().commit();

                    System.out.println("Producto creado correctamente.");
                    break;

                case 2:
                    System.out.print("ID del producto: ");
                    int id = scanner.nextInt();
                    scanner.nextLine();

                    Producto encontrado = em.find(Producto.class, id);

                    if (encontrado != null) {
                        System.out.println("--- Producto encontrado ---");
                        System.out.println(encontrado);
                    } else {
                        System.out.println("No se encontró ningún producto con ese ID.");
                    }

                    break; // ← ESTE break es el que falta
                case 3:
                    System.out.println("--- Lista de Productos ---");
                    em.createQuery("SELECT p FROM Producto p", Producto.class)
                            .getResultList()
                            .forEach(System.out::println);
                    break;

                case 4:
                    System.out.print("ID del producto a eliminar: ");
                    Producto eliminar = em.find(Producto.class, scanner.nextInt());

                    em.getTransaction().begin();
                    em.remove(eliminar);
                    em.getTransaction().commit();

                    System.out.println("Producto eliminado.");
                    break;

                case 5:
                    System.out.print("ID del producto a actualizar: ");
                    Producto actualizar = em.find(Producto.class, scanner.nextInt());
                    scanner.nextLine();

                    System.out.print("Nuevo nombre (" + actualizar.getNombre() + "): ");
                    actualizar.setNombre(scanner.nextLine());

                    System.out.print("Nuevo precio (" + actualizar.getPrecio() + "): ");
                    actualizar.setPrecio(scanner.nextBigDecimal());

                    System.out.print("Nuevo stock (" + actualizar.getStock() + "): ");
                    actualizar.setStock(scanner.nextInt());

                    em.getTransaction().begin();
                    em.merge(actualizar);
                    em.getTransaction().commit();

                    System.out.println("Producto actualizado.");
                    break;

                case 6:
                    System.out.println("Saliendo...");
                    break;

                default:
                    System.out.println("Opción no válida.");
                    break;
            }
        }

        em.close();
        emf.close();
    }
}