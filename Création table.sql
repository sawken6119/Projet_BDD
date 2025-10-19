
use sawadogo;
-- ============================================================
-- TABLE : MAGAZINE
-- ============================================================
-- Cette table stocke les informations relatives aux magazines
-- de prépublication (ex : Weekly Shonen Jump).
CREATE TABLE Magazine(
   ID_Magazine VARCHAR(50),                        -- Identifiant unique du magazine
   Titre_Magazine VARCHAR(50),                     -- Nom du magazine
   Periodicité_Magazine DATE,                      -- Fréquence de publication (date de référence)
   TirageMoyen_Magazine VARCHAR(50),               -- Tirage moyen du magazine
   PRIMARY KEY(ID_Magazine)                        -- Définition de la clé primaire
);

-- ============================================================
-- TABLE : MAISON D'ÉDITION
-- ============================================================
-- Représente les maisons d’édition responsables de la publication.
CREATE TABLE Maison_Edition(
   ID_Maison_Edition VARCHAR(50),                  -- Identifiant unique
   Adresse_Maison_Edition VARCHAR(50),             -- Adresse complète
   Nom_Maison_Edition VARCHAR(50),                 -- Nom de la maison d'édition
   PRIMARY KEY(ID_Maison_Edition)                  -- Clé primaire
);

-- ============================================================
-- TABLE : MANGA
-- ============================================================
-- Stocke les séries de mangas (ex : Naruto, One Piece...).
CREATE TABLE Manga(
   ID_Manga VARCHAR(50),                           -- Identifiant unique du manga
   Titre_Original_Manga VARCHAR(50),               -- Titre original (souvent japonais)
   Titre_Traduit_Manga VARCHAR(50),                -- Titre traduit (ex : français)
   Catégorie VARCHAR(50),                          -- Catégorie (shōnen, seinen, etc.)
   Statut VARCHAR(50),                             -- Statut (En cours, Terminé, En pause)
   DateCréation_Manga DATE,                        -- Date de création de l'œuvre
   ID_Maison_Edition VARCHAR(50) NOT NULL,         -- Référence à la maison d’édition
   PRIMARY KEY(ID_Manga),                          -- Clé primaire
   FOREIGN KEY(ID_Maison_Edition) REFERENCES Maison_Edition(ID_Maison_Edition)
);

-- ============================================================
-- TABLE : VOLUME
-- ============================================================
-- Contient les informations sur les volumes physiques d’un manga.
CREATE TABLE Volume(
   ISBN INT,                                       -- Numéro ISBN unique
   Numéro_Volume INT,                              -- Numéro du volume dans la série
   DateSortie_Volume DATE,                         -- Date de sortie officielle
   Prix_Volume INT,                                -- Prix du volume (en euros)
   TirageInitial_Volume INT,                       -- Nombre d’exemplaires imprimés au lancement
   ISBN_1 INT NOT NULL,                            -- Référence vers le volume précédent (optionnel)
   ID_Manga VARCHAR(50) NOT NULL,                  -- Référence vers le manga
   PRIMARY KEY(ISBN),                              -- Clé primaire
   FOREIGN KEY(ISBN_1) REFERENCES Volume(ISBN),    -- Auto-référence (volume précédent)
   FOREIGN KEY(ID_Manga) REFERENCES Manga(ID_Manga)
);

-- ============================================================
-- TABLE : CHAPITRE
-- ============================================================
-- Représente chaque chapitre individuel appartenant à un volume.
CREATE TABLE Chapitre(
   ISBN INT,                                       -- Référence au volume
   ID_Chapitre VARCHAR(50),                        -- Identifiant unique du chapitre
   Titre_Chapitre VARCHAR(50),                     -- Titre du chapitre
   Numéro_Chapitre INT,                            -- Numéro du chapitre
   NbPage_Chapitre INT,                            -- Nombre de pages
   DateParution_Chapitre VARCHAR(50),              -- Date de parution
   PRIMARY KEY(ISBN, ID_Chapitre),                 -- Clé composée (Volume + Chapitre)
   FOREIGN KEY(ISBN) REFERENCES Volume(ISBN)       -- Référence vers le volume parent
);

-- ===========================================================
-- TABLE : MANGAKA
-- ============================================================
-- Contient les informations sur les auteurs (scénaristes, dessinateurs...).
CREATE TABLE Mangaka(
   ID_Mangaka VARCHAR(50),                         -- Identifiant unique du mangaka
   Nom_Mangaka VARCHAR(50),                        -- Nom de famille
   Prenom_Pseudo_Mangaka VARCHAR(50),              -- Prénom ou pseudonyme
   Date_Naissance DATE,                            -- Date de naissance
   Rôles VARCHAR(50),                              -- Rôle : Scénariste / Dessinateur / Auteur complet
   ID_Maison_Edition VARCHAR(50) NOT NULL,         -- Référence vers la maison d’édition
   PRIMARY KEY(ID_Mangaka),
   FOREIGN KEY(ID_Maison_Edition) REFERENCES Maison_Edition(ID_Maison_Edition)
);

-- ============================================================
-- TABLE : ÉCRIRE (Association N-N)
-- ============================================================
-- Relation entre les Mangakas et les Mangas.
-- Un manga peut être écrit par plusieurs mangakas,
-- et un mangaka peut participer à plusieurs mangas.
CREATE TABLE Écrire(
   ID_Manga VARCHAR(50),
   ID_Mangaka VARCHAR(50),
   PRIMARY KEY(ID_Manga, ID_Mangaka),
   FOREIGN KEY(ID_Manga) REFERENCES Manga(ID_Manga),
   FOREIGN KEY(ID_Mangaka) REFERENCES Mangaka(ID_Mangaka)
);

-- ============================================================
-- TABLE : VENDRE (Association N-N)
-- ============================================================
-- Relation entre les Magazines et les Mangas prépubliés.
CREATE TABLE Vendre(
   ID_Manga VARCHAR(50),
   ID_Magazine VARCHAR(50),
   PRIMARY KEY(ID_Manga, ID_Magazine),
   FOREIGN KEY(ID_Manga) REFERENCES Manga(ID_Manga),
   FOREIGN KEY(ID_Magazine) REFERENCES Magazine(ID_Magazine)
);

-- ============================================================
-- FIN DU SCRIPT DE CRÉATION
-- ============================================================