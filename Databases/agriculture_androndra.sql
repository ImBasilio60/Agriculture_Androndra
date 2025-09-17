-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jun 29, 2025 at 01:32 PM
-- Server version: 9.1.0
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `agriculture_androndra`
--
CREATE DATABASE IF NOT EXISTS `agriculture_androndra` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `agriculture_androndra`;

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `add_culture`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_culture` (IN `p_nom_culture` VARCHAR(50), IN `p_variete_culture` VARCHAR(50), IN `p_cycle_culture` INT, IN `p_saisonnalite_culture` VARCHAR(30))   BEGIN
    INSERT INTO Culture (nom_culture, variete_culture, cycle_culture, saisonnalite_culture)
    VALUES (p_nom_culture, p_variete_culture, p_cycle_culture, p_saisonnalite_culture);
END$$

DROP PROCEDURE IF EXISTS `add_intrant`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_intrant` (IN `p_nom_intrant` VARCHAR(50), IN `p_quantite_utilisee` DECIMAL(10,2), IN `p_provenance_intrant` VARCHAR(100), IN `p_date_application` DATE, IN `p_cout_intrant` DECIMAL(10,2), IN `p_ID_unite` INT, IN `p_ID_type_intrant` INT, IN `p_ID_plantation` INT)   BEGIN
    INSERT INTO intrant (nom_intrant, quantite_utilisee, provenance_intrant, date_application, cout_intrant, ID_unite, ID_type_intrant, ID_plantation)
    VALUES (p_nom_intrant, p_quantite_utilisee, p_provenance_intrant, p_date_application, p_cout_intrant, p_ID_unite, p_ID_type_intrant, p_ID_plantation);
END$$

DROP PROCEDURE IF EXISTS `add_localisation`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_localisation` (IN `p_localisation_terrain` VARCHAR(100))   BEGIN
    INSERT INTO localisation (localisation_terrain)
    VALUES (p_localisation_terrain);
END$$

DROP PROCEDURE IF EXISTS `add_parcelle`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_parcelle` (IN `p_nom_parcelle` VARCHAR(50), IN `p_superficie_parcelle` DECIMAL(10,2), IN `p_disponible` TINYINT(1), IN `p_type_sol` VARCHAR(50), IN `p_ID_terrain` INT)   BEGIN
    INSERT INTO parcelle (nom_parcelle, superficie_parcelle, disponible, type_sol, ID_terrain)
    VALUES (p_nom_parcelle, p_superficie_parcelle, p_disponible, p_type_sol, p_ID_terrain);
END$$

DROP PROCEDURE IF EXISTS `add_plantation`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_plantation` (IN `p_date_plantation_terre` DATE, IN `p_methode_culture` VARCHAR(50), IN `p_quantite_plantee` DECIMAL(10,2), IN `p_ID_unite` INT, IN `p_ID_culture` INT, IN `p_ID_parcelle` INT)   BEGIN
    INSERT INTO plantation (date_plantation_terre, methode_culture, quantite_plantee, ID_unite, ID_culture, ID_parcelle)
    VALUES (p_date_plantation_terre, p_methode_culture, p_quantite_plantee, p_ID_unite, p_ID_culture, p_ID_parcelle);
END$$

DROP PROCEDURE IF EXISTS `add_recolte`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_recolte` (IN `p_date_recolte` DATE, IN `p_quantite_recoltee` DECIMAL(10,2), IN `p_ID_unite` INT, IN `p_ID_plantation` INT, IN `p_disponible` TINYINT(1))   BEGIN
    DECLARE v_parcelle_id INT;

    INSERT INTO recolte (date_recolte, quantite_recoltee, ID_unite, ID_plantation)
    VALUES (p_date_recolte, p_quantite_recoltee, p_ID_unite, p_ID_plantation);

    SELECT ID_parcelle INTO v_parcelle_id
    FROM plantation
    WHERE ID_plantation = p_ID_plantation;

    UPDATE parcelle
    SET disponible = p_disponible
    WHERE ID_parcelle = v_parcelle_id;
