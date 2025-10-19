USE sawadogo;

-- =======================================================
-- 1. MAISON D’ÉDITION
-- =======================================================
INSERT INTO Maison_Edition (ID_Maison_Edition, Adresse_Maison_Edition, Nom_Maison_Edition) VALUES
('ED01', 'Tokyo, Japon', 'Shueisha'),
('ED02', 'Tokyo, Japon', 'Kodansha'),
('ED03', 'Osaka, Japon', 'Shogakukan'),
('ED04', 'Paris, France', 'Kana'),
('ED05', 'Los Angeles, USA', 'Viz Media');

-- =======================================================
-- 2. MAGAZINE
-- =======================================================
INSERT INTO Magazine (ID_Magazine, Titre_Magazine, Periodicité_Magazine, TirageMoyen_Magazine) VALUES
('MAG01', 'Weekly Shonen Jump', '2025-01-01', '1500000'),
('MAG02', 'Weekly Shonen Magazine', '2025-01-01', '800000'),
('MAG03', 'Big Comic Spirits', '2025-01-01', '400000'),
('MAG04', 'Monthly Afternoon', '2025-01-01', '300000');

-- =======================================================
-- 3. MANGA
-- =======================================================
INSERT INTO Manga (ID_Manga, Titre_Origianl_Manga, Titre_Traduit_Manga, Catégorie, Statut, DateCréation_Manga, ID_Maison_Edition) VALUES
('M01', 'Naruto', 'Naruto', 'Shonen', 'Terminé', '1999-09-21', 'ED01'),
('M02', 'One Piece', 'One Piece', 'Shonen', 'En cours', '1997-07-22', 'ED01'),
('M03', 'Attack on Titan', 'L\'Attaque des Titans', 'Seinen', 'Terminé', '2009-09-09', 'ED02'),
('M04', 'Doraemon', 'Doraemon', 'Kodomo', 'Terminé', '1969-01-01', 'ED03'),
('M05', 'Death Note', 'Death Note', 'Shonen', 'Terminé', '2003-12-01', 'ED01');

-- =======================================================
-- 4. MANGAKA
-- =======================================================
INSERT INTO Mangaka (ID_Mangaka, Nom_Mangaka, Prenom_Pseudo_Mangaka, Date_Naissance, Rôles, ID_Maison_Edition) VALUES
('A01', 'Kishimoto', 'Masashi', '1974-11-08', 'Auteur', 'ED01'),
('A02', 'Oda', 'Eiichiro', '1975-01-01', 'Auteur', 'ED01'),
('A03', 'Isayama', 'Hajime', '1986-08-29', 'Auteur', 'ED02'),
('A04', 'Fujiko F.', 'Fujio', '1933-12-01', 'Auteur', 'ED03'),
('A05', 'Ohba', 'Tsugumi', '1969-08-17', 'Scénariste', 'ED01'),
('A06', 'Obata', 'Takeshi', '1969-02-11', 'Dessinateur', 'ED01');


-- =======================================================
-- 5. ÉCRIRE (relation n-n entre Manga et Mangaka)
-- =======================================================
INSERT INTO écrire (ID_Manga, ID_Mangaka) VALUES
('M01', 'A01'),
('M02', 'A02'),
('M03', 'A03'),
('M04', 'A04'),
('M05', 'A05'),
('M05', 'A06');

-- =======================================================
-- 6. VOLUME
-- =======================================================
INSERT INTO Volume (ISBN, Numéro_Volume, DateSortie_Volume, Prix_Volume, TirageInitial_Volume, ISBN_1, ID_Manga) VALUES
(1001, 1, '2000-03-03', 7, 500000, 1001, 'M01'),
(1002, 2, '2000-08-01', 7, 480000, 1001, 'M01'),
(2001, 1, '1997-12-24', 8, 1000000, 2001, 'M02'),
(3001, 1, '2010-03-17', 9, 400000, 3001, 'M03'),
(4001, 1, '1970-01-01', 5, 200000, 4001, 'M04'),
(5001, 1, '2004-04-02', 8, 600000, 5001, 'M05');

-- =======================================================
-- 7. CHAPITRE
-- =======================================================
INSERT INTO Chapitre (ISBN, ID_Chapitre, TItre_Chapitre, Numero_Chapitre, NbPage_Chapitre, DateParution_Chapitre) VALUES
(1001, 'C01', 'Uzumaki Naruto', 1, 45, '1999-09-21'),
(1001, 'C02', 'Konohamaru', 2, 42, '1999-09-28'),
(2001, 'C03', 'Romance Dawn', 1, 50, '1997-07-22'),
(3001, 'C04', 'To You, in 2000 Years', 1, 51, '2009-09-09'),
(5001, 'C05', 'Rebirth', 1, 49, '2003-12-01');

-- =======================================================
-- 8. VENDRE (relation n-n entre Manga et Magazine)
-- =======================================================
INSERT INTO vendre (ID_Manga, ID_Magazine) VALUES
('M01', 'MAG01'),
('M02', 'MAG01'),
('M03', 'MAG02'),
('M04', 'MAG03'),
('M05', 'MAG01');

