use sawadogo;

-- 1. Les titres de manga doivent être uniques
ALTER TABLE Manga
ADD CONSTRAINT uc_titre_original UNIQUE (Titre_Origianl_Manga);

-- 2. Le prix d’un volume doit être positif
ALTER TABLE Volume
ADD CONSTRAINT chk_prix_positif CHECK (Prix_Volume > 0);

-- 3. Le numéro de volume doit être supérieur à 0
ALTER TABLE Volume
ADD CONSTRAINT chk_numero_volume CHECK (Numéro_Volume > 0);

-- 4. La date de sortie d’un volume ne peut pas être antérieure à la date de création du manga
ALTER TABLE Volume ADD DateCreation_manga Date;
ALTER TABLE Volume ADD CONSTRAINT chk_dateSortie CHECK ( DateSortie_volume >= DateCreation_manga);

-- 5. Le nombre de pages d’un chapitre doit être positif
ALTER TABLE Chapitre
ADD CONSTRAINT chk_pages_chapitre CHECK (NbPage_Chapitre > 0);

-- 6. Le numéro de chapitre doit être supérieur à 0
ALTER TABLE Chapitre
ADD CONSTRAINT chk_numero_chapitre CHECK (Numero_Chapitre > 0);

-- 7. La date de parution d’un chapitre doit être postérieure à la création du manga
ALTER TABLE Chapitre
ADD CONSTRAINT chk_date_chapitre
CHECK (DateParution_Chapitre >= '1950-01-01');

-- 8. Un mangaka ne peut pas avoir une date de naissance future
ALTER TABLE Mangaka
ADD CONSTRAINT chk_naissance_valide CHECK (Date_Naissance <= '2026-01-01');

-- 9. La périodicité d’un magazine doit être supérieure à 0 (nombre de jours)
ALTER TABLE Magazine
ADD CONSTRAINT chk_periodicite_mag CHECK (Periodicité_Magazine > 0);

-- 10. Le tirage moyen d’un magazine doit être positif marche pas
ALTER TABLE Magazine
ADD CONSTRAINT chk_tirage_mag CHECK (TirageMoyen_Magazine > 0);

-- 11. Le tirage initial d’un volume doit être supérieur à 0
ALTER TABLE Volume
ADD CONSTRAINT chk_tirage_initial CHECK (TirageInitial_Volume > 0);

-- 12. Une maison d’édition doit avoir un nom unique
ALTER TABLE Maison_Edition
ADD CONSTRAINT uq_nom_maison UNIQUE (Nom_Maison_Edition);

-- 13. Les rôles d’un mangaka doivent être limités à certains choix (scénariste, dessinateur, auteur complet)  
ALTER TABLE Mangaka
ADD CONSTRAINT chk_role_mangaka CHECK (Rôles IN ('Scénariste', 'Dessinateur', 'Auteur complet'));

-- 14. Le statut d’un manga doit appartenir à un ensemble défini
ALTER TABLE Manga
ADD CONSTRAINT chk_statut_manga CHECK (Statut IN ('En cours', 'Terminé', 'En pause'));

-- 15. La catégorie d’un manga doit être cohérente
ALTER TABLE Manga
ADD CONSTRAINT chk_categorie_manga CHECK (Catégorie IN ('Shonen', 'Shojo', 'Seinen', 'Josei', 'Kodomo'));

-- 16. Une vente doit concerner au moins un volume existant marche pas 
ALTER TABLE Vente
ADD CONSTRAINT fk_vente_volume FOREIGN KEY (ISBN) REFERENCES Volume(ISBN);

ALTER TABLE `Mangaka`
DROP CHECK `chk_role_mangaka`;
ALTER TABLE Mangaka
ADD CONSTRAINT chk_role_mangaka
CHECK (Rôles IN ('Scénariste', 'Dessinateur', 'Auteur complet'));

ALTER TABLE `Mangaka`
DROP CHECK `chk_role_mangaka`;
ALTER TABLE Mangaka
ADD CONSTRAINT chk_role_mangaka
CHECK (Rôles IN ('Scénariste', 'Dessinateur', 'Auteur'));
