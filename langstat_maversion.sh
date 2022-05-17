#!/bin/bash

# Ce script est issu d'un exercice du cours "Reprenez le contrôle avec Linux !" d'OpenClassrooms.
# Il s'agit de dresser la statistique suivante :
# comptage du nombre de mots commençant par telle lettre,
# à partir d'un fichier dictionnaire de 323 577 mots en majuscules.


# A propos de la seconde fonctionnalité :
# Elle permet d'afficher les résultats classés par lettre.
# Exemple :
# A - 229938
# B - 43471
# C - 98832
# D - 72481
# E - 278814
# ...
#
# Pour cela, utiliser --parlettre en second paramètre.

# Vérification de la présence du paramètre indiquant le nom du fichier dictionnaire à utiliser
if [ -z $1 ]
then	
		# Utilisation de '\n' pour un affichage moins dense (en ajoutant '-e' après echo)
		echo -e "\nVeuillez mentionner le nom du fichier dictonnaire à utiliser en premier paramètre !\n"
else
	# Vérification de l'existence du fichier passé en premier paramètre
	# J'utilise ici -f au lieu de -e car dans le barême, il est demandé "Vérifier que le fichier dictionnaire existe bel et bien"
	if [ ! -f $1 ]
	then
		echo -e "\nVotre fichier dictionnaire n'existe pas !\n"
	else
		
		# Création du chemin du répertoire courant
		chemin_repertoire_courant=`pwd`
		# Création du chemin du fichier temporaire
		chemin_fichier_temporaire=$chemin_repertoire_courant'/resultats.txt'

		# Si le deuxième paramètre est vide, alors on procède au traitement de l'affichage du nombre de lettres utilisées.
		# Tri du plus grand nombre de lettres au plus petit.
		if [ -z $2 ]
		then
		
    		# La variable lettre reçoit à chaque tour de boucle une lettre allant de A à Z
			for lettre in {A..Z}
			do
				# Création de la ligne du résultat
				# grep recherche des mots d'une lettre ayant pour valeur 'lettre' dans le fichier dictionnaire, 
    			# et dès qu'il trouve un mot correspondant, il le comptabilise grâce à '-c'.
    			# Puis on affiche 'espace tiret espace la lettre' à la suite du compte
    			ligne_resultat=`grep -c $lettre $1`' - '$lettre
				#Ecriture de la ligne résultante à la suite des autres grâce à '>>' dans le fichier temporaire
    			echo $ligne_resultat >> $chemin_fichier_temporaire
    		done
    		# Affichage du fichier "resultats.txt" trié numériquement (-n) en ordre inverse (-r)
			sort -nr $chemin_fichier_temporaire
			# Suppression du fichier "resultats.txt"
			rm $chemin_fichier_temporaire
    	
    	# Sinon, si le deuxième paramètre est égal à "parlettre", alors on procède au traitement de l'affichage du nombre de lettres utilisées.
    	# Tri alpabétique de A à Z.
    	elif [ $2 = "--parlettre" ]
		then
    		# La variable lettre reçoit à chaque tour de boucle une lettre allant de A à Z
			for lettre in {A..Z}
			do
				# Création de la ligne du résultat
				# grep recherche des mots d'une lettre ayant pour valeur 'lettre' dans le fichier dictionnaire, 
	 	   		# et dès qu'il trouve un mot correspondant, il le comptabilise grâce à '-c'.
	 	   		# Puis on affiche 'la lettre espace tiret espace' devant le compte			
				ligne_resultat=$lettre' - '`grep -c $lettre $1`
				#Ecriture de la ligne résultante à la suite des autres grâce à '>>' dans le fichier temporaire
    			echo $ligne_resultat >> $chemin_fichier_temporaire
    		done
    		# Affichage du fichier "resultats.txt" trié aphabétiquement
			sort $chemin_fichier_temporaire
			# Suppression du fichier "resultats.txt"
			rm $chemin_fichier_temporaire

		# Sinon, affichage du message d'erreur concernant le deuxième paramètre
		else
			echo -e "\nLe deuxième paramètre est invalide !\n"
		fi
	fi
fi
