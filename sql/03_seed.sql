/*
 * 03_seed.sql
 * Inserts sample data into the Biblio database for testing.
 *
 * Executed with: sqlcmd -d Biblio
 */

-- ── Auteurs ─────────────────────────────────────────────────────
SET IDENTITY_INSERT Auteurs ON;
MERGE INTO Auteurs AS tgt
USING (VALUES
    (1, N'Hugo',         N'Victor',        N'Française',   '1802-02-26'),
    (2, N'Camus',        N'Albert',        N'Française',   '1913-11-07'),
    (3, N'Orwell',       N'George',        N'Britannique', '1903-06-25'),
    (4, N'Tolkien',      N'J.R.R.',        N'Britannique', '1892-01-03'),
    (5, N'Saint-Exupéry', N'Antoine de',   N'Française',   '1900-06-29')
) AS src (AuteurID, Nom, Prenom, Nationalite, DateNaiss)
ON tgt.AuteurID = src.AuteurID
WHEN NOT MATCHED THEN
    INSERT (AuteurID, Nom, Prenom, Nationalite, DateNaiss)
    VALUES (src.AuteurID, src.Nom, src.Prenom, src.Nationalite, src.DateNaiss);
SET IDENTITY_INSERT Auteurs OFF;
PRINT '>>> Auteurs seeded.';
GO

-- ── Categories ──────────────────────────────────────────────────
SET IDENTITY_INSERT Categories ON;
MERGE INTO Categories AS tgt
USING (VALUES
    (1, N'Roman',            N'Oeuvres de fiction narrative'),
    (2, N'Science-Fiction',  N'Fiction spéculative et futuriste'),
    (3, N'Philosophie',      N'Essais et réflexions philosophiques'),
    (4, N'Fantasy',          N'Univers imaginaires et épiques'),
    (5, N'Jeunesse',         N'Littérature pour jeunes lecteurs')
) AS src (CategorieID, Libelle, Description)
ON tgt.CategorieID = src.CategorieID
WHEN NOT MATCHED THEN
    INSERT (CategorieID, Libelle, Description)
    VALUES (src.CategorieID, src.Libelle, src.Description);
SET IDENTITY_INSERT Categories OFF;
PRINT '>>> Categories seeded.';
GO

-- ── Livres ──────────────────────────────────────────────────────
SET IDENTITY_INSERT Livres ON;
MERGE INTO Livres AS tgt
USING (VALUES
    (1, N'Les Misérables',          N'978-2-07-040850-4', 1862, 1488, 1, 1),
    (2, N'L''Étranger',             N'978-2-07-036024-8', 1942,  159, 2, 3),
    (3, N'La Peste',                N'978-2-07-036042-2', 1947,  308, 2, 1),
    (4, N'1984',                    N'978-0-452-28423-4', 1949,  328, 3, 2),
    (5, N'Le Seigneur des Anneaux', N'978-2-267-02768-5', 1954, 1178, 4, 4),
    (6, N'Le Petit Prince',         N'978-2-07-040850-0', 1943,   96, 5, 5),
    (7, N'Notre-Dame de Paris',     N'978-2-07-041239-6', 1831,  940, 1, 1)
) AS src (LivreID, Titre, ISBN, AnneePubli, NbPages, AuteurID, CategorieID)
ON tgt.LivreID = src.LivreID
WHEN NOT MATCHED THEN
    INSERT (LivreID, Titre, ISBN, AnneePubli, NbPages, AuteurID, CategorieID)
    VALUES (src.LivreID, src.Titre, src.ISBN, src.AnneePubli, src.NbPages, src.AuteurID, src.CategorieID);
SET IDENTITY_INSERT Livres OFF;
PRINT '>>> Livres seeded.';
GO

-- ── Adherents ───────────────────────────────────────────────────
SET IDENTITY_INSERT Adherents ON;
MERGE INTO Adherents AS tgt
USING (VALUES
    (1, N'Amrani',      N'Youssef',  N'youssef.amrani@etu.univ.ma',   N'0661-123456', '2024-09-01'),
    (2, N'Benali',      N'Fatima',   N'fatima.benali@etu.univ.ma',    N'0662-234567', '2024-09-01'),
    (3, N'Tazi',        N'Omar',     N'omar.tazi@etu.univ.ma',        N'0663-345678', '2024-09-15'),
    (4, N'El Idrissi',  N'Sara',     N'sara.elidrissi@etu.univ.ma',   N'0664-456789', '2025-01-10'),
    (5, N'Hajji',       N'Karim',    N'karim.hajji@etu.univ.ma',      N'0665-567890', '2025-01-10')
) AS src (AdherentID, Nom, Prenom, Email, Telephone, DateInscr)
ON tgt.AdherentID = src.AdherentID
WHEN NOT MATCHED THEN
    INSERT (AdherentID, Nom, Prenom, Email, Telephone, DateInscr)
    VALUES (src.AdherentID, src.Nom, src.Prenom, src.Email, src.Telephone, src.DateInscr);
SET IDENTITY_INSERT Adherents OFF;
PRINT '>>> Adherents seeded.';
GO

-- ── Emprunts ────────────────────────────────────────────────────
SET IDENTITY_INSERT Emprunts ON;
MERGE INTO Emprunts AS tgt
USING (VALUES
    (1, 1, 1, '2025-10-01', '2025-10-15'),
    (2, 1, 4, '2025-10-05', NULL),
    (3, 2, 6, '2025-10-10', '2025-10-20'),
    (4, 3, 2, '2025-11-01', NULL),
    (5, 4, 5, '2025-11-05', '2025-11-25'),
    (6, 5, 3, '2025-11-10', NULL),
    (7, 2, 7, '2025-12-01', NULL)
) AS src (EmpruntID, AdherentID, LivreID, DateEmprunt, DateRetour)
ON tgt.EmpruntID = src.EmpruntID
WHEN NOT MATCHED THEN
    INSERT (EmpruntID, AdherentID, LivreID, DateEmprunt, DateRetour)
    VALUES (src.EmpruntID, src.AdherentID, src.LivreID, src.DateEmprunt, src.DateRetour);
SET IDENTITY_INSERT Emprunts OFF;
PRINT '>>> Emprunts seeded.';
GO