END$$

DROP PROCEDURE IF EXISTS `add_suivi`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_suivi` (IN `p_date_suivi` DATE, IN `p_details_suivi` VARCHAR(2000), IN `p_ID_plantation` INT, IN `p_ID_type_suivi` INT)   BEGIN
    INSERT INTO suivi (date_suivi, details_suivi, ID_plantation, ID_type_suivi)
    VALUES (p_date_suivi, p_details_suivi, p_ID_plantation, p_ID_type_suivi);
END$$

DROP PROCEDURE IF EXISTS `add_terrain`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_terrain` (IN `p_nom_terrain` VARCHAR(50), IN `p_ID_localisation` INT)   BEGIN
    INSERT INTO terrain (nom_terrain, ID_localisation)
    VALUES (p_nom_terrain, p_ID_localisation);
END$$

DROP PROCEDURE IF EXISTS `add_type_intrant`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_type_intrant` (IN `p_type_intrant` VARCHAR(30))   BEGIN
    INSERT INTO type_intrant (type_intrant)
    VALUES (p_type_intrant);
END$$

DROP PROCEDURE IF EXISTS `add_type_suivi`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_type_suivi` (IN `p_type_suivi` VARCHAR(30))   BEGIN
    INSERT INTO type_suivi (type_suivi)
    VALUES (p_type_suivi);
END$$

