# Todo
Projet linux dans le cadre du M2 IMSD.


## Description 

Pour éviter d'oublier des choses importantes à faire, je voudrais garder une liste dans mon ordinateur. J'aimerais pouvoir ajouter des tâches, les lister, et les supprimer.

*Remarque* : je pourrais également utiliser cette fonctionnalité pour garder :

- une liste de films à voir,
- une liste de course,
- etc.

Le script doit fournir une unique fonction todo qui offre 3 fonctionnalités :

- lister les tâches en attente
- supprimer une tâche
- ajouter une tâche

Votre fonction devra analyser son premier argument afin de décider quelle opération effectuer. La liste des tâche doit être sauvegardée dans un fichier (caché) `.todo_list` qui sera stocké dans votre dossier personnel. Ce fichier contiendra une ligne par tâche, sans numéro. Pour simplifier la gestion de ce fichier, il est conseillé de le définir dans une variable au début de votre script.

## Pour aller plus loin 

- Gestion des erreurs (oubli du numéro de tache, etc.)
- Gestion de plusieurs fichiers pour des listes différentes.
- Filtre sur les taches en cours (avec grep) pour limiter l'affichage.
- etc.


## Installer le fichier

Pour utiliser le fichier : 

` source todo.sh`

## Comment utiliser ?

`todo help` permet d'afficher la sortie suivante : 


**DESCRIPTION**

		La fonction todo permet de gérer une liste de films. 
		Les options suivantes sont disponibles : 

		- list [recherche]
			Affiche la liste des films en cours à
			partir de la chaîne de caractère en argument. 
			Si aucune chaîne de caractère n'est renseignée, 
			renvoie la liste de films entière.

		- add [numéro de la tâche] [chaine de caractère]
			Ajoute un film à la liste. Nécessite de spécifier 
			en argument sa position (1) et son titre (2).

		- done [numéro de la tâche] | [all]	
			Supprime un film de la liste à partir de 
			sa position. L'argument [all] permet de supprimer
			tous les films en cours.

		- import [chemin du fichier]
			Utilise un fichier à partir de son chemin 
			comme nouvelle liste de films.


