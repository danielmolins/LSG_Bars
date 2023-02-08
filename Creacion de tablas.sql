
CREATE DATABASE PruebaPractica;
USE PruebaPractica;
 
CREATE TABLE carrec_empleat(
Nom_Carrec VARCHAR(30),
Primary key (Nom_Carrec),
Descripcio char(100),
HoresContracte int (3) UNSIGNED,
Sou_base DECIMAL(5,2)
);

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


CREATE TABLE taula( 
Numero_taula int,
Id_Bar int unsigned,
PRIMARY KEY (Numero_taula, Id_Bar),
Es_exterior boolean,
Es_fumador boolean,
Num_cadires int (10) UNSIGNED,
CONSTRAINT FK_taula_idBar FOREIGN KEY (Id_Bar) REFERENCES bar(Id_Bar) ON DELETE CASCADE ON UPDATE CASCADE
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








