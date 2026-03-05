# 🎓 SupMTI – SQL Server Labs

> Environnement Docker pour les travaux pratiques **Microsoft SQL Server Express 2019** + **SSMS**.
> Conçu pour fonctionner dans **GitHub Codespaces** et être accessible depuis **SSMS sur Windows**.

---

## 📁 Structure du projet

```
.
├── docker-compose.yml        # SQL Server 2019 + init container
├── .env.example              # Template des variables d'environnement
├── .env                      # Votre mot de passe SA (non versionné)
├── sql/
│   ├── 00_create_db.sql      # Création de la base Biblio
│   ├── 01_schema.sql         # Tables : Auteurs, Categories, Livres, Adherents, Emprunts
│   ├── 02_constraints.sql    # FK, UNIQUE, CHECK, INDEX
│   ├── 03_seed.sql           # Données de test
│   └── 99_drop_all.sql       # Suppression des tables (DROP DB commenté)
├── scripts/
│   ├── up.sh                 # Démarrer l'environnement
│   ├── down.sh               # Arrêter (données conservées)
│   ├── reset.sh              # Tout supprimer et réinitialiser
│   └── sql.sh                # Ouvrir un prompt sqlcmd interactif
├── .vscode/
│   └── extensions.json       # Extensions recommandées
└── README.md
```

---

## 🚀 Démarrage rapide

### 1. Configurer le mot de passe

```bash
cp .env.example .env
```

Éditez `.env` et définissez un mot de passe fort pour `MSSQL_SA_PASSWORD` :

```
MSSQL_SA_PASSWORD=MonMotDePasse!123
```

> ⚠️ Le mot de passe doit respecter les exigences de complexité SQL Server :
> au moins 8 caractères, avec majuscules, minuscules, chiffres et symboles.

### 2. Démarrer SQL Server

```bash
./scripts/up.sh
```

Cela lance :
1. **SQL Server 2019 Express** sur le port `1433`
2. Un conteneur **initdb** qui attend le healthcheck puis exécute les scripts SQL dans l'ordre

### 3. Vérifier

```bash
./scripts/sql.sh
```

Vous êtes dans un prompt `sqlcmd` connecté à la base `Biblio`. Essayez :

```sql
SELECT * FROM Auteurs;
GO
```

### 4. Arrêter / Réinitialiser

```bash
./scripts/down.sh       # Arrêter (données conservées dans le volume)
./scripts/reset.sh      # Supprimer le volume et tout réinitialiser
```

---

## 🔌 Connexion depuis VS Code (extension mssql)

L'extension **SQL Server (mssql)** est recommandée automatiquement à l'ouverture du projet.

1. Installez l'extension `ms-mssql.mssql` si ce n'est pas déjà fait
2. Ouvrez la palette de commandes : `Ctrl+Shift+P` → **MS SQL: Add Connection**
3. Paramètres de connexion :

| Paramètre          | Valeur                |
|---------------------|-----------------------|
| **Server name**     | `localhost,1433`      |
| **Database name**   | `Biblio`              |
| **Authentication**  | `SQL Login`           |
| **User name**       | `sa`                  |
| **Password**        | *(votre .env)*        |
| **Trust Server Certificate** | `True`       |

4. Cliquez **Connect** — vous pouvez maintenant exécuter des requêtes T-SQL directement dans VS Code.

---

## 🖥️ Connexion depuis SSMS (Windows) vers Codespaces

### Étape 1 : Rendre le port 1433 public dans Codespaces

1. Dans VS Code (Codespace), ouvrez l'onglet **PORTS** (en bas)
2. Trouvez le port **1433**
3. Clic droit → **Port Visibility** → **Public**

> ℹ️ Par défaut, les ports sont privés. SSMS depuis votre PC Windows ne pourra pas se connecter si le port est privé.

### Étape 2 : Récupérer l'adresse du Codespace

L'adresse forwarded a le format :

```
<CODESPACE_NAME>-1433.app.github.dev
```

Vous la trouverez dans l'onglet **PORTS** → colonne **Forwarded Address**.

