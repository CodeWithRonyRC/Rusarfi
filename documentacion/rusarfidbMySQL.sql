DROP DATABASE IF EXISTS rusarfi_db;
CREATE DATABASE rusarfi_db;
USE rusarfi_db;

-- 1. Empleados
CREATE TABLE tblUsuario (
    idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nombreUsuario VARCHAR(100) NOT NULL,
    emailUsuario VARCHAR(100) UNIQUE NOT NULL,
    passwordUsuario VARCHAR(255) NOT NULL,
    rolUsuario ENUM('Administrador', 'Editor') DEFAULT 'Editor',
    fechaRegistro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Categorías
CREATE TABLE tblCategoria (
    idCategoria INT AUTO_INCREMENT PRIMARY KEY,
    nombreCategoria VARCHAR(100) NOT NULL UNIQUE,
    descripcionCategoria VARCHAR(255)
);

-- 3. Productos
CREATE TABLE tblProducto (
    idProducto INT AUTO_INCREMENT PRIMARY KEY,
    nombreProducto VARCHAR(100) NOT NULL,
    descripcionProducto TEXT,
    precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
    stock INT NOT NULL,
    talla ENUM('S','M','L','XL') DEFAULT 'S',
    color VARCHAR(50),
    material VARCHAR(100),
    idCategoria INT,
    fechaRegistro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (idCategoria) REFERENCES tblCategoria(idCategoria)
        ON UPDATE CASCADE ON DELETE SET NULL
);
CREATE TABLE ImagenProducto (
    idImagen INT AUTO_INCREMENT PRIMARY KEY,
    urlImagen VARCHAR(255) NOT NULL,
    idProducto INT,
    FOREIGN KEY (idProducto) REFERENCES tblProducto(idProducto)
);

-- 4. Inventario
CREATE TABLE tblInventario (
    idInventario INT AUTO_INCREMENT PRIMARY KEY,
    idProducto INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad >= 0),
    ultimaActualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (idProducto) REFERENCES tblProducto(idProducto)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- 5. Contenido institucional (solo una vez)
CREATE TABLE tblInstitucional (
    idInstitucional INT AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('MISION','VISION','VALORES','HISTORIA') NOT NULL UNIQUE,
    contenido TEXT NOT NULL,
    fechaActualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 6. Publicaciones (noticias, ofertas, promociones, blog)
CREATE TABLE tblPublicacion (
    idPublicacion INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    contenido TEXT NOT NULL,
    tipo ENUM('NOTICIA','PROMOCION','OFERTA','BLOG','CONSULTA') DEFAULT 'BLOG',
    idUsuario INT,
    fechaPublicacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (idUsuario) REFERENCES tblUsuario(idUsuario)
        ON UPDATE CASCADE ON DELETE SET NULL
);
CREATE TABLE ImagenPublicacion (
    idImagen INT AUTO_INCREMENT PRIMARY KEY,
    urlImagen VARCHAR(255) NOT NULL,
    idPublicacion INT,
    FOREIGN KEY (idPublicacion) REFERENCES tblPublicacion(idPublicacion)
);
