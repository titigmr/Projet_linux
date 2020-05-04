
touch $HOME/.todo_list
TACHES=$HOME/.todo_list

bold=$(tput bold)
normal=$(tput sgr0)

function todo() {

	# Argument list
	case $1 in  
	"list")
		shift
		if [ -z $1 ]
		then
			nl -s " - " $TACHES

		else 
			search=$@
			grep -n -i --color "$search" $TACHES
		fi
		;;

	# Argument add
	"add")
		shift
		n=$1

		# Test d'un nombre et affiche un warning concernant le nombre max de lignes s'il est dépassé
		if [[ $n =~ ^[0-9]+$ ]]
		then
			nbLines=$(cat -n $TACHES | tail -n 1 | cut -f1 | xargs)
			
			if (( "$n" >= "$nbLines" ))
			then 
				n=$(($nbLines + 1))
				echo "${bold}Attention${normal} : le dernier film est en position $n."
			fi

			# permet de gérer l'erreur concernant : head -0
			touch tmp 
			if ! [[ $n == 1 ]]
			then 
				head -$(($n-1)) $TACHES > tmp
			fi
			shift

			# Demande une chaine de caractère comme second argument
			if [[ -z $@ ]]
			then
				echo "Veuillez spécifier le titre du film."
			else 

			# Ajoute le film lorsque les conditions sont remplies
			echo $@ >> tmp
			tail -n +"$(($n))" $TACHES >> tmp
			mv tmp $TACHES
			echo "Le film ${bold}$@${normal} a été ajouté en position $n."
			fi
		
		else 
			echo "Veuillez spécifier la position du film comme premier argument."
		fi
		;;


	# Argument done
	"done")
		shift
		n="$1"

		# Test d'un nombre et vérifie que le numéro du film est comprise dans la liste
		if [[ $n =~ ^[0-9]+$ ]]
		then
			nbLines=$(cat -n $TACHES | tail -n 1 | cut -f1 | xargs)

			if (( "$n" <= "$nbLines" ))
			then
				
				# Demande une confirmation pour retirer le film
				elem=$(sed -n "$n"p $TACHES)
				
				while true 
				do
				read -p "Voulez-vous supprimer le film ${bold}$elem${normal} (yes/no) ? " response

				case $response in 
				yes)
					touch tmp
					if ! [[ $n == 1 ]]
					then 
						head -$(($n-1)) $TACHES > tmp
					fi
					
					tail -n +"$(($n+1))" $TACHES >> tmp
					mv tmp $TACHES
					echo "Le film ${bold}$elem${normal} a été vu."
					break
					;;
				no) 
					break
					;;
				*) 
					;;
				esac
				done
				
			else
				echo "La liste possède $nbLines élements."
			fi

		# Argument pour retirer toute la liste
		elif [[ $n == "all" ]]
		then
			while true 
			do
			read -p "Voulez-vous supprimer ${bold}TOUS${normal} les films (yes/no) ? " response

			case $response in 
				yes)
					touch tmp
					mv tmp $TACHES
					echo "Tous les films ont été vu."
					break
					;;
				no) 
					break
					;;
				*) 
					;;
				esac
			done
		else 
			echo "L'argument $n n'est pas un nombre."
		fi
		;;


	# Argument import 
	"import")
		shift
		if [[ -f "$@" ]]
		then
			cat "$@" > "$HOME/.todo_list"
		else
			echo "Le fichier n'est pas valide."
		fi
		;;


	# Argument help
	"help")
		echo -e "
	${bold}DESCRIPTION ${normal}

		La fonction ${bold}todo${normal} permet de gérer une liste de films. 
		Les options suivantes sont disponibles : 

		- ${bold}list [recherche]${normal}
			Affiche la liste des films en cours à
			partir de la chaîne de caractère en argument. 
			Si aucune chaîne de caractère n'est renseignée, 
			renvoie la liste de films entière.

		- ${bold}add [numéro de la tâche] [chaine de caractère]${normal}
			Ajoute un film à la liste. Nécessite de spécifier 
			en argument sa position (1) et son titre (2).

		- ${bold}done [numéro de la tâche] | [all]${normal}	
			Supprime un film de la liste à partir de 
			sa position. L'argument [all] permet de supprimer
			tous les films en cours.

		- ${bold}import [chemin du fichier]${normal}
			Utilise un fichier à partir de son chemin 
			comme nouvelle liste de films.
		"
		;;
	*)
		echo -e "\n${bold}Attention –${normal} Usage : todo (list|add|done|import|help) [args]\n"

esac
}

echo -e "Ne pas oublier de mettre le fichier en source : ${bold}source ./todo.sh${normal}
Pour utiliser la fonction : ${bold}todo [arg]${normal}"

