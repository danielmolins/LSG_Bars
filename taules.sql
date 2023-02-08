DROP DATABASE IF EXISTS LSG_Bars;
CREATE DATABASE LSG_Bars;
USE LSG_Bars;
SET AUTOCOMMIT=0;

DROP TABLE IF EXISTS tapa;
/*!40101 SET character_set_client = utf8 */;
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