# 🎓 Mini-Projet Base de Données — SAWADOGO

**Auteurs :**
👩‍💻 *Orlane NDJIBOU*
👨‍💻 *Tinwende Kenanja SAWADOGO*

---

## 🏢 Contexte du projet

**SAWADOGO** est une maison d’édition française spécialisée dans l’édition de **mangas**.
Ses activités incluent la **publication, distribution et gestion** des mangas, de leurs auteurs, de leurs ventes, de leurs traductions et de leurs produits dérivés.

Comparable à des éditeurs tels que **Kana**, **Glénat**, **Pika Édition** ou **Shueisha**, l’entreprise gère :

* des séries de mangas, leurs volumes et chapitres,
* les auteurs (scénaristes, dessinateurs),
* les magazines de prépublication,
* les ventes par volume,
* les contrats d’auteurs et de traduction,
* et les produits dérivés associés.

En **2025**, la maison d’édition souhaite formaliser son système d’information à l’aide de la **méthode MERISE**.
Nous avons donc été chargés de **réaliser la phase d’analyse et de conception** pour fournir les éléments nécessaires à la création de la base de données.

---

## 🧩 Analyse des besoins

Pour cette étude, nous nous sommes inspirés du site officiel de **[Glénat](https://www.glenat.com)**.
Le travail a été guidé par le **Prompt Riccardo**, qui définit les rôles, le contexte et les contraintes du projet.

---

## 🤖 Prompt Riccardo (résumé)

**Rôle :**

> Agir en tant qu’expert en analyse métier dans le domaine de l’édition de mangas.

**Objectifs :**

1. Identifier toutes les **règles métier** spécifiques.
2. Définir un **dictionnaire de données complet**.
3. Organiser les informations pour une **modélisation MERISE** conforme à la 3FN.

**Contexte couvert :**

* Séries, volumes, chapitres
* Auteurs et contrats
* Magazines de prépublication
* Ventes par volume
* Traductions multilingues
* Produits dérivés

**Contraintes :**

* Exhaustivité et cohérence
* Terminologie éditoriale française
* Respect des conventions MERISE
* Modèle de données normalisé en **3ᵉ forme normale (3FN)**

---

## ⚙️ Règles de métier

### A. Gestion des Mangas

1. Un manga doit avoir au moins un auteur (scénariste ou dessinateur).
2. Le titre d’un manga doit être unique dans le catalogue.
3. Statut possible : *En cours*, *Terminé*, *En pause*.
4. Chaque manga doit avoir une date de publication originale.
5. Un manga peut appartenir à plusieurs genres (shonen, shojo, seinen...).

### B. Gestion des Volumes et Chapitres

1. Un volume appartient à un seul manga.
2. Le numéro du volume est unique dans la série.
3. Un volume ne peut être publié avant la création du manga.
4. Un chapitre appartient à un seul volume.
5. L’ordre des chapitres est obligatoire.

### C. Gestion des Auteurs (Mangaka)

1. Un auteur peut être **scénariste**, **dessinateur** ou **auteur complet**.
2. Pas de contrats simultanés pour un même manga.
3. Un auteur mineur nécessite une autorisation parentale.
4. Les informations de contact doivent être uniques.

### D. Gestion des Contrats

1. Un contrat est lié à un seul auteur.
2. Date de début < Date de fin.
3. Droits d’auteur entre 1 % et 100 %.
4. Aucun contrat ne peut être modifié après signature.

### E. Gestion des Magazines

1. Un magazine peut prépublier plusieurs mangas.
2. Les chapitres paraissent d’abord dans le magazine avant le volume.
3. Périodicité fixe : hebdomadaire, mensuelle, etc.

### F. Gestion des Ventes

1. Les ventes sont suivies par volume et territoire.
2. Quantité vendue ≥ 0.
3. Prix > 0.
4. Une vente doit comporter une date de transaction.

### G. Gestion des Traductions

1. Une traduction = une langue et un volume.
2. La publication traduite ne peut précéder l’originale.
3. Plusieurs traductions possibles par volume.

### H. Produits Dérivés

1. Chaque produit dérivé est lié à au moins un manga.
2. Prix ≥ coût de production.
3. Stock ≥ 0.
4. Type de produit : figurine, vêtement, accessoire, etc.

### I. Règles Commerciales

1. Prix TTC = Prix HT + TVA.
2. Remises ≤ 50 %.
3. Statut d’une commande : *En attente*, *Validée*, *Expédiée*, *Annulée*.
4. Chiffre d’affaires = Σ (prix unitaire × quantité vendue).

---

## 🧱 Dictionnaire de données

| **Entité**         | **Attribut**           | **Type**     | **Description**                                           | **Contraintes**                 |
| ------------------ | ---------------------- | ------------ | --------------------------------------------------------- | ------------------------------- |
| **Maison_Edition** | ID_Maison_Edition      | VARCHAR(50)  | Identifiant unique de la maison d’édition                 | PK                              |
|                    | Adresse_Maison_Edition | VARCHAR(150) | Adresse complète                                          | NOT NULL                        |
|                    | Nom_Maison_Edition     | VARCHAR(100) | Nom officiel de l’éditeur                                 | NOT NULL                        |
| **Manga**          | ID_Manga               | VARCHAR(50)  | Identifiant unique du manga                               | PK                              |
|                    | Titre_Original_Manga   | VARCHAR(150) | Titre original du manga                                   | NOT NULL                        |
|                    | Titre_Traduit_Manga    | VARCHAR(150) | Titre traduit du manga                                    | NULL                            |
|                    | Catégorie              | VARCHAR(50)  | Catégorie éditoriale                                      | NOT NULL                        |
|                    | Statut                 | VARCHAR(50)  | Statut de publication                                     | NOT NULL                        |
|                    | DateCréation_Manga     | DATE         | Date de création du manga                                 | NOT NULL                        |
| **Mangaka**        | ID_Mangaka             | VARCHAR(50)  | Identifiant unique du mangaka                             | PK                              |
|                    | Nom_Mangaka            | VARCHAR(50)  | Nom du mangaka                                            | NOT NULL                        |
|                    | Prenom_Pseudo_Mangaka  | VARCHAR(50)  | Prénom ou pseudonyme                                      | NOT NULL                        |
|                    | Date_Naissance         | DATE         | Date de naissance                                         | NULL                            |
|                    | Rôles                  | VARCHAR(50)  | Rôle du mangaka (Scénariste, Dessinateur, Auteur complet) | NOT NULL                        |
| **Volume**         | ISBN                   | INT          | Identifiant unique du volume                              | PK                              |
|                    | Numéro_Volume          | INT          | Numéro du volume dans la série                            | NOT NULL                        |
|                    | DateSortie_Volume      | DATE         | Date de sortie officielle                                 | NOT NULL                        |
|                    | Prix_Volume            | DECIMAL(5,2) | Prix conseillé                                            | NOT NULL                        |
|                    | TirageInitial_Volume   | INT          | Tirage initial                                            | NOT NULL                        |
| **Chapitre**       | ID_Chapitre            | VARCHAR(50)  | Identifiant unique du chapitre                            | PK                              |
|                    | Titre_Chapitre         | VARCHAR(100) | Titre du chapitre                                         | NOT NULL                        |
|                    | Numéro_Chapitre        | INT          | Numéro du chapitre                                        | NOT NULL                        |
|                    | NbPage_Chapitre        | INT          | Nombre de pages                                           | NOT NULL                        |
|                    | DateParution_Chapitre  | DATE         | Date de parution                                          | NOT NULL                        |
| **Magazine**       | ID_Magazine            | VARCHAR(50)  | Identifiant unique du magazine                            | PK                              |
|                    | Titre_Magazine         | VARCHAR(100) | Nom du magazine                                           | NOT NULL                        |
|                    | Periodicité_Magazine   | DATE         | Fréquence de publication                                  | NOT NULL                        |
|                    | TirageMoyen_Magazine   | INT          | Tirage moyen                                              | NULL                            |
| **Relations**      | **–**                  | **–**        | **–**                                                     | **–**                           |
| Vente              | –                      | –            | Relation de vente des mangas via magazines                | Multi-enregistrements autorisés |
| Publier            | –                      | –            | Relation entre Maison_Édition et Manga                    | N–N obligatoire                 |
| Écrire             | –                      | –            | Relation entre Manga et Mangaka                           | N–N obligatoire                 |
| Contenir           | –                      | –            | Relation entre Volume et Chapitre                         | 1–N obligatoire                 |

---

## 🧮 Modèle conceptuel (MERISE)

> 📊 Le modèle conceptuel de données (MCD) a été conçu selon les règles MERISE et respecte la **3ᵉ forme normale (3FN)**.
> Il inclut les entités : *Maison_Édition*, *Manga*, *Mangaka*, *Volume*, *Chapitre*, *Magazine*, et leurs relations (*Publier*, *Écrire*, *Contenir*, *Vente*).

