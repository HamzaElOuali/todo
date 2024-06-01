# Script Bash pour la Gestion des Tâches

## Introduction
Ce projet propose un système de gestion des tâches simple, réalisé sous forme de script Bash. Il vise à fournir une interface en ligne de commande pour gérer les tâches, ce qui est idéal pour ceux qui préfèrent utiliser le terminal. Bien que basique, ce script offre une gamme de fonctionnalités généralement présentes dans des systèmes de gestion de tâches plus élaborés.

## Choix de Conception

### Stockage des Données
Les tâches sont enregistrées dans un fichier CSV nommé `taches.csv`. Chaque ligne représente une tâche, avec des colonnes dédiées à l'ID de la tâche, le titre, la date d'échéance, la description, le lieu, la priorité et le statut d'achèvement. Ce format a été sélectionné pour sa simplicité et sa compatibilité avec des outils Unix standard tels que `awk` et `sed`.

### Organisation du Code
Le code est structuré en fonctions, chacune étant responsable d'une tâche spécifique comme la création, la mise à jour, la suppression, l'affichage, la recherche ou la complétion des tâches. Cette approche modulaire facilite la compréhension et la maintenance du code.

## Fonctionnalités

### Création d'une Tâche
Les utilisateurs peuvent créer une nouvelle tâche en saisissant des informations telles que le titre, la date d'échéance, la description, le lieu et la priorité. Le script demande chaque détail à l'utilisateur, garantissant la saisie de toutes les informations nécessaires.

### Mise à Jour d'une Tâche
Les utilisateurs peuvent modifier une tâche existante en fournissant l'ID de la tâche et les nouveaux détails. Le script invite l'utilisateur à entrer les informations mises à jour, permettant de modifier tout aspect de la tâche. Cela permet d'adapter facilement les tâches aux nouvelles circonstances.

### Suppression d'une Tâche
Les utilisateurs peuvent supprimer une tâche en entrant l'ID correspondant. Cette opération est simple mais doit être effectuée avec précaution, car les tâches supprimées ne peuvent pas être récupérées.

### Affichage de Toutes les Tâches
Les utilisateurs peuvent afficher toutes les tâches, qui seront présentées dans un format aligné par colonnes. Cela offre une vue d'ensemble rapide et claire de toutes les tâches.

### Recherche d'une Tâche
Les utilisateurs peuvent rechercher des tâches en entrant un terme spécifique. Le script explore tous les champs de toutes les tâches pour trouver des correspondances, offrant ainsi un outil efficace pour localiser des tâches précises.

### Marquage d'une Tâche comme Terminée
Les utilisateurs peuvent marquer une tâche comme terminée en entrant l'ID de la tâche. Le statut de la tâche sera alors mis à jour en "Terminée", offrant une manière satisfaisante de conclure une tâche.

## Utilisation
Pour utiliser ce script, il suffit de l'exécuter dans un shell Bash :

```bash
/bin/bash /chemin/vers/todo.sh
