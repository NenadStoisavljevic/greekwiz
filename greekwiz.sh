#!/bin/sh

alphabet="Letters : Name : Pronunciation
Α α : alpha άλφα : al-fa
Β β : beta βήτα : vee-ta
Γ γ : gamma γάμμα : wa-mma
Δ δ : delta δέλτα : thel-ta
Ε ε : epsilon έψιλον : ep-si-lon
Ζ ζ : zeta ζήτα : ze-ta
Η η : eta ήτα : ee-ta
Θ θ : theta θήτα : thee-ta
Ι ι : iota ιώτα : yo-ta
Κ κ : kappa κάππα : ka-ppa
Λ λ : lambda λάμδα : lam-tha
Μ μ : mu μι : me
Ν ν : nu νι : nee
Ξ ξ : xi ξι : ksee
Ο ο : omikron όμικρον : o-mi-kron
Π π : pi πι : pee
Ρ ρ : rho ρο : ro
Σ σ/ς : sigma σίγμα : si-wma
Τ τ : tau ταυ : taf
Υ υ : upsilon ύψιλον : eep-si-lon
Φ φ : phi φι : fee
Χ χ : chi χι : hee
Ψ ψ : psi ψι : psee
Ω ω : omega ωμέγα : o-me-wa"

all() { \
    for letter in $(echo "$alphabet" | cut -d ':' -f 1 | sed '1d;s/ /\n/g' | shuf);
    do
	# Grep the corresponding name of each letter from the for loop.
	name=$(echo "$alphabet" | grep "$letter" | cut -d ':' -f 2 | xargs)

	printf "Please give the name of %s: " "$letter"; read -r guess
	user=$(echo "$guess" | tr '[:upper:]' '[:lower:]')
	[ "$user" =  "$name" ] && printf "You are correct.\n" || printf "Ughh, the correct name was %s.\n" "$name"
    done; }

vowels() { \
    for vowel in $(echo "α:ε:η:ι:ο:υ:ω" | sed 's/:/\n/g' | shuf);
    do
	# Grep the corresponding name of each vowel from the for loop.
	name=$(echo "$alphabet" | grep "$vowel" | cut -d ':' -f 2 | xargs)

	printf "Please give the name of %s: " "$vowel"; read -r guess
	user=$(echo "$guess" | tr '[:upper:]' '[:lower:]')
	[ "$user" =  "$name" ] && printf "You are correct.\n" || printf "Ughh, the correct name was %s.\n" "$name"
    done; }

pron() { \
    for dip in $(echo "$dipthongs" | cut -d ':' -f 1 | sed 's/,/\n/g' | shuf);
    do
        pron=$(echo "$dipthongs" | grep "$dip" | cut -d ':' -f 2 | xargs)
        printf "%s is pronounced as %s.\n" "$dip" "$pron"
	printf "Would you like to continue? [y/N]\n"; read -r choice
	while true; do
            case $choice in
	        [Yy]*) break;;
	        [Nn]*) exit 0;;
	        *) printf "Invalid, please try again.\n"; read -r choice;;
            esac
	done
    done; }

list() { \
    echo "$alphabet" | sed 's/:/	/g' | less; }

case "$1" in
	all) all;;
	vowels) vowels;;
	consonants) consonants;;
	ls ) list;;
	*) cat << EOF
greekwiz: learn the ancient Greek alphabet straight from the
command line, including offline availability.

Options:
  all		Practice studying all the letters of the Greek alphabet (24)
  vowels	Learn only the vowels of the Greek alphabet (7)
  dipthongs	Practice prounouncing the dipthongs (8 with 3 improper)
  ls		Print a table of the form, phonetic value, and name
  all else	Print this message
EOF
esac
