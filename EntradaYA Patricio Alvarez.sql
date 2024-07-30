-- Creamos la base de datos

CREATE SCHEMA EntradasYA;

-- Seleccionamos el esquema EntradasYA

USE entradaya_model;

-- Creamos las tablas del modelo

CREATE TABLE Clientes (
	Id_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	Nombre VARCHAR(50) NOT NULL,
	Apellido VARCHAR(50) NOT NULL,
	TipoDocumento VARCHAR(30) NOT NULL,
	NumeroDocumento VARCHAR(20) UNIQUE NOT NULL,
	Telefono VARCHAR(20) NOT NULL,
	Direccion VARCHAR(50) NOT NULL,
	Id_Ciudad INTEGER NOT NULL,
	CP VARCHAR(10) NOT NULL,
	Email VARCHAR(100) NOT NULL,
	Fecha_de_Nacimiento DATE NOT NULL

);

CREATE TABLE Ventas (
	Id_ventas INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	Id_Evento INTEGER NOT NULL,
	Fecha DATE,
	Importe INTEGER,
	Forma_de_Pago VARCHAR(50),
	Id_Vendedor_cliente INTEGER NOT NULL,
	Id_Comprador_Cliente INTEGER NOT NULL

);

CREATE TABLE Entradas (
	Id_ventas INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	Id_Evento INTEGER NOT NULL,
	Fecha DATE,
	Importe INTEGER,
	Tipo_de_Pago VARCHAR(50),
	Id_Vendedor_cliente INTEGER NOT NULL,
	Id_Comprador_Cliente INTEGER NOT NULL

);


CREATE TABLE Eventos (
	Id_Eventos INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre_Evento VARCHAR(50) NOT NULL,
	Artista VARCHAR(50) NOT NULL,
	Id_Ciudad INTEGER NOT NULL
    
);

CREATE TABLE Provincias (

	Id_Provincia INT NOT NULL PRIMARY KEY,
    Provincia VARCHAR(50)
    
);


CREATE TABLE Ciudades (

	Id_Ciudad INT NOT NULL PRIMARY KEY,
    Ciudad VARCHAR(100),
    iD_Provincia INTEGER
    
);
