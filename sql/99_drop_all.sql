/*
 * 99_drop_all.sql
 * Drops all tables in the correct order (children before parents).
 *
 * Usage from interactive sqlcmd:
 *   :r /sql/99_drop_all.sql
 *
 * Or from the host:
 *   ./scripts/sql.sh -i /sql/99_drop_all.sql
 */
USE [Biblio];
GO

-- ── Drop tables in dependency order (children first) ────────────
IF OBJECT_ID('dbo.Emprunts',   'U') IS NOT NULL DROP TABLE dbo.Emprunts;
IF OBJECT_ID('dbo.Livres',     'U') IS NOT NULL DROP TABLE dbo.Livres;
IF OBJECT_ID('dbo.Adherents',  'U') IS NOT NULL DROP TABLE dbo.Adherents;
IF OBJECT_ID('dbo.Categories', 'U') IS NOT NULL DROP TABLE dbo.Categories;
IF OBJECT_ID('dbo.Auteurs',    'U') IS NOT NULL DROP TABLE dbo.Auteurs;

PRINT '>>> All tables dropped from [Biblio].';
GO

-- ── Uncomment below to drop the entire database ────────────────
-- USE [master];
-- GO
-- IF EXISTS (SELECT name FROM sys.databases WHERE name = N'Biblio')
-- BEGIN
--     ALTER DATABASE [Biblio] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
--     DROP DATABASE [Biblio];
--     PRINT '>>> Database [Biblio] dropped.';
-- END
-- GO
