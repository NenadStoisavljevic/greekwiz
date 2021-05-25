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

getletter() {
	# Grep the corresponding letter of the name from arg.
	letter=$(echo "$alphabet" | grep -w "$1" | cut -d ':' -f 1 | xargs)
	[ -z "$letter" ] && return 1 || printf "%s\n" "$letter"
}

getname() {
	# Grep the corresponding name of the letter from arg.
	name=$(echo "$alphabet" | grep -w "$1" | cut -d ':' -f 2 | xargs)
	[ -z "$letter" ] && return 1 || printf "%s\n" "$name"
}

all() {
    for letter in $(echo "$alphabet" | cut -d ':' -f 1 | sed '1d;s/ /\n/g' | shuf);
    do
        name=$(getname "$letter")
	printf "Please give the name of %s: " "$letter"; read -r user
	[ -z "$user" ] && lower="incorrect" || lower=$(echo "$user" | tr '[:upper:]' '[:lower:]')
	[ "$lower" = "$(echo "$name" | grep -ow "$lower")" ] && printf "You are correct.\n" || printf "Ughh, the correct name was %s.\n" "$name"
    done }

vowels() { \
    for vowel in $(echo "α:ε:η:ι:υ:ο:ω" | sed 's/:/\n/g' | shuf);
    do
	# Grep the corresponding name of each vowel from the for loop.
	name=$(echo "$alphabet" | grep -w "$vowel" | cut -d ':' -f 2 | xargs)

	printf "Please give the name of %s: " "$vowel"; read -r guess
	user=$(echo "$guess" | tr '[:upper:]' '[:lower:]')
	[ "$user" =  "$name" ] && printf "You are correct.\n" || printf "Ughh, the correct name was %s.\n" "$name"
    done }

consonants() { \
    for consonant in $(echo "β:γ:δ:ζ:θ:κ:λ:μ:ν:ξ:π:ρ:σ:τ:φ:χ:ψ" | sed 's/:/\n/g' | shuf);
    do
	# Grep the corresponding name of each consonant from the for loop.
	name=$(echo "$alphabet" | grep -w "$consonant" | cut -d ':' -f 2 | xargs)

	printf "Please give the name of %s: " "$consonant"; read -r guess
	user=$(echo "$guess" | tr '[:upper:]' '[:lower:]')
	[ "$user" =  "$name" ] && printf "You are correct.\n" || printf "Ughh, the correct name was %s.\n" "$name"
    done }

phonetics() { \
    for letter in $(echo "$alphabet" | cut -d ':' -f 1 | sed '1d;s/ /\n/g' | shuf);
    do
        phonetic=$(echo "$alphabet" | grep -w "$letter" | cut -d ':' -f 3 | xargs)
        printf "%s is pronounced as %s.\n" "$letter" "$phonetic"
	sleep 3
    done }

search() { \
	item=$(echo "$alphabet" | grep -w "$term")
	[ -z "$item" ] && printf "Does not exist.\n" && exit 1

	size=${#term}
	if [ "$size" = "2" ]; then
		name=$(echo "$alphabet" | grep -w "$term" | cut -d ':' -f 2 | xargs)
		printf "The name of %s is: %s.\n" "$term" "$name"
	else
		letter=$(echo "$alphabet" | grep -w "$term" | cut -d ':' -f 1 | xargs)
		printf "The letters of %s are: %s.\n" "$term" "$letter"
	fi }

while getopts ":avcps:l" o; do case "${o}" in
	a) all ;;
	v) vowels ;;
	c) consonants ;;
	p) phonetics ;;
	s) term="$OPTARG" && search ;;
	l) echo "$alphabet" | column -ts ':' | less ;;
	*) echo "greekwiz: learn the ancient Greek alphabet straight from the
command line, including offline availability.

Options:
  -a		Practice studying all the letters of the Greek alphabet (24)
  -v		Learn only the vowels of the Greek alphabet (7)
  -c		Learn only the consonants of the Greek alphabet (17)
  -p		Learn the correct pronunciation of the Greek letters
  -s		Search for the equivalents of either names or letters
  -l		Print a table of the form, phonetic value, and name" && exit 1

esac done