DROP PROCEDURE IF EXISTS `add_unite`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_unite` (IN `p_unite` VARCHAR(20))   BEGIN
    INSERT INTO unite (unite)
    VALUES (p_unite);
END$$

DROP PROCEDURE IF EXISTS `command_man`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `command_man` ()   BEGIN
    SELECT 
        SPECIFIC_NAME AS nom_procédure
    FROM 
        information_schema.ROUTINES
    WHERE 
        ROUTINE_TYPE   = 'PROCEDURE'
        AND ROUTINE_SCHEMA = 'agriculture_androndra';
END$$

DROP PROCEDURE IF EXISTS `del_culture`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `del_culture` (IN `p_ID_culture` INT)   BEGIN
    UPDATE culture
    SET culture_supprime = 1
    WHERE ID_culture = p_ID_culture;

    INSERT INTO corbeille (nom_table, ID_enregistrement)
    VALUES ('culture', p_ID_culture);
END$$

DROP PROCEDURE IF EXISTS `del_intrant`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `del_intrant` (IN `p_ID_intrant` INT)   BEGIN
    UPDATE intrant
    SET intrant_supprime = 1
    WHERE ID_intrant = p_ID_intrant;

    INSERT INTO corbeille (nom_table, ID_enregistrement)
    VALUES ('intrant', p_ID_intrant);
END$$

DROP PROCEDURE IF EXISTS `del_parcelle`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `del_parcelle` (IN `p_ID_parcelle` INT)   BEGIN
    UPDATE parcelle
    SET parcelle_supprime = 1
    WHERE ID_parcelle = p_ID_parcelle;

    INSERT INTO corbeille (nom_table, ID_enregistrement)
    VALUES ('parcelle', p_ID_parcelle);
END$$

DROP PROCEDURE IF EXISTS `del_plantation`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `del_plantation` (IN `p_ID_plantation` INT)   BEGIN
    UPDATE plantation
    SET plantation_supprime = 1
    WHERE ID_plantation = p_ID_plantation;

    INSERT INTO corbeille (nom_table, ID_enregistrement)
    VALUES ('plantation', p_ID_plantation);
END$$

DROP PROCEDURE IF EXISTS `del_recolte`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `del_recolte` (IN `p_ID_recolte` INT)   BEGIN
    UPDATE recolte
    SET recolte_supprime = 1
    WHERE ID_recolte = p_ID_recolte;

    INSERT INTO corbeille (nom_table, ID_enregistrement)
    VALUES ('recolte', p_ID_recolte);
END$$

DROP PROCEDURE IF EXISTS `del_suivi`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `del_suivi` (IN `p_ID_suivi` INT)   BEGIN
    UPDATE suivi
    SET suivi_supprime = 1
    WHERE ID_suivi = p_ID_suivi;

    INSERT INTO corbeille (nom_table, ID_enregistrement)
    VALUES ('suivi', p_ID_suivi);
END$$

DROP PROCEDURE IF EXISTS `del_terrain`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `del_terrain` (IN `p_ID_terrain` INT)   BEGIN
    UPDATE terrain
    SET terrain_supprime = 1
    WHERE ID_terrain = p_ID_terrain;

    INSERT INTO corbeille (nom_table, ID_enregistrement)
    VALUES ('terrain', p_ID_terrain);
END$$

DROP PROCEDURE IF EXISTS `filter_corbeille`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `filter_corbeille` (IN `p_nom_table` VARCHAR(50), IN `p_ID_enregistrement` INT)   BEGIN
    SELECT * 
    FROM v_corbeille_detaillee
    WHERE 
        (p_nom_table IS NULL OR nom_table = p_nom_table)
      AND 
        (p_ID_enregistrement IS NULL OR ID_enregistrement = p_ID_enregistrement)
    ORDER BY date_suppression DESC;
END$$

DROP PROCEDURE IF EXISTS `parcelle_disponible`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `parcelle_disponible` ()   BEGIN
    SELECT
        ID_parcelle,
        nom_parcelle,
        superficie_parcelle,
        type_sol,
        'Disponible' AS statut_disponibilite
    FROM parcelle
    WHERE parcelle_supprime = 0
      AND disponible = 1
    ORDER BY nom_parcelle;
END$$

DROP PROCEDURE IF EXISTS `parcelle_disponible_by_terrain`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `parcelle_disponible_by_terrain` (IN `p_ID_terrain` INT)   BEGIN
    SELECT
        ID_parcelle,
        nom_parcelle,
        superficie_parcelle,
        type_sol,
        'Disponible' AS statut_disponibilite
    FROM parcelle
    WHERE parcelle_supprime = 0
      AND disponible = 1
      AND ID_terrain = p_ID_terrain
    ORDER BY nom_parcelle;
END$$

DROP PROCEDURE IF EXISTS `read_intrant`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `read_intrant` ()   BEGIN
    SELECT
        i.ID_intrant,
        i.nom_intrant,
        c.nom_culture,
        i.provenance_intrant,
        t.type_intrant,
        i.date_application,
        i.quantite_utilisee,
        u.unite                
    FROM intrant AS i
    JOIN unite AS u ON i.ID_unite = u.ID_unite
    JOIN type_intrant AS t ON i.ID_type_intrant = t.ID_type_intrant
    JOIN plantation AS p ON i.ID_plantation = p.ID_plantation
    JOIN culture AS c ON p.ID_culture = c.ID_culture
    ORDER BY i.nom_intrant;
END$$

DROP PROCEDURE IF EXISTS `read_parcelle`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `read_parcelle` ()   BEGIN
    SELECT
        p.ID_parcelle,
        p.nom_parcelle,
        p.superficie_parcelle,
        p.type_sol,
        t.nom_terrain,
        CASE 
            WHEN p.disponible = 1 THEN 'Oui'
            ELSE 'Non'
        END AS disponible
    FROM terrain AS t
    JOIN localisation AS l ON t.ID_localisation = l.ID_localisation
    JOIN parcelle AS p ON p.ID_terrain = t.ID_terrain
    ORDER BY t.ID_terrain, p.ID_parcelle;
END$$

DROP PROCEDURE IF EXISTS `read_plantation`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `read_plantation` ()   BEGIN
    SELECT
        pl.ID_plantation,
        pl.date_plantation_terre,
        pl.methode_culture,
        c.nom_culture,
        pl.quantite_plantee,
        u.unite,
        p.nom_parcelle
    FROM plantation AS pl
    JOIN culture   AS c ON pl.ID_culture  = c.ID_culture
    JOIN unite     AS u ON pl.ID_unite    = u.ID_unite
    JOIN parcelle  AS p ON pl.ID_parcelle = p.ID_parcelle
    WHERE pl.plantation_supprime = 0
      AND c.culture_supprime    = 0
      AND p.parcelle_supprime   = 0
    ORDER BY pl.ID_plantation;
END$$

DROP PROCEDURE IF EXISTS `read_recolte`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `read_recolte` ()   BEGIN
    SELECT
        r.ID_recolte,
        r.date_recolte,
        p.ID_plantation,
        c.nom_culture,
        r.quantite_recoltee,
        u.unite                
    FROM recolte AS r
    JOIN unite AS u ON r.ID_unite = u.ID_unite
    JOIN plantation AS p ON r.ID_plantation = p.ID_plantation
    JOIN culture AS c ON p.ID_culture = c.ID_culture
    ORDER BY r.date_recolte DESC;
END$$

DROP PROCEDURE IF EXISTS `read_terrain`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `read_terrain` ()   BEGIN
    SELECT
        t.ID_terrain,
        t.nom_terrain,
        l.localisation_terrain AS localisation
    FROM terrain AS t
    JOIN localisation AS l ON t.ID_localisation = l.ID_localisation
    ORDER BY t.ID_terrain;
END$$

DROP PROCEDURE IF EXISTS `restore_all`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `restore_all` ()   BEGIN
    DECLARE v_nom_table VARCHAR(50);
    DECLARE v_ID_enregistrement INT;
    DECLARE done INT DEFAULT 0;

    DECLARE cur CURSOR FOR 
        SELECT nom_table, ID_enregistrement FROM corbeille;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO v_nom_table, v_ID_enregistrement;
        IF done THEN
            LEAVE read_loop;
        END IF;

        CASE v_nom_table
            WHEN 'culture' THEN
                UPDATE culture SET culture_supprime = 0 WHERE ID_culture = v_ID_enregistrement;
            WHEN 'intrant' THEN
                UPDATE intrant SET intrant_supprime = 0 WHERE ID_intrant = v_ID_enregistrement;
            WHEN 'parcelle' THEN
                UPDATE parcelle SET parcelle_supprime = 0 WHERE ID_parcelle = v_ID_enregistrement;
            WHEN 'plantation' THEN
                UPDATE plantation SET plantation_supprime = 0 WHERE ID_plantation = v_ID_enregistrement;
            WHEN 'recolte' THEN
                UPDATE recolte SET recolte_supprime = 0 WHERE ID_recolte = v_ID_enregistrement;
            WHEN 'suivi' THEN
                UPDATE suivi SET suivi_supprime = 0 WHERE ID_suivi = v_ID_enregistrement;
            WHEN 'terrain' THEN
                UPDATE terrain SET terrain_supprime = 0 WHERE ID_terrain = v_ID_enregistrement;
        END CASE;

        DELETE FROM corbeille
        WHERE nom_table = v_nom_table AND ID_enregistrement = v_ID_enregistrement;

    END LOOP;

    CLOSE cur;
END$$

DROP PROCEDURE IF EXISTS `restore_culture`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `restore_culture` (IN `p_ID_culture` INT)   BEGIN
    UPDATE culture
    SET culture_supprime = 0
    WHERE ID_culture = p_ID_culture;

    DELETE FROM corbeille
    WHERE nom_table = 'culture' AND ID_enregistrement = p_ID_culture;
END$$

DROP PROCEDURE IF EXISTS `restore_intrant`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `restore_intrant` (IN `p_ID_intrant` INT)   BEGIN
    UPDATE intrant
    SET intrant_supprime = 0
    WHERE ID_intrant = p_ID_intrant;

    DELETE FROM corbeille
    WHERE nom_table = 'intrant' AND ID_enregistrement = p_ID_intrant;
END$$

DROP PROCEDURE IF EXISTS `restore_parcelle`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `restore_parcelle` (IN `p_ID_parcelle` INT)   BEGIN
    UPDATE parcelle
    SET parcelle_supprime = 0
    WHERE ID_parcelle = p_ID_parcelle;

    DELETE FROM corbeille
    WHERE nom_table = 'parcelle' AND ID_enregistrement = p_ID_parcelle;
END$$

DROP PROCEDURE IF EXISTS `restore_plantation`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `restore_plantation` (IN `p_ID_plantation` INT)   BEGIN
    UPDATE plantation
    SET plantation_supprime = 0
    WHERE ID_plantation = p_ID_plantation;

    DELETE FROM corbeille
    WHERE nom_table = 'plantation' AND ID_enregistrement = p_ID_plantation;
END$$

DROP PROCEDURE IF EXISTS `restore_recolte`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `restore_recolte` (IN `p_ID_recolte` INT)   BEGIN
    UPDATE recolte
    SET recolte_supprime = 0
    WHERE ID_recolte = p_ID_recolte;

    DELETE FROM corbeille
    WHERE nom_table = 'recolte' AND ID_enregistrement = p_ID_recolte;
END$$

DROP PROCEDURE IF EXISTS `restore_suivi`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `restore_suivi` (IN `p_ID_suivi` INT)   BEGIN
    UPDATE suivi
    SET suivi_supprime = 0
    WHERE ID_suivi = p_ID_suivi;

    DELETE FROM corbeille
    WHERE nom_table = 'suivi' AND ID_enregistrement = p_ID_suivi;
END$$

DROP PROCEDURE IF EXISTS `restore_terrain`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `restore_terrain` (IN `p_ID_terrain` INT)   BEGIN
    UPDATE terrain
    SET terrain_supprime = 0
    WHERE ID_terrain = p_ID_terrain;

    DELETE FROM corbeille
    WHERE nom_table = 'terrain' AND ID_enregistrement = p_ID_terrain;
END$$

DROP PROCEDURE IF EXISTS `what_args`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `what_args` (IN `p_proc_name` VARCHAR(64))   BEGIN
    SELECT 
        PARAMETER_NAME   AS nom_parametre,
        DATA_TYPE        AS type_donnees,
        PARAMETER_MODE   AS mode_parametre
    FROM 
        information_schema.PARAMETERS
    WHERE 
        SPECIFIC_NAME   = p_proc_name
        AND SPECIFIC_SCHEMA = 'agriculture_androndra'
    ORDER BY 
        ORDINAL_POSITION;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `corbeille`
--

DROP TABLE IF EXISTS `corbeille`;
CREATE TABLE IF NOT EXISTS `corbeille` (
  `ID_corbeille` int NOT NULL AUTO_INCREMENT,
  `nom_table` varchar(50) NOT NULL,
  `ID_enregistrement` int NOT NULL,
  `date_suppression` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_corbeille`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `culture`
