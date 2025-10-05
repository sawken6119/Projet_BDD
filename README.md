# Analyse Métier – Maison d'Édition Manga

## Rôle
Agir en tant qu'expert en analyse métier pour une maison d'édition de mangas.  
Spécialiste des processus éditoriaux, de la gestion des droits d'auteur et de la commercialisation de séries.

---

## Instruction 
1. Identifie et liste toutes les règles métier spécifiques au domaine de l'édition de manga
2. Définis précisément le dictionnaire de données avec toutes les entités, attributs et leurs caractéristiques
3. Organise les informations de manière structurée pour faciliter la conception MERISE

---

## Contexte
Notre entreprise gère :  

- Des **séries de mangas** avec leurs volumes et chapitres.  
- Des **auteurs** (scénaristes, dessinateurs) et leurs contrats.  
- Des **magazines de prépublication** (ex: Shonen Jump).  
- Les **ventes** par volume et par territoire.  
- Les **traductions** dans différentes langues.  
- Des **produits dérivés** (goodies, figurines, etc.).  
- Le **suivi des parutions** dans les magazines.

---

## Référence
Références 
- Sites de référence : https://www.glenat.com
- Processus éditoriaux des maisons d'édition françaises
- Gestion des droits d'auteur dans l'édition
- Organisation type d'une série manga (volumes, chapitres, magazines)

---

## Règles Métier
1. Chaque **manga** est identifié par un ID unique et peut avoir un titre original et un titre traduit.  
2. Un manga appartient à **une catégorie** (shonen, shojo, seinen, etc.) et possède un statut (en cours, terminé, suspendu).  
3. Chaque manga peut être **publié par une ou plusieurs maisons d’édition**, mais chaque maison d’édition gère plusieurs mangas.  
4. Les mangas sont **écrits par un ou plusieurs mangakas**, chacun ayant un rôle précis (scénariste, dessinateur, etc.).  
5. Chaque **manga est découpé en volumes**, identifiés par un ISBN unique.  
6. Chaque volume contient **un ou plusieurs chapitres**.  
7. Les chapitres ont un numéro unique dans le volume, un titre, un nombre de pages et une date de parution.  
8. Les volumes peuvent être **vendus individuellement** ou via des magazines (prépublication).  
9. Les magazines ont un titre, une périodicité et un tirage moyen.  
10. Un volume peut être **contenu dans un ou plusieurs magazines**, et un magazine peut contenir plusieurs volumes (relation n-n).  
11. Chaque vente de volume ou magazine est suivie individuellement, avec possibilité de ventes multiples.  
12. Chaque mangaka possède un nom, un prénom ou pseudo, une date de naissance et des rôles multiples.  
13. Chaque maison d’édition possède un nom, une adresse et un ID unique.  
14. Les dates de création, de parution ou de sortie sont **systématiquement suivies** pour la traçabilité.  
15. Les relations n-aires (ex: publier, contenir, écrire) sont modélisées explicitement pour respecter les règles métier et la 3FN.

---

## Dictionnaire de Données

| Entité         | Attribut               | Type        | Description                                | Contraintes                     |
| -------------- | -------------------- | ----------- | ------------------------------------------ | ------------------------------- |
| Maison_Edition | ID_Maison_Edition      | VARCHAR(50) | Identifiant unique de la maison d’édition | PK                              |
| Maison_Edition | Adresse_Maison_Edition | VARCHAR(150)| Adresse complète                           | Non null                        |
| Maison_Edition | Nom_Maison_Edition     | VARCHAR(100)| Nom officiel de l’éditeur                  | Non null                        |
| Manga          | ID_Manga               | VARCHAR(50) | Identifiant unique du manga                | PK                              |
| Manga          | Titre_Original_Manga   | VARCHAR(150)| Titre original du manga                    | Non null                        |
| Manga          | Titre_Traduite_Manga   | VARCHAR(150)| Titre traduit du manga                     | Null autorisé                   |
| Manga          | Catégorie              | VARCHAR(50) | Catégorie éditoriale                       | Non null                        |
| Manga          | Statut                 | VARCHAR(50) | Statut de publication                      | Non null                        |
| Manga          | DateCreation_Manga     | DATE        | Date de création du manga                  | Non null                        |
| Mangaka        | ID_Mangaka             | VARCHAR(50) | Identifiant unique du mangaka              | PK                              |
| Mangaka        | Nom_Mangaka            | VARCHAR(50) | Nom du mangaka                             | Non null                        |
| Mangaka        | Prenom_Pseudo_Mangaka  | VARCHAR(50) | Prénom ou pseudo                           | Non null                        |
| Mangaka        | Date_Naissance         | DATE        | Date de naissance                          | Null autorisé                   |
| Mangaka        | Rôles                  | VARCHAR(50) | Rôle(s) dans la création                   | Non null                        |
| Volume         | ISBN                   | INT         | Identifiant unique du volume               | PK                              |
| Volume         | Numéro_Volume          | INT         | Numéro du volume dans la série             | Non null                        |
| Volume         | DateSortie_Volume      | DATE        | Date de sortie officielle                  | Non null                        |
| Volume         | Prix_Volume            | CURRENCY    | Prix conseillé                             | Non null                        |
| Volume         | TirageInitial_Volume   | INT         | Nombre d’exemplaires initial               | Non null                        |
| Chapitre       | ID_Chapitre            | VARCHAR(50) | Identifiant unique du chapitre             | PK                              |
| Chapitre       | Titre_Chapitre         | VARCHAR(50) | Titre du chapitre                          | Non null                        |
| Chapitre       | Numéro_Chapitre        | INT         | Numéro du chapitre dans le volume          | Non null                        |
| Chapitre       | NbPage_Chapitre        | INT         | Nombre de pages                            | Non null                        |
| Chapitre       | DateParution_Chapitre  | VARCHAR(50) | Date de parution                           | Non null                        |
| Magazine       | ID_Magazine            | VARCHAR(50) | Identifiant unique du magazine             | PK                              |
| Magazine       | Titre_Magazine         | VARCHAR(50) | Nom du magazine                            | Non null                        |
| Magazine       | Periodicité_Magazine   | DATE        | Fréquence de publication                   | Non null                        |
| Magazine       | TirageMoyen_Magazine   | VARCHAR(50) | Tirage moyen                               | Null autorisé                   |
| Vente          | –                      | –           | Relation de vente des volumes ou magazines | Multi-enregistrements autorisés |
| Publier        | –                      | –           | Relation entre Maison_Edition et Manga     | N-n obligatoire                 |
| Écrire         | –                      | –           | Relation entre Manga et Mangaka            | N-n obligatoire                 |
| Contenir       | –                      | –           | Relation entre Volume et Chapitre          | 1-n obligatoire                 |
