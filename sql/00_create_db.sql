/*
 * 00_create_db.sql
 * Creates the Biblio database if it does not already exist.
 * Runs against [master] (no USE or -d flag needed).
 */
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'Biblio')
BEGIN
    CREATE DATABASE [Biblio];
    PRINT '>>> Database [Biblio] created.';
END
ELSE
BEGIN
    PRINT '>>> Database [Biblio] already exists - skipping.';
END
GO