--

DROP TABLE IF EXISTS `culture`;
CREATE TABLE IF NOT EXISTS `culture` (
  `ID_culture` int NOT NULL AUTO_INCREMENT,
  `nom_culture` varchar(50) NOT NULL,
  `variete_culture` varchar(50) NOT NULL,
  `cycle_culture` int DEFAULT NULL,
  `saisonnalite_culture` varchar(30) DEFAULT NULL,
  `culture_supprime` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID_culture`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `intrant`
--

DROP TABLE IF EXISTS `intrant`;
CREATE TABLE IF NOT EXISTS `intrant` (
  `ID_intrant` int NOT NULL AUTO_INCREMENT,
  `nom_intrant` varchar(50) NOT NULL,
  `quantite_utilisee` decimal(10,2) NOT NULL,
  `provenance_intrant` varchar(100) DEFAULT NULL,
  `date_application` date NOT NULL,
  `cout_intrant` decimal(10,2) NOT NULL,
  `intrant_supprime` tinyint(1) NOT NULL DEFAULT '0',
  `ID_unite` int NOT NULL,
  `ID_type_intrant` int NOT NULL,
  `ID_plantation` int NOT NULL,
  PRIMARY KEY (`ID_intrant`),
  KEY `fk_intrant_unite` (`ID_unite`),
  KEY `fk_intrant_type` (`ID_type_intrant`),
  KEY `fk_intrant_plantation` (`ID_plantation`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `localisation`
--

DROP TABLE IF EXISTS `localisation`;
CREATE TABLE IF NOT EXISTS `localisation` (
  `ID_localisation` int NOT NULL AUTO_INCREMENT,
  `localisation_terrain` varchar(100) NOT NULL,
  PRIMARY KEY (`ID_localisation`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `parcelle`
--

DROP TABLE IF EXISTS `parcelle`;
CREATE TABLE IF NOT EXISTS `parcelle` (
  `ID_parcelle` int NOT NULL AUTO_INCREMENT,
  `nom_parcelle` varchar(50) NOT NULL,
  `superficie_parcelle` decimal(10,2) NOT NULL,
  `type_sol` varchar(50) DEFAULT NULL,
  `ID_terrain` int NOT NULL,
  `disponible` tinyint(1) NOT NULL DEFAULT '1',
  `parcelle_supprime` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID_parcelle`),
  KEY `fk_parcelle_terrain` (`ID_terrain`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `plantation`
--

DROP TABLE IF EXISTS `plantation`;
CREATE TABLE IF NOT EXISTS `plantation` (
  `ID_plantation` int NOT NULL AUTO_INCREMENT,
  `date_plantation_terre` date NOT NULL,
  `methode_culture` varchar(50) DEFAULT NULL,
  `quantite_plantee` decimal(10,2) NOT NULL,
  `plantation_supprime` tinyint(1) NOT NULL DEFAULT '0',
  `ID_unite` int NOT NULL,
  `ID_culture` int NOT NULL,
  `ID_parcelle` int NOT NULL,
  PRIMARY KEY (`ID_plantation`),
  KEY `fk_plantation_unite` (`ID_unite`),
  KEY `fk_plantation_culture` (`ID_culture`),
  KEY `fk_plantation_parcelle` (`ID_parcelle`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `recolte`
--

DROP TABLE IF EXISTS `recolte`;
CREATE TABLE IF NOT EXISTS `recolte` (
  `ID_recolte` int NOT NULL AUTO_INCREMENT,
  `date_recolte` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `quantite_recoltee` decimal(10,2) NOT NULL,
  `recolte_supprime` tinyint(1) NOT NULL DEFAULT '0',
  `ID_unite` int NOT NULL,
  `ID_plantation` int NOT NULL,
  PRIMARY KEY (`ID_recolte`),
  KEY `fk_recolte_unite` (`ID_unite`),
  KEY `fk_recolte_plantation` (`ID_plantation`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `suivi`
--

DROP TABLE IF EXISTS `suivi`;
CREATE TABLE IF NOT EXISTS `suivi` (
  `ID_suivi` int NOT NULL AUTO_INCREMENT,
  `date_suivi` date NOT NULL,
  `details_suivi` varchar(2000) DEFAULT NULL,
  `suivi_supprime` tinyint(1) NOT NULL DEFAULT '0',
  `ID_plantation` int NOT NULL,
  `ID_type_suivi` int NOT NULL,
  PRIMARY KEY (`ID_suivi`),
  KEY `fk_suivi_plantation` (`ID_plantation`),
  KEY `fk_suivi_type` (`ID_type_suivi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `terrain`
--

DROP TABLE IF EXISTS `terrain`;
CREATE TABLE IF NOT EXISTS `terrain` (
  `ID_terrain` int NOT NULL AUTO_INCREMENT,
  `nom_terrain` varchar(50) NOT NULL,
  `terrain_supprime` tinyint(1) NOT NULL DEFAULT '0',
  `ID_localisation` int NOT NULL,
  PRIMARY KEY (`ID_terrain`),
  KEY `fk_terrain_localisation` (`ID_localisation`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `type_intrant`
--

DROP TABLE IF EXISTS `type_intrant`;
CREATE TABLE IF NOT EXISTS `type_intrant` (
  `ID_type_intrant` int NOT NULL AUTO_INCREMENT,
  `type_intrant` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`ID_type_intrant`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `type_suivi`
--

DROP TABLE IF EXISTS `type_suivi`;
CREATE TABLE IF NOT EXISTS `type_suivi` (
  `ID_type_suivi` int NOT NULL AUTO_INCREMENT,
  `type_suivi` varchar(30) NOT NULL,
  PRIMARY KEY (`ID_type_suivi`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `unite`
--

DROP TABLE IF EXISTS `unite`;
CREATE TABLE IF NOT EXISTS `unite` (
  `ID_unite` int NOT NULL AUTO_INCREMENT,
  `unite` varchar(20) NOT NULL,
  PRIMARY KEY (`ID_unite`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_corbeille_detaillee`
-- (See below for the actual view)
--
DROP VIEW IF EXISTS `v_corbeille_detaillee`;
CREATE TABLE IF NOT EXISTS `v_corbeille_detaillee` (
`date_suppression` timestamp
,`ID_corbeille` int
,`ID_enregistrement` int
,`nom_objet` text
,`nom_table` varchar(50)
);

-- --------------------------------------------------------

--
-- Structure for view `v_corbeille_detaillee`
--
DROP TABLE IF EXISTS `v_corbeille_detaillee`;

DROP VIEW IF EXISTS `v_corbeille_detaillee`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_corbeille_detaillee`  AS SELECT `c`.`ID_corbeille` AS `ID_corbeille`, `c`.`nom_table` AS `nom_table`, `c`.`ID_enregistrement` AS `ID_enregistrement`, `cu`.`nom_culture` AS `nom_objet`, `c`.`date_suppression` AS `date_suppression` FROM (`corbeille` `c` join `culture` `cu` on(((`c`.`nom_table` = 'culture') and (`c`.`ID_enregistrement` = `cu`.`ID_culture`))))union select `c`.`ID_corbeille` AS `ID_corbeille`,`c`.`nom_table` AS `nom_table`,`c`.`ID_enregistrement` AS `ID_enregistrement`,`i`.`nom_intrant` AS `nom_objet`,`c`.`date_suppression` AS `date_suppression` from (`corbeille` `c` join `intrant` `i` on(((`c`.`nom_table` = 'intrant') and (`c`.`ID_enregistrement` = `i`.`ID_intrant`)))) union select `c`.`ID_corbeille` AS `ID_corbeille`,`c`.`nom_table` AS `nom_table`,`c`.`ID_enregistrement` AS `ID_enregistrement`,`p`.`nom_parcelle` AS `nom_objet`,`c`.`date_suppression` AS `date_suppression` from (`corbeille` `c` join `parcelle` `p` on(((`c`.`nom_table` = 'parcelle') and (`c`.`ID_enregistrement` = `p`.`ID_parcelle`)))) union select `c`.`ID_corbeille` AS `ID_corbeille`,`c`.`nom_table` AS `nom_table`,`c`.`ID_enregistrement` AS `ID_enregistrement`,`pl`.`methode_culture` AS `nom_objet`,`c`.`date_suppression` AS `date_suppression` from (`corbeille` `c` join `plantation` `pl` on(((`c`.`nom_table` = 'plantation') and (`c`.`ID_enregistrement` = `pl`.`ID_plantation`)))) union select `c`.`ID_corbeille` AS `ID_corbeille`,`c`.`nom_table` AS `nom_table`,`c`.`ID_enregistrement` AS `ID_enregistrement`,`r`.`quantite_recoltee` AS `nom_objet`,`c`.`date_suppression` AS `date_suppression` from (`corbeille` `c` join `recolte` `r` on(((`c`.`nom_table` = 'recolte') and (`c`.`ID_enregistrement` = `r`.`ID_recolte`)))) union select `c`.`ID_corbeille` AS `ID_corbeille`,`c`.`nom_table` AS `nom_table`,`c`.`ID_enregistrement` AS `ID_enregistrement`,`s`.`details_suivi` AS `nom_objet`,`c`.`date_suppression` AS `date_suppression` from (`corbeille` `c` join `suivi` `s` on(((`c`.`nom_table` = 'suivi') and (`c`.`ID_enregistrement` = `s`.`ID_suivi`)))) union select `c`.`ID_corbeille` AS `ID_corbeille`,`c`.`nom_table` AS `nom_table`,`c`.`ID_enregistrement` AS `ID_enregistrement`,`t`.`nom_terrain` AS `nom_objet`,`c`.`date_suppression` AS `date_suppression` from (`corbeille` `c` join `terrain` `t` on(((`c`.`nom_table` = 'terrain') and (`c`.`ID_enregistrement` = `t`.`ID_terrain`))))  ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `intrant`
--
ALTER TABLE `intrant`
  ADD CONSTRAINT `fk_intrant_plantation` FOREIGN KEY (`ID_plantation`) REFERENCES `plantation` (`ID_plantation`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_intrant_type` FOREIGN KEY (`ID_type_intrant`) REFERENCES `type_intrant` (`ID_type_intrant`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_intrant_unite` FOREIGN KEY (`ID_unite`) REFERENCES `unite` (`ID_unite`) ON UPDATE CASCADE;

--
-- Constraints for table `parcelle`
--
ALTER TABLE `parcelle`
  ADD CONSTRAINT `fk_parcelle_terrain` FOREIGN KEY (`ID_terrain`) REFERENCES `terrain` (`ID_terrain`) ON UPDATE CASCADE;

--
-- Constraints for table `plantation`
--
ALTER TABLE `plantation`
  ADD CONSTRAINT `fk_plantation_culture` FOREIGN KEY (`ID_culture`) REFERENCES `culture` (`ID_culture`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_plantation_parcelle` FOREIGN KEY (`ID_parcelle`) REFERENCES `parcelle` (`ID_parcelle`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_plantation_unite` FOREIGN KEY (`ID_unite`) REFERENCES `unite` (`ID_unite`) ON UPDATE CASCADE;

--
-- Constraints for table `recolte`
--
ALTER TABLE `recolte`
  ADD CONSTRAINT `fk_recolte_plantation` FOREIGN KEY (`ID_plantation`) REFERENCES `plantation` (`ID_plantation`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_recolte_unite` FOREIGN KEY (`ID_unite`) REFERENCES `unite` (`ID_unite`) ON UPDATE CASCADE;

--
-- Constraints for table `suivi`
--
ALTER TABLE `suivi`
  ADD CONSTRAINT `fk_suivi_plantation` FOREIGN KEY (`ID_plantation`) REFERENCES `plantation` (`ID_plantation`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_suivi_type` FOREIGN KEY (`ID_type_suivi`) REFERENCES `type_suivi` (`ID_type_suivi`) ON UPDATE CASCADE;

--
-- Constraints for table `terrain`
--
ALTER TABLE `terrain`
  ADD CONSTRAINT `fk_terrain_localisation` FOREIGN KEY (`ID_localisation`) REFERENCES `localisation` (`ID_localisation`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
