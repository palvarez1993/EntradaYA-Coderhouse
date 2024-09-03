
-- CREAMOS LA BASE DE DATOS DE EntradaYA

DROP SCHEMA IF EXISTS EntradaYa;


CREATE SCHEMA EntradaYa;

-- SELECCIONAMOS EL ESQUEMA ENTRADAYA

USE entradaYa;

-- CREA TABLA provincias

CREATE TABLE provincias (

	id_provincia INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    provincia VARCHAR(50)
    
);

-- CREA TABLA Ciudades

CREATE TABLE ciudades (

	id_ciudad INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    ciudad VARCHAR(100),
    id_Provincia INTEGER,
    
FOREIGN KEY (id_provincia) REFERENCES provincias (id_provincia) ON DELETE CASCADE ON UPDATE CASCADE
    
);

-- CREA TABLA CLIENTES

CREATE TABLE usuarios (
	id_usuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	tipoDocumento VARCHAR(30) NOT NULL,
	numeroDocumento INTEGER NOT NULL,
	telefono VARCHAR(50) NOT NULL,
	direccion VARCHAR(50) NOT NULL,
	id_Ciudad INTEGER NOT NULL,
	codigo_postal VARCHAR(50) NOT NULL,
	email VARCHAR(100) NOT NULL,
	fecha_de_nacimiento DATE NOT NULL,

FOREIGN KEY (id_ciudad) REFERENCES ciudades (id_ciudad) ON DELETE CASCADE ON UPDATE CASCADE


);

-- CREA TABLA eventos

CREATE TABLE eventos (
	id_evento INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_evento VARCHAR(50) NOT NULL,
	artista VARCHAR(50) NOT NULL,
	id_ciudad INTEGER NOT NULL,
    
FOREIGN KEY (id_ciudad) REFERENCES ciudades (id_ciudad) ON DELETE CASCADE ON UPDATE CASCADE

);

-- CREA TABLA entradas

CREATE TABLE entradas (
	id_entrada INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
	id_evento INTEGER NOT NULL,
    id_usuario INT,
    precio  DECIMAL (10 , 2) NOT NULL,
	fecha_compra DATE NOT NULL,
    estado ENUM ('Vendida' , 'Disponible' , 'Reservada') DEFAULT 'Disponible',
    
FOREIGN KEY (id_evento) REFERENCES eventos (id_evento) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (id_usuario) REFERENCES usuarios (id_usuario) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE metodos_pago (
    id_metodo_pago INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL
    
    );
    
CREATE TABLE transacciones (
    id_transaccion INT AUTO_INCREMENT PRIMARY KEY,
    id_entrada INT,
    id_metodo_pago INT,
    monto DECIMAL(10, 2) NOT NULL,
    fecha_transaccion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_entrada) REFERENCES entradas (id_entrada) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (id_metodo_pago) REFERENCES metodos_pago (id_metodo_pago) ON DELETE CASCADE ON UPDATE CASCADE
);


-- VISTA USUARIOS CON PROVINCIA Y CIUDAD

CREATE OR REPLACE VIEW ListaUsuarios AS
SELECT
    u.id_usuario AS ID,
    u.nombre AS Nombre,
    u.apellido AS Apellido,
    u.tipoDocumento AS TipoDocumento,
    u.numeroDocumento AS NumeroDocumento,
    u.telefono AS Telefono,
    u.direccion AS Direccion,
    c.ciudad AS Ciudad,
    p.provincia AS Provincia,
    u.codigo_postal AS CodigoPostal,
    u.email AS Email,
    u.fecha_de_nacimiento AS FechaNacimiento
FROM
    usuarios u
JOIN
    ciudades c ON u.id_ciudad = c.id_ciudad
JOIN
    provincias p ON c.id_provincia = p.id_provincia;
			
-- VISTA USUARIOS CON ENTRADAS

CREATE OR REPLACE VIEW UsuariosConEntradas AS

SELECT
    u.id_usuario AS IDUsuario,
    CONCAT(u.nombre, ' ', u.apellido) AS NombreCompleto,
    u.email AS Email,
    e.nombre_evento AS NombreEvento,
    en.precio AS PrecioEntrada,
    en.fecha_compra AS FechaCompra,
    en.estado AS EstadoEntrada
    
FROM
    usuarios u
JOIN
    entradas en ON u.id_usuario = en.id_usuario
JOIN
    eventos e ON en.id_evento = e.id_evento;
    
-- VISTA EVENTOS CON DATOS DE CIUDAD

CREATE OR REPLACE VIEW EventosporCiudad AS
SELECT
    e.nombre_evento AS NombreEvento,
    c.ciudad AS Ciudad
   
FROM
    eventos e
JOIN
    ciudades c ON e.id_ciudad = c.id_ciudad
    
    ORDER BY ciudad
;

-- VISTA EVENTOS CON DATOS DE PROVINCIAS

CREATE OR REPLACE VIEW EventosPorProvinciaSimplificado AS
SELECT
    e.nombre_evento AS NombreEvento,
    p.provincia AS Provincia
    
FROM
    eventos e
JOIN
    ciudades c ON e.id_ciudad = c.id_ciudad
JOIN
    provincias p ON c.id_provincia = p.id_provincia
ORDER BY
    p.provincia
;

-- VISTA entradas vendidas

CREATE VIEW vista_entradas_compradas AS
SELECT
    en.id_entrada,
    u.nombre AS nombre_usuario,
    u.apellido AS apellido_usuario,
    e.nombre_evento,
    e.artista,
    en.precio,
    en.fecha_compra,
    en.estado
FROM
    entradas en
JOIN
    usuarios u ON en.id_usuario = u.id_usuario
JOIN
    eventos e ON en.id_evento = e.id_evento
WHERE
    en.estado = 'Vendida';