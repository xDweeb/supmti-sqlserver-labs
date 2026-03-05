/*
 * 02_constraints.sql
 * Adds foreign keys, unique constraints, check constraints, and indexes.
 *
 * Executed with: sqlcmd -d Biblio
 */

-- ════════════════════════════════════════════════════════════════
-- FOREIGN KEYS
-- ════════════════════════════════════════════════════════════════

-- Livres → Auteurs
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Livres_Auteur')
BEGIN
    ALTER TABLE Livres
        ADD CONSTRAINT FK_Livres_Auteur
        FOREIGN KEY (AuteurID) REFERENCES Auteurs(AuteurID);
    PRINT '>>> FK_Livres_Auteur added.';
END
GO

-- Livres → Categories
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Livres_Categorie')
BEGIN
    ALTER TABLE Livres
        ADD CONSTRAINT FK_Livres_Categorie
        FOREIGN KEY (CategorieID) REFERENCES Categories(CategorieID);
    PRINT '>>> FK_Livres_Categorie added.';
END
GO

-- Emprunts → Adherents
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Emprunts_Adherent')
BEGIN
    ALTER TABLE Emprunts
        ADD CONSTRAINT FK_Emprunts_Adherent
        FOREIGN KEY (AdherentID) REFERENCES Adherents(AdherentID);
    PRINT '>>> FK_Emprunts_Adherent added.';
END
GO

-- Emprunts → Livres
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE name = 'FK_Emprunts_Livre')
BEGIN
    ALTER TABLE Emprunts
        ADD CONSTRAINT FK_Emprunts_Livre
        FOREIGN KEY (LivreID) REFERENCES Livres(LivreID);
    PRINT '>>> FK_Emprunts_Livre added.';
END
GO

-- ════════════════════════════════════════════════════════════════
-- UNIQUE CONSTRAINTS
-- ════════════════════════════════════════════════════════════════

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'UQ_Livres_ISBN')
BEGIN
    ALTER TABLE Livres
        ADD CONSTRAINT UQ_Livres_ISBN UNIQUE (ISBN);
    PRINT '>>> UQ_Livres_ISBN added.';
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'UQ_Adherents_Email')
BEGIN
    ALTER TABLE Adherents
        ADD CONSTRAINT UQ_Adherents_Email UNIQUE (Email);
    PRINT '>>> UQ_Adherents_Email added.';
END
GO

-- ════════════════════════════════════════════════════════════════
-- CHECK CONSTRAINTS
-- ════════════════════════════════════════════════════════════════

IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE name = 'CK_Livres_AnneePubli')
BEGIN
    ALTER TABLE Livres
        ADD CONSTRAINT CK_Livres_AnneePubli CHECK (AnneePubli BETWEEN 1000 AND 2100);
    PRINT '>>> CK_Livres_AnneePubli added.';
END
GO

IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE name = 'CK_Livres_NbPages')
BEGIN
    ALTER TABLE Livres
        ADD CONSTRAINT CK_Livres_NbPages CHECK (NbPages > 0);
    PRINT '>>> CK_Livres_NbPages added.';
END
GO

-- ════════════════════════════════════════════════════════════════
-- INDEXES
-- ════════════════════════════════════════════════════════════════

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Livres_AuteurID')
BEGIN
    CREATE NONCLUSTERED INDEX IX_Livres_AuteurID ON Livres(AuteurID);
    PRINT '>>> IX_Livres_AuteurID created.';
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Livres_CategorieID')
BEGIN
    CREATE NONCLUSTERED INDEX IX_Livres_CategorieID ON Livres(CategorieID);
    PRINT '>>> IX_Livres_CategorieID created.';
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Emprunts_AdherentID')
BEGIN
    CREATE NONCLUSTERED INDEX IX_Emprunts_AdherentID ON Emprunts(AdherentID);
    PRINT '>>> IX_Emprunts_AdherentID created.';
END
GO

IF NOT EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_Emprunts_LivreID')
BEGIN
    CREATE NONCLUSTERED INDEX IX_Emprunts_LivreID ON Emprunts(LivreID);
    PRINT '>>> IX_Emprunts_LivreID created.';
END
GO
