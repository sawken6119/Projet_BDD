
USE sawadogo;

/* ======================================================
   1. PROJECTIONS / SÉLECTIONS / TRI / IN / BETWEEN (≥5)
   ====================================================== */

-- 1. Mangas dont le titre contient le mot 'Note'
SELECT Titre_Traduit_Manga, Catégorie, Statut
FROM Manga
WHERE Titre_Traduit_Manga LIKE '%Note%';

-- 2. Mangas de catégorie Shonen ou Seinen
SELECT Titre_Traduit_Manga, Catégorie
FROM Manga
WHERE Catégorie IN ('Shonen', 'Seinen');

-- 3. Mangakas nés entre 1970 et 1990
SELECT Nom_Mangaka, Prenom_Pseudo_Mangaka, Date_Naissance
FROM Mangaka
WHERE Date_Naissance BETWEEN '1970-01-01' AND '1990-12-31'
ORDER BY Date_Naissance;

-- 4. Magazines avec un tirage supérieur à 500000
SELECT Titre_Magazine, TirageMoyen_Magazine
FROM Magazine
WHERE TirageMoyen_Magazine > 500000;

-- 5. Volumes publiés entre 2000 et 2010
SELECT ISBN, Numéro_Volume, DateSortie_Volume
FROM Volume
WHERE DateSortie_Volume BETWEEN '2000-01-01' AND '2010-12-31';


/* ======================================================
   2. AGRÉGATIONS / GROUP BY / HAVING (≥5)
   ====================================================== */

-- 6. Nombre de mangas par maison d’édition
SELECT ID_Maison_Edition, COUNT(*) AS Nb_Mangas
FROM Manga
GROUP BY ID_Maison_Edition;

-- 7. Moyenne des tirages initiaux par manga
SELECT ID_Manga, AVG(TirageInitial_Volume) AS Moyenne_Tirage
FROM Volume
GROUP BY ID_Manga;

-- 8. Nombre de chapitres par volume
SELECT ISBN, COUNT(*) AS Nb_Chapitres
FROM Chapitre
GROUP BY ISBN;

-- 9. Nombre de mangas par catégorie
SELECT Catégorie, COUNT(*) AS Nb_Séries
FROM Manga
GROUP BY Catégorie
HAVING COUNT(*) > 1;

-- 10. Moyenne du prix des volumes par maison d’édition
SELECT M.ID_Maison_Edition, AVG(V.Prix_Volume) AS Prix_Moyen
FROM Volume V
JOIN Manga M ON V.ID_Manga = M.ID_Manga
GROUP BY M.ID_Maison_Edition;


/* ======================================================
   3. JOINTURES (internes, externes, multiples) (≥5)
   ====================================================== */

-- 11. Liste des mangas avec leur mangaka et maison d’édition
SELECT Ma.Titre_Traduit_Manga, K.Nom_Mangaka, ME.Nom_Maison_Edition
FROM Manga Ma
JOIN écrire e ON Ma.ID_Manga = e.ID_Manga
JOIN Mangaka K ON e.ID_Mangaka = K.ID_Mangaka
JOIN Maison_Edition ME ON Ma.ID_Maison_Edition = ME.ID_Maison_Edition;

-- 12. Chapitres et volumes associés
SELECT C.TItre_Chapitre, C.Numero_Chapitre, V.Numéro_Volume, M.Titre_Traduit_Manga
FROM Chapitre C
JOIN Volume V ON C.ISBN = V.ISBN
JOIN Manga M ON V.ID_Manga = M.ID_Manga;

-- 13. Magazines liés aux mangas
SELECT Mg.Titre_Magazine, Ma.Titre_Traduit_Manga
FROM vendre V
JOIN Magazine Mg ON V.ID_Magazine = Mg.ID_Magazine
JOIN Manga Ma ON V.ID_Manga = Ma.ID_Manga;

-- 14. Mangakas et leurs éditeurs (même sans manga actif)
SELECT K.Nom_Mangaka, E.Nom_Maison_Edition
FROM Mangaka K
LEFT JOIN Maison_Edition E ON K.ID_Maison_Edition = E.ID_Maison_Edition;

-- 15. Mangas sans mangaka associé (cas rare)
SELECT Ma.Titre_Traduit_Manga
FROM Manga Ma
LEFT JOIN écrire e ON Ma.ID_Manga = e.ID_Manga
WHERE e.ID_Mangaka IS NULL;


/* ======================================================
   4. REQUÊTES IMBRIQUÉES (IN, EXISTS, ANY, ALL) (≥5)
   ====================================================== */

-- 16. Mangas publiés dans 'Weekly Shonen Jump'
SELECT Titre_Traduit_Manga
FROM Manga
WHERE ID_Manga IN (
  SELECT ID_Manga FROM vendre
  WHERE ID_Magazine IN (
    SELECT ID_Magazine FROM Magazine WHERE Titre_Magazine = 'Weekly Shonen Jump'
  )
);

-- 17. Mangakas travaillant pour Shueisha
SELECT Nom_Mangaka, Prenom_Pseudo_Mangaka
FROM Mangaka
WHERE ID_Maison_Edition IN (
  SELECT ID_Maison_Edition FROM Maison_Edition WHERE Nom_Maison_Edition = 'Shueisha'
);

-- 18. Mangas sans volume (non publiés)
SELECT Titre_Traduit_Manga
FROM Manga M
WHERE NOT EXISTS (
  SELECT 1 FROM Volume V WHERE V.ID_Manga = M.ID_Manga
);

-- 19. Magazines au tirage supérieur à la moyenne
SELECT Titre_Magazine, TirageMoyen_Magazine
FROM Magazine
WHERE TirageMoyen_Magazine > (
  SELECT AVG(TirageMoyen_Magazine) FROM Magazine
);

 -- Affiche les mangas dont le tirage moyen des volumes dépasse 450 000 exemplaires (classement décroissant)
SELECT M.Titre_Traduit_Manga AS Titre, ROUND(AVG(V.TirageInitial_Volume)) AS Tirage_Moyen FROM Manga M JOIN Volume V ON M.ID_Manga = V.ID_Manga
GROUP BY M.ID_Manga, M.Titre_Traduit_Manga HAVING  AVG(V.TirageInitial_Volume) > 450000
ORDER BY Tirage_Moyen DESC;

