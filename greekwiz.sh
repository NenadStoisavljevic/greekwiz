#!/bin/sh

alphabet="Letters : Name : Pronunciation : Latin
Α α : alpha άλφα : al-fa : A a
Β β : beta βήτα : vee-ta : B b
Γ γ : gamma γάμμα : wa-mma : G g
Δ δ : delta δέλτα : thel-ta : D d
Ε ε : epsilon έψιλον : ep-si-lon : E e
Ζ ζ : zeta ζήτα : ze-ta : Z z
Η η : eta ήτα : ee-ta : h
Θ θ : theta θήτα : thee-ta : Th th
Ι ι : iota ιώτα : yo-ta : I i
Κ κ : kappa κάππα : ka-ppa : K k
Λ λ : lambda λάμδα : lam-tha : L l
Μ μ : mu μι : me : M m
Ν ν : nu νι : nee : N n
Ξ ξ : xi ξι : ksee : X x
Ο ο : omikron όμικρον : o-mi-kron : O o
Π π : pi πι : pee : P p
Ρ ρ : rho ρο : ro : R r
Σ σ/ς : sigma σίγμα : si-wma : S s
Τ τ : tau ταυ : taf : T t
Υ υ : upsilon ύψιλον : eep-si-lon : U u
Φ φ : phi φι : fee : Ph ph
Χ χ : chi χι : hee : Ch ch
Ψ ψ : psi ψι : psee : Ps ps
Ω ω : omega ωμέγα : o-me-wa : O o"

getletter() {
	# Grep the corresponding letter of the name from arg.
	letter=$(echo "$alphabet" | grep -w "$1" | cut -d ':' -f 1 | xargs)
	[ -z "$letter" ] && return 1 || printf "%s\n" "$letter"
}

getname() {
	# Grep the corresponding name of the letter from arg.
	name=$(echo "$alphabet" | grep -w "$1" | cut -d ':' -f 2 | xargs)
	[ -z "$name" ] && return 1 || printf "%s\n" "$name"
}

getphonetic() {
	# Grep the corresponding name of the letter from arg.
	phonetic=$(echo "$alphabet" | grep -w "$letter" | cut -d ':' -f 3 | xargs)
	[ -z "$phonetic" ] && return 1 || printf "%s\n" "$phonetic"
}

all() {
    for letter in $(echo "$alphabet" | cut -d ':' -f 1 | sed '1d;s/ /\n/g' | shuf);
    do
        name=$(getname "$letter")
	printf "Please give the name of %s: " "$letter"; read -r user
	[ -z "$user" ] && lower="empty" || lower=$(echo "$user" | tr '[:upper:]' '[:lower:]')
	[ "$lower" = "$(echo "$name" | grep -ow "$lower")" ] && printf "You are correct.\n" || printf "Ughh, the correct name was: %s\n" "$name"
    done }

vowels() {
    for vowel in $(echo "α:ε:η:ι:υ:ο:ω" | sed 's/:/\n/g' | shuf);
    do
        name=$(getname "$vowel")
	printf "Please give the name of %s: " "$vowel"; read -r user
	[ -z "$user" ] && lower="empty" || lower=$(echo "$user" | tr '[:upper:]' '[:lower:]')
	[ "$lower" = "$(echo "$name" | grep -ow "$lower")" ] && printf "You are correct.\n" || printf "Ughh, the correct name was: %s\n" "$name"
    done }

consonants() {
    for consonant in $(echo "β:γ:δ:ζ:θ:κ:λ:μ:ν:ξ:π:ρ:σ:τ:φ:χ:ψ" | sed 's/:/\n/g' | shuf);
    do
        name=$(getname "$consonant")
	printf "Please give the name of %s: " "$consonant"; read -r user
	[ -z "$user" ] && lower="empty" || lower=$(echo "$user" | tr '[:upper:]' '[:lower:]')
	[ "$lower" = "$(echo "$name" | grep -ow "$lower")" ] && printf "You are correct.\n" || printf "Ughh, the correct name was: %s\n" "$name"
    done }

phonetics() {
    for letter in $(echo "$alphabet" | cut -d ':' -f 1 | sed '1d;s/ /\n/g' | shuf);
    do
        phonetic=$(getphonetic "$letter")
        printf "%s is pronounced as %s.\n" "$letter" "$phonetic"
	sleep 3
    done }

dmenugreek() {
	selected=$(echo "$alphabet" | cut -d ' ' -f 1-4 | sed '1d' | dmenu -i -l 30 | cut -d ' ' -f 1-2)
	[ -z "$selected" ] && exit 1

	printf "%s" "$selected" | xclip -selection clipboard && notify-send "'$selected' copied to clipboard."
}

search() {
	lower=$(echo "$term" | tr '[:upper:]' '[:lower:]') && item=$(echo "$alphabet" | grep -ow "$lower")
	[ -z "$item" ] && printf "Does not exist.\n" && exit 1 || size=${#term}

	if [ "$size" = "2" ]; then
		name=$(getname "$item")
		printf "The name of %s is: %s.\n" "$item" "$name"
	else
		letter=$(getletter "$item")
		printf "The letters of %s are: %s.\n" "$item" "$letter"
	fi }

while getopts ":avcpms:l" o; do case "${o}" in
	a) all ;;
	v) vowels ;;
	c) consonants ;;
	p) phonetics ;;
	m) dmenugreek ;;
	s) term="$OPTARG" && search ;;
	l) echo "$alphabet" | column -ts ':' | less ;;
	*) echo "greekwiz: learn the ancient Greek alphabet straight from the
command line, including offline availability.

Options:
  -a		Practice studying all the letters of the Greek alphabet (24)
  -v		Learn only the vowels of the Greek alphabet (7)
  -c		Learn only the consonants of the Greek alphabet (17)
  -p		Learn the correct pronunciation of the Greek letters
  -m		Get a menu of Greek letters to copy
  -s		Search for the equivalents of either names or letters
  -l		Print a table of the form, phonetic value, and name" && exit 1

esac done
