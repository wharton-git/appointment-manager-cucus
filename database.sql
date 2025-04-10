-- Création de la base de données (optionnel)
CREATE DATABASE IF NOT EXISTS cucus;

USE cucus;

-- Table medecin
CREATE TABLE `medecin` (
    `codemed` varchar(50) NOT NULL,
    `nom` varchar(100) NOT NULL,
    `prenom` varchar(100) NOT NULL,
    `grade` varchar(50) DEFAULT NULL,
    PRIMARY KEY (`codemed`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
-- Table patient
CREATE TABLE `patient` (
    `codepat` int NOT NULL AUTO_INCREMENT,
    `nom` varchar(100) NOT NULL,
    `prenom` varchar(100) NOT NULL,
    `sexe` char(1) DEFAULT NULL,
    `adresse` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`codepat`)
) ENGINE = InnoDB AUTO_INCREMENT = 2 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
-- Table visiter
CREATE TABLE `visiter` (
    `codevis` int NOT NULL AUTO_INCREMENT,
    `codemed` varchar(50) DEFAULT NULL,
    `codepat` int DEFAULT NULL,
    `date` date DEFAULT NULL,
    PRIMARY KEY (`codevis`),
    KEY `codemed` (`codemed`),
    KEY `codepat` (`codepat`),
    CONSTRAINT `visiter_ibfk_1` FOREIGN KEY (`codemed`) REFERENCES `medecin` (`codemed`),
    CONSTRAINT `visiter_ibfk_2` FOREIGN KEY (`codepat`) REFERENCES `patient` (`codepat`)
) ENGINE = InnoDB AUTO_INCREMENT = 10 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;