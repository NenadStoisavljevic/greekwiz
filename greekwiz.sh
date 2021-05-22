#!/bin/sh

# Visit this site for more about the Greek alphabet
# https://daedalus.umkc.edu/FirstGreekBook/JWW_FGB1.html

alphabet="Letters : Name : Pronunciation
Α α : alpha : al-fa
Β β : beta : vee-ta
Γ γ : gamma : wa-mma
Δ δ : delta : thel-ta
Ε ε : epsilon : ep-si-lon
Ζ ζ : zeta : ze-ta
Η η : eta : ee-ta
Θ θ : theta : thee-ta
Ι ι : iota : yo-ta
Κ κ : kappa : ka-ppa
Λ λ : lambda : lam-tha
Μ μ : mu : me
Ν ν : nu : nee
Ξ ξ : xi : ksee
Ο ο : omicron : o-mi-kron
Π π : pi : pee
Ρ ρ : rho : ro
Σ σ/ς : sigma : si-wma
Τ τ : tau : taf
Υ υ : upsilon : eep-si-lon
Φ φ : phi : fee
Χ χ : chi : hee
Ψ ψ : psi : psee
Ω ω : omega : o-me-wa"

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
