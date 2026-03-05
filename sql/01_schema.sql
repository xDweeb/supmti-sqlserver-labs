/*
 * 01_schema.sql
 * Creates core tables for the Biblio (library) database.
 * Uses IDENTITY, NVARCHAR, and other T-SQL data types.
 *
 * Executed with: sqlcmd -d Biblio
 */

-- ── Auteurs (Authors) ──────────────────────────────────────────
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Auteurs')
BEGIN
    CREATE TABLE Auteurs (
        AuteurID    INT            IDENTITY(1,1)  NOT NULL,
        Nom         NVARCHAR(100)                 NOT NULL,
        Prenom      NVARCHAR(100)                 NOT NULL,
        Nationalite NVARCHAR(50)                  NULL,
        DateNaiss   DATE                          NULL,
        CONSTRAINT PK_Auteurs PRIMARY KEY (AuteurID)
    );
    PRINT '>>> Table [Auteurs] created.';
END
GO

-- ── Categories ─────────────────────────────────────────────────
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Categories')
BEGIN
    CREATE TABLE Categories (
        CategorieID  INT            IDENTITY(1,1)  NOT NULL,
        Libelle      NVARCHAR(100)                 NOT NULL,
        Description  NVARCHAR(255)                 NULL,
        CONSTRAINT PK_Categories PRIMARY KEY (CategorieID)
    );
    PRINT '>>> Table [Categories] created.';
END
GO

-- ── Livres (Books) ─────────────────────────────────────────────
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Livres')
BEGIN
    CREATE TABLE Livres (
        LivreID      INT            IDENTITY(1,1)  NOT NULL,
        Titre        NVARCHAR(200)                 NOT NULL,
        ISBN         NVARCHAR(20)                  NULL,
        AnneePubli   INT                           NULL,
        NbPages      INT                           NULL,
        AuteurID     INT                           NOT NULL,
        CategorieID  INT                           NOT NULL,
        DateAjout    DATETIME2      DEFAULT SYSDATETIME(),
        CONSTRAINT PK_Livres PRIMARY KEY (LivreID)
    );
    PRINT '>>> Table [Livres] created.';
END
GO

-- ── Adherents (Members / Subscribers) ──────────────────────────
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Adherents')
BEGIN
    CREATE TABLE Adherents (
        AdherentID   INT            IDENTITY(1,1)  NOT NULL,
        Nom          NVARCHAR(100)                 NOT NULL,
        Prenom       NVARCHAR(100)                 NOT NULL,
        Email        NVARCHAR(150)                 NOT NULL,
        Telephone    NVARCHAR(20)                  NULL,
        DateInscr    DATE           DEFAULT CAST(GETDATE() AS DATE),
        CONSTRAINT PK_Adherents PRIMARY KEY (AdherentID)
    );
    PRINT '>>> Table [Adherents] created.';
END
GO

-- ── Emprunts (Loans / Borrowings) ──────────────────────────────
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Emprunts')
BEGIN
    CREATE TABLE Emprunts (
        EmpruntID    INT            IDENTITY(1,1)  NOT NULL,
        AdherentID   INT                           NOT NULL,
        LivreID      INT                           NOT NULL,
        DateEmprunt  DATE           DEFAULT CAST(GETDATE() AS DATE),
        DateRetour   DATE                          NULL,
        CONSTRAINT PK_Emprunts PRIMARY KEY (EmpruntID)
    );
    PRINT '>>> Table [Emprunts] created.';
END
GO
