DROP DATABASE IF EXISTS PRACTICA2_MO2_M05;
CREATE DATABASE IF NOT EXISTS PRACTICA2_MO2_M05;
USE PRACTICA2_MO2_M05;
 
CREATE TABLE carrec_empleat(
Nom_Carrec VARCHAR(30),
Primary key (Nom_Carrec),
Descripcio char(100),
HoresContracte int (3) UNSIGNED,
Sou_base DECIMAL(5,2)
);
CREATE TABLE localitat (
Id_Lloc int UNSIGNED AUTO_INCREMENT,
Nom_localitat VARCHAR(30),
Provincia VARCHAR(30),
Comunitat_autonoma VARCHAR(30),
Pais VARCHAR(30),
Continent VARCHAR(30),
Primary key (Id_Lloc)
);
CREATE TABLE PERSONA(
DNI VARCHAR(9),
PRIMARY KEY (DNI),
Nom VARCHAR(30) NOT NULL,
Cognom1 VARCHAR(30) NOT NULL,
Cognom2 VARCHAR(30)NOT NULL,
email VARCHAR(30) NOT NULL UNIQUE);

CREATE TABLE empleat(
DNI_Empleat VARCHAR(9),
Primary Key(DNI_Empleat), 
Num_SS VARCHAR(12),
Num_CC VARCHAR(24),
Nom_Carrec VARCHAR(30),
DNI_cap VARCHAR(30),
Lloc_naixament int  UNSIGNED AUTO_INCREMENT,
Quantitat_sou_extra DECIMAL(5,2),
CONSTRAINT FK1_empleat_DNI_empleat FOREIGN KEY (DNI_EMpleat) REFERENCES Persona(DNI) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT FK2_empleat_Nom_Carrec FOREIGN KEY (Nom_Carrec) REFERENCES carrec_empleat(Nom_Carrec) ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT FK3_empleat_DNI_cap FOREIGN KEY (DNI_cap) REFERENCES empleat(DNI_Empleat)ON DELETE CASCADE ON UPDATE CASCADE,
 CONSTRAINT FK4_empleat_Lloc_naixament FOREIGN KEY (Lloc_naixament) REFERENCES localitat(Id_Lloc)ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE bar(
Id_Bar int UNSIGNED AUTO_INCREMENT,
Primary key (Id_Bar),
nom VARCHAR(30),
Aformanet_maxim  boolean,
Te_exterior VARCHAR(30),
Ubicacio int unsigned,
CONSTRAINT FK_bar_ubicacio FOREIGN KEY (Ubicacio)REFERENCES localitat(Id_Lloc) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE taula( 
Numero_taula int,
Id_Bar int unsigned,
PRIMARY KEY (Numero_taula, Id_Bar),
Es_exterior boolean,
Es_fumador boolean,
Num_cadires int (10) UNSIGNED,
CONSTRAINT FK_taula_idBar FOREIGN KEY (Id_Bar) REFERENCES bar(Id_Bar) ON DELETE CASCADE ON UPDATE CASCADE
);




 
CREATE TABLE IF NOT EXISTS client(
DNI_client Varchar(9) not null,
es_major enum('V','F') not null default 'F',
CONSTRAINT PK_dni_client PRIMARY KEY (dni_client),
CONSTRAINT FK1_dni_client FOREIGN KEY(dni_client) REFERENCES Persona(DNI) ON DELETE CASCADE ON UPDATE CASCADE
);
DROP TABLE IF EXISTS client_taula;

CREATE TABLE IF NOT EXISTS client_taula(
id_client_taula int auto_increment,
DNI_client Varchar(9) not null,
numero_taula int check (numero_taula>=0),
id_bar int unsigned not null ,
es_fumador enum('V','F') not null default 'F',
data_hora_arribada datetime,
data_hora_sortida datetime,
ha_pagat bool,
CONSTRAINT PK_id_client_taula PRIMARY KEY (id_client_taula),
CONSTRAINT FK2_DNI_client FOREIGN KEY (DNI_client) REFERENCES client(DNI_client) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT FK1_Numero_Taula FOREIGN KEY (numero_taula) REFERENCES Taula(numero_taula) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT FK1_id_bar FOREIGN KEY (id_bar) REFERENCES taula(Id_bar) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS tapa (
  id_tapa INT(10) NOT NULL AUTO_INCREMENT ,
  nom VARCHAR(255) NOT NULL DEFAULT '',
  descripcio_taula VARCHAR(255) NOT NULL DEFAULT '',
  temps_preparacio INT(10) NOT NULL DEFAULT 0, 
  es_calent enum('V','F') NOT NULL DEFAULT 'F',
  es_vegeta enum('V','F') NOT NULL DEFAULT 'F',
  es_individual enum('V','F') NOT NULL DEFAULT 'F',
  CONSTRAINT PK_tapa_ID PRIMARY KEY (id_tapa)
) ; 

DROP TABLE IF EXISTS beguda;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS beguda (
  id_beguda INT(10) NOT NULL AUTO_INCREMENT ,
  nom VARCHAR(35) NOT NULL DEFAULT '',
  descripcio VARCHAR(255) NOT NULL DEFAULT '',
  es_calent enum('V','F') NOT NULL DEFAULT 'F',
  te_alcohol enum('V','F') NOT NULL DEFAULT 'F',
  quantiat_cl INT(10) NOT NULL,
  CONSTRAINT PK_beguda_ID_beguda PRIMARY KEY (id_beguda)
) ; 

DROP TABLE IF EXISTS distribuidor;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS distribuidor (
  id_distribuidor INT(10) NOT NULL AUTO_INCREMENT ,
  nom_empresa VARCHAR(255) NOT NULL DEFAULT '',
  contacte_principal VARCHAR(255) NOT NULL DEFAULT '',
  telefon VARCHAR(255) NOT NULL DEFAULT '',
  email VARCHAR(255) NOT NULL DEFAULT '',
  web VARCHAR(255) NOT NULL DEFAULT '',
  CONSTRAINT PK_distribuidor_ID PRIMARY KEY (id_distribuidor)
) ; 

DROP TABLE IF EXISTS distro_beguda;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS distro_beguda (
  id_distribuidor INT(10) NOT NULL,
  id_beguda INT(10) NOT NULL,
  cost_venda INT(10) NOT NULL,
  CONSTRAINT PK_distro_beguda PRIMARY KEY (id_distribuidor, id_beguda), 
  CONSTRAINT FK_distro_beguda_ID_distribuidor FOREIGN KEY (id_distribuidor) REFERENCES distribuidor (id_distribuidor) ON UPDATE CASCADE ON DELETE CASCADE, 
  CONSTRAINT FK_distro_beguda_ID_beguda FOREIGN KEY (id_beguda) REFERENCES beguda (id_beguda) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS ingredient;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS ingredient (
  id_ingredient INT(10) NOT NULL AUTO_INCREMENT ,
  nom VARCHAR(35) NOT NULL DEFAULT '',
  descripcio_ingredient VARCHAR(255) NOT NULL DEFAULT '',
  es_picant ENUM('V','F') NOT NULL DEFAULT 'F',
  es_importacio ENUM('V','F') NOT NULL DEFAULT 'F',
  cost_gram INT(10) NOT NULL,
  id_distribuidor INT(10) NOT NULL,
  CONSTRAINT PK_ingredient_ID PRIMARY KEY (id_ingredient), 
  CONSTRAINT FK_ingredient_ID_distribuidor FOREIGN KEY (id_distribuidor) REFERENCES distribuidor (id_distribuidor)ON UPDATE CASCADE ON DELETE CASCADE
) ; 


DROP TABLE IF EXISTS ingredients_tapa;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE IF NOT EXISTS ingredients_tapa (
  id_ingredient INT(10) NOT NULL,
  id_tapa INT(10) NOT NULL,
  quantitat INT(10) NOT NULL,
  CONSTRAINT PK_ingredients_tapa PRIMARY KEY (id_ingredient, id_tapa),
  CONSTRAINT FK_ingredients_tapa_ID_ingredient FOREIGN KEY (id_ingredient) REFERENCES ingredient (id_ingredient) ON UPDATE CASCADE ON DELETE CASCADE, 
  CONSTRAINT FK_ingredients_tapa_ID_tapa FOREIGN KEY (id_tapa) REFERENCES tapa (id_tapa) ON UPDATE CASCADE ON DELETE CASCADE
) ; 

DROP TABLE IF EXISTS Carta_tapes;

CREATE TABLE IF NOT EXISTS carta_tapes(
id_tapa int not null,
id_bar int unsigned ,
Cost int check (cost>=0),
PVP FLOAT(5,2) check (PVP>=0),
CONSTRAINT PK1_carta_tapes PRIMARY KEY (id_tapa, id_bar),
CONSTRAINT FK1_id_tapa FOREIGN KEY (id_tapa) REFERENCES Tapa(id_tapa) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT FK2_id_bar FOREIGN KEY (id_bar) REFERENCES Bar(id_bar) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS comanda_tapes;

CREATE TABLE IF NOT EXISTS comanda_tapes(
id_Tapa int not null ,
id_Bar int unsigned not null  ,
id_client_taula int not null check (id_client_taula>=0),
data_client_taula datetime,
quantitat int check (quantitat>=0),
CONSTRAINT PK1_comanda_tapes PRIMARY KEY (id_tapa, id_bar, id_client_taula),
CONSTRAINT FK1_comanda_tapes_carta_tapes FOREIGN KEY (id_Bar, id_tapa) REFERENCES Carta_Tapes(id_bar, id_tapa) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT FK2_id_client_taula FOREIGN KEY (id_client_taula) REFERENCES client_Taula(id_client_taula) ON UPDATE CASCADE ON DELETE CASCADE
);

DROP TABLE IF EXISTS Carta_Begudes;

CREATE TABLE IF NOT EXISTS Carta_Begudes(
id_Beguda int(10) not null,
id_bar int UNSIGNED,
cost int check (cost>=0),
PVP int check (PVP>=0),
CONSTRAINT PK1_carta_begudes PRIMARY KEY (id_Beguda, id_bar),
CONSTRAINT FK1_carta_beguda_beguda FOREIGN KEY (id_Beguda) REFERENCES Beguda(id_Beguda) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT FK2_carta_beguda_bar FOREIGN KEY (id_bar) REFERENCES Bar(Id_bar) ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS Comanda_Begudes(
id_beguda int(10) not null,
id_bar int unsigned,
id_client_taula int check (id_client_taula>=0),
data_hora_comanda datetime,
quantitat FLOAT(5,2) check (quantitat>=0),
CONSTRAINT PK1_id_beguda PRIMARY KEY (id_beguda, id_bar, id_client_taula),
CONSTRAINT FK1_comanda_begudes_carta_begudes FOREIGN KEY (id_beguda, id_bar) REFERENCES Carta_begudes(id_beguda, id_bar) ON UPDATE CASCADE ON DELETE CASCADE,
CONSTRAINT FK2_comanda_begudes_client_taula FOREIGN KEY (id_client_taula) REFERENCES Client_taula(id_client_taula) ON UPDATE CASCADE ON DELETE CASCADE
);