### Étape 3 : Configurer SSMS

Ouvrez **SQL Server Management Studio** sur votre PC Windows et utilisez :

| Paramètre                    | Valeur                                          |
|------------------------------|--------------------------------------------------|
| **Server type**              | Database Engine                                  |
| **Server name**              | `<CODESPACE_NAME>-1433.app.github.dev,1433`     |
| **Authentication**           | SQL Server Authentication                        |
| **Login**                    | `sa`                                             |
| **Password**                 | *(votre mot de passe .env)*                      |
| **Encrypt connection**       | `Mandatory` ou `Yes`                             |
| **Trust server certificate** | ✅ Coché                                         |

> 💡 **Astuce** : Dans les versions récentes de SSMS (v19+), cliquez sur **Options >>** →
> onglet **Connection Properties** → cochez **Trust server certificate**.
>
> Pour les versions plus anciennes de SSMS, dans l'onglet **Additional Connection Parameters**,
> ajoutez : `TrustServerCertificate=True`

### Étape 4 : Se connecter

Cliquez **Connect**. Vous devriez voir la base **Biblio** avec toutes les tables dans l'Object Explorer.

### Dépannage SSMS

| Problème | Solution |
|----------|----------|
| Connection refused | Vérifiez que le port 1433 est bien **Public** dans l'onglet Ports |
| Login failed | Vérifiez le mot de passe dans `.env` |
| SSL/TLS error | Cochez **Trust server certificate** dans SSMS |
| Timeout | Le Codespace est peut-être en veille — ouvrez-le d'abord dans le navigateur |

---

## 📝 Notes importantes

- **Java n'est PAS requis** pour SQL Server Express 2019 + SSMS. Tout fonctionne avec le stack Microsoft natif.
- Les données sont persistées dans un volume Docker nommé `mssql_data`. Elles survivent aux redémarrages.
- Le script `reset.sh` supprime le volume et recrée tout à zéro.
- Le fichier `.env` contient votre mot de passe — il est listé dans `.gitignore` et ne doit **jamais** être commité.

---

## 📚 Schéma de la base Biblio

```
┌──────────────┐       ┌──────────────┐
│   Auteurs    │       │  Categories  │
│──────────────│       │──────────────│
│ AuteurID (PK)│       │CategorieID(PK)│
│ Nom          │       │ Libelle      │
│ Prenom       │       │ Description  │
│ Nationalite  │       └──────┬───────┘
│ DateNaiss    │              │
└──────┬───────┘              │
       │                      │
       │    ┌─────────────────┘
       │    │
       ▼    ▼
┌──────────────────┐
│     Livres       │
│──────────────────│
│ LivreID (PK)     │
│ Titre            │
│ ISBN (UQ)        │
│ AnneePubli       │
│ NbPages          │
│ AuteurID (FK)    │──→ Auteurs
│ CategorieID (FK) │──→ Categories
│ DateAjout        │
└────────┬─────────┘
         │
         │
         ▼
┌──────────────────┐      ┌──────────────────┐
│    Emprunts      │      │   Adherents      │
│──────────────────│      │──────────────────│
│ EmpruntID (PK)   │      │ AdherentID (PK)  │
│ AdherentID (FK)  │──→   │ Nom              │
│ LivreID (FK)     │──→   │ Prenom           │
│ DateEmprunt      │      │ Email (UQ)       │
│ DateRetour       │      │ Telephone        │
└──────────────────┘      │ DateInscr        │
                          └──────────────────┘
```

---

## 🛠️ Commandes utiles

```bash
# Démarrer
./scripts/up.sh

# Arrêter
./scripts/down.sh

# Réinitialiser (tout supprimer + recréer)
./scripts/reset.sh

# Prompt SQL interactif
./scripts/sql.sh

# Exécuter un fichier SQL spécifique
./scripts/sql.sh -i /sql/99_drop_all.sql

# Voir les logs SQL Server
docker logs sqlserver

# Voir les logs d'initialisation
docker logs initdb
```

---

## 📄 Licence

Projet académique – SupMTI.
