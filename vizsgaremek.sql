CREATE DATABASE IF NOT EXISTS `vizsgaremek` 
  DEFAULT CHARACTER SET utf8 
  COLLATE utf8_hungarian_ci;

USE `vizsgaremek`;

CREATE TABLE `felhasznalok` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nev` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL UNIQUE,
  `jelszo` VARCHAR(255) NOT NULL,
  `cim` VARCHAR(255) DEFAULT NULL,
  `telefon` VARCHAR(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

CREATE TABLE `etelek` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nev` VARCHAR(100) NOT NULL,
  `leiras` TEXT,
  `ar` INT(11) NOT NULL,
  `kategori` VARCHAR(50) DEFAULT NULL,
  `kep` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

CREATE TABLE `rendelesek` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `felhasznalo_id` INT(11) DEFAULT NULL,
  `datum` DATETIME DEFAULT CURRENT_TIMESTAMP,
  `allapot` ENUM('Folyamatban','Kiszállítva','Törölve') DEFAULT 'Folyamatban',
  `osszeg` INT(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `felhasznalo_id` (`felhasznalo_id`),
  CONSTRAINT `rendelesek_ibfk_1` FOREIGN KEY (`felhasznalo_id`) REFERENCES `felhasznalok` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;

CREATE TABLE `rendeles_tetelek` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `rendeles_id` INT(11) NOT NULL,
  `etel_id` INT(11) NOT NULL,
  `mennyiseg` INT(11) DEFAULT 1,
  `ar` INT(11) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `rendeles_id` (`rendeles_id`),
  KEY `etel_id` (`etel_id`),
  CONSTRAINT `rendeles_tetelek_ibfk_1` FOREIGN KEY (`rendeles_id`) REFERENCES `rendelesek` (`id`) ON DELETE CASCADE,
  CONSTRAINT `rendeles_tetelek_ibfk_2` FOREIGN KEY (`etel_id`) REFERENCES `etelek` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_hungarian_ci;


INSERT INTO `felhasznalok` (`nev`, `email`, `jelszo`, `cim`, `telefon`) VALUES
('Kiss Péter', 'kiss.peter@example.com', 'jelszo123', 'Budapest, Fő utca 12', '06201234567'),
('Nagy Anna', 'nagy.anna@example.com', 'titok456', 'Szeged, Tisza Lajos krt. 5', '06301234567');

INSERT INTO `etelek` (`nev`, `leiras`, `ar`, `kategori`, `kep`) VALUES
('Margherita pizza', 'Paradicsomos, mozzarellás klasszikus olasz pizza', 2500, 'Pizza', 'margherita.jpg'),
('Carbonara spagetti', 'Tésztás étel tojással és szalonnával', 2800, 'Tészta', 'carbonara.jpg'),
('Tiramisu', 'Olasz desszert mascarponéval', 1500, 'Desszert', 'tiramisu.jpg');

INSERT INTO `rendelesek` (`felhasznalo_id`, `osszeg`) VALUES
(1, 4000),
(2, 1500);

INSERT INTO `rendeles_tetelek` (`rendeles_id`, `etel_id`, `mennyiseg`, `ar`) VALUES
(1, 1, 1, 2500),
(1, 2, 1, 1500),
(2, 3, 1, 1500);


