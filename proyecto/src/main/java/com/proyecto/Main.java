package com.proyecto;

import java.sql.*;
import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        try {
            String driver = "org.postgresql.Driver";
            String url = "jdbc:postgresql://localhost/postgres";
            String username = "postgres";
            String password = "root";
            int opcionMenu = 0;
            int opcionPadrino = 0;
            Scanner entrada = new Scanner(System.in);

            // Load database driver if not already loaded.
            Class.forName(driver);
            // Establish network connection to database.
            Connection connection = DriverManager.getConnection(url, username, password);

            do {
                System.out.println("Bienvenido A Ciudad De Los Niños");
                System.out.println("     Seleccione una opcion");
                System.out.println("      1. Insertar Padrino");
                System.out.println("     2. Eliminar Un Donante");
                System.out.println("  3. Ver Todas Las Donanciones");
                System.out.println("           4. Salir");
                opcionMenu = entrada.nextInt();
            } while (opcionMenu < 1 || opcionMenu > 4);
            switch (opcionMenu) {
                case 1:
                    do {
                        System.out.println("1. Donante");
                        System.out.println("2. Contacto");
                        System.out.println("3. Donante y Contacto");
                        opcionPadrino = entrada.nextInt();
                    } while (opcionPadrino < 1 || opcionPadrino > 3);
                    System.out.println("Ingrese Los Datos Del Padrino");
                    System.out.println("DNI:");
                    int dni = entrada.nextInt();
                    entrada.nextLine();
                    System.out.println("Nombre Y Apellido:");
                    String nomyAp = entrada.nextLine();
                    System.out.println("Direccion:");
                    String dir = entrada.nextLine();
                    System.out.println("Codigo Postal:");
                    String cp = entrada.nextLine();
                    System.out.println("Email:");
                    String email = entrada.nextLine();
                    System.out.println("Facebook:");
                    String fb = entrada.nextLine();
                    System.out.println("Fecha De Nacimiento (año-mes-dia):");
                    String fechaNac = entrada.nextLine();
                     //insertar padrino
                    String query1 =  "INSERT INTO ciudadninios.padrino (dni, nom_y_ap, direccion, cp, email, facebook, fecha_nac) VALUES("+ dni +", '" + nomyAp + "', '" + dir + "', '" + cp + "', '" + email + "', '" + fb + "', '" + fechaNac + "')";
                    PreparedStatement statement1 = connection.prepareStatement(query1);
                    statement1.executeUpdate();
                    if (opcionPadrino == 1 || opcionPadrino == 3){
                        System.out.println("Ocupacion:");
                        String ocupacion = entrada.nextLine();
                        System.out.println("Cuit/Cuil");
                        String cuit_cuil = entrada.nextLine();
                        query1 =  "INSERT INTO ciudadninios.donante (dni, ocupacion, cuit_cuil) VALUES ("+ dni +", '" + ocupacion + "', '" + cuit_cuil + "')";
                        statement1 = connection.prepareStatement(query1);
                        statement1.executeUpdate();
                        // insertar donante
                    }
                    if (opcionPadrino == 2 || opcionPadrino == 3){
                        System.out.println("Estado:");
                        String estado = entrada.nextLine();
                        System.out.println("Fecha De Primer Contacto (año-mes-dia):");
                        String fechaPrimerCont = entrada.nextLine();
                        // fechas?????
                        // insertar contacto
                        query1 = "INSERT INTO ciudadninios.contacto (dni, estado, fecha_prim_cont, fecha_alta, fecha_baja, fecha_adhesion, fecha_rechazo) VALUES(" + dni + ", '" + estado + "', '" + fechaPrimerCont + "', " + "NULL, " + "NULL, " + "NULL, " + "NULL" + ")";
                        statement1 = connection.prepareStatement(query1);
                        statement1.executeUpdate();
                    }
                

                    
                    break;
            
                case 2:
                    System.out.println("Ingrese Los Datos Del Padrino");
                    System.out.println("DNI:");
                    int dniE = entrada.nextInt();
                    try {
                        String query2 = "DELETE FROM ciudadninios.donante WHERE dni = "+ dniE;
                        PreparedStatement statement2 = connection.prepareStatement(query2);
                        statement2.executeUpdate();
                        System.out.println("El donante " + dniE + " fue eliminado");
                        try {
                            query2 = "DELETE FROM ciudadninios.padrino WHERE dni = "+ dniE;
                            statement2 = connection.prepareStatement(query2);
                            statement2.executeUpdate();
                        } catch (SQLIntegrityConstraintViolationException e) {
                            System.out.println("El padrino aun se encuentra como contacto: " + e);
                        } catch (SQLException ex) {
                            System.out.println("Error al borrar el donante: " + ex);
                        }
                    } catch (SQLException e) {
                        System.out.println("Error al borrar el donante: " + e);
                    }
                    
                    
                    
                    
                    break;

                case 3:
                    String query = "SELECT dni, frecuencia, monto, nombre FROM ciudadninios.donante natural join ciudadninios.aporte natural join ciudadninios.programa ";
                    PreparedStatement statement = connection.prepareStatement(query);
                    ResultSet resultSet = statement.executeQuery();
                    while(resultSet.next()) {
                        System.out.print(" DNI: " + resultSet.getString(1));
                        System.out.print("; Frecuencia de pago: " + resultSet.getString(2)) ;
                        System.out.print("; Monto de pago: " + resultSet.getString(3)) ;
                        System.out.print("; Programa: " + resultSet.getString(4)) ;
                        System.out.print("\n  ");
                        System.out.print("\n");
                    }
                    break;

                case 4:
                    break;
            }
        } catch (ClassNotFoundException e) {
            System.err.println("Error loading driver: " + e);
        } catch(SQLException sqlEx) {
            sqlEx.printStackTrace();
        System.err.println("Error connecting: " + sqlEx);
        }
    }
}