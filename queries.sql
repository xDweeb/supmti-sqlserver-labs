SELECT L.Titre, A.Prenom + ' ' + A.Nom AS Auteur, C.Libelle AS Categorie
FROM Livres L
JOIN Auteurs A ON L.AuteurID = A.AuteurID
JOIN Categories C ON L.CategorieID = C.CategorieID;
