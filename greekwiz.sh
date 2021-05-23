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
    for vowel in $(echo "α:ε:η:ι:υ:ο:ω" | sed 's/:/\n/g' | shuf);
    do
	# Grep the corresponding name of each vowel from the for loop.
	name=$(echo "$alphabet" | grep "$vowel" | cut -d ':' -f 2 | xargs)

	printf "Please give the name of %s: " "$vowel"; read -r guess
	user=$(echo "$guess" | tr '[:upper:]' '[:lower:]')
	[ "$user" =  "$name" ] && printf "You are correct.\n" || printf "Ughh, the correct name was %s.\n" "$name"
    done; }

consonants() { \
    for consonant in $(echo "β:γ:δ:ζ:θ:κ:λ:μ:ν:ξ:π:ρ:σ:τ:φ:χ:ψ" | sed 's/:/\n/g' | shuf);
    do
	# Grep the corresponding name of each vowel from the for loop.
	name=$(echo "$alphabet" | grep "$consonant" | cut -d ':' -f 2 | xargs)

	printf "Please give the name of %s: " "$consonant"; read -r guess
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
	        [Yy]*) break ;;
	        [Nn]*) exit 0 ;;
	        *) printf "Invalid, please try again.\n"; read -r choice ;;
            esac
	done
    done; }

list() { \
    echo "$alphabet" | sed 's/:/	/g' | less; }

gwinfo() { cat << EOF
greekwiz: learn the ancient Greek alphabet straight from the
command line, including offline availability.

Options:
  -a		Practice studying all the letters of the Greek alphabet (24)
  -v		Learn only the vowels of the Greek alphabet (7)
  -c		Learn only the consonants of the Greek alphabet (17)
  -l		Print a table of the form, phonetic value, and name
EOF
}

while getopts "avcl" o; do case "${o}" in
	a) all || exit 1 ;;
	v) vowels || exit 1 ;;
	c) consonants || exit 1 ;;
	l) list || exit 1 ;;
	*) gwinfo; exit 1 ;;
esac done
