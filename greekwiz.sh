#!/bin/sh

# Visit this site for more about the Greek alphabet
# https://daedalus.umkc.edu/FirstGreekBook/JWW_FGB1.html

alphabet="Form : Name : Phonetic Value
Α α : alpha : papa, father
Β β : beta : bed
Γ γ : gamma : go, sing
Δ δ : delta : do
Ε ε : epsilon : met
Ζ ζ : zeta : adze
Η η : eta : prey
Θ θ : theta : thin
Ι ι : iota : pin, machine
Κ κ : kappa : kill
Λ λ : lambda : land
Μ μ : mu : men
Ν ν : nu : now
Ξ ξ : xi : wax
Ο ο : omicron : obey
Π π : pi : pet
Ρ ρ : rho : run
Σ σ/ς : sigma : sit
Τ τ : tau : tell
Υ υ : upsilon : French u, German ό
Φ φ : phi : graphic
Χ χ : chi : German buch
Ψ ψ : psi : hips
Ω ω : omega : tone"

dipthongs="αι : aisle
αυ : ou in hour
ει : eight
υι : quit
οι : oil
ου : group
ευ : ĕh-oo
ηυ : ĕh-oo"

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
    for vowel in $(echo "α:ε:η:ι:ο:ω:υ" | sed 's/:/\n/g' | shuf);
    do
	# Grep the corresponding name of each vowel from the for loop.
	name=$(echo "$alphabet" | grep "$vowel" | cut -d ':' -f 2 | xargs)

	printf "Please give the name of %s: " "$vowel"; read -r guess
	user=$(echo "$guess" | tr '[:upper:]' '[:lower:]')
	[ "$user" =  "$name" ] && printf "You are correct.\n" || printf "Ughh, the correct name was %s.\n" "$name"
    done; }

dipthongs() { \
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
	dipthongs ) dipthongs;;
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
