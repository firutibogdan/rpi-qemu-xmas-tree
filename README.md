
FIRUTI Bogdan-Cristian 341C3


!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!! Disclaimer !!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!   In momentul rularii se va bloca terminalul     !!
!! curent si se va deschide o fereastra de tip      !!
!! ncurses in care va boot-a sistemul. Abia         !!
!! dupa introducerea, in pagina web care se gaseste !!
!! la adresa (tema2.local) in browser, a unui brad  !!
!! acesta va fi afisat.                             !!
!!   In plus, pagina web va fi afisata dupa ce va   !!
!! termina script-ul Python de initializat si pe    !!
!! ecran va aparea o line care contine textul       !!
!! "0.0.0.0/80".                                    !!
!!    Dureaza cateva secunde tot procesul de init   !!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


Tema 2 SI


    Ierarhia solutiei:
    
    -- Tema2SI
        -- added_files (folder ce contine toate modificarile fata de git-ul oficial)
            -- poky 
                -- build  (folder-ul de build)
                -- meta  (am adaugat aici dependintele de care aveam nevoie pentru flask)
                -- meta-custom  (este un layer adaugat de mine care contine script-urile)
                -- meta-raspberrypi (contine fisierul pentru hostname)

        -- scripts
            -- bash-start.sh  (script-ul din /etc/init.d rulat la boot-are)
            -- bash-xtree.sh  (parser-ul pentru a afisa culorile)
            -- python-helloworld.py  (script-ul Python care afiseaza interfata web)

        -- trees  (fisiere de test din enunt)
            -- tree0
            -- tree1
            -- tree2
            -- tree3

        -- bridge_14.04.sh  (script de configurare bridge Ubuntu 14)
        -- bridge_18.04.sh  (script de configurare bridge Ubuntu 18)
        -- launch.sh  (script de rulare)
        -- rpi-basic-image.img  (imaginea creata)
        -- zImage (imaginea de Kernel)
        -- README


    Pentru inceput, am pornit de la laboratoare si am urmat pasii din enunt
pentru a putea sa descarc Yocto si Qemu.
    Primul pas a fost sa creez imaginea basic si acesteia sa ii adaug
imbunatatiri. Imediat ce am avut imaginea basic si am putut sa o rulez,
am adaugat in build/conf/local.conf cateva linii (40-54) care sa ma ajute
sa realizez task-urile.
    Pentru a adauga parola "labsi", user-ului "root" am folosit:
        INHERIT += "extrausers"
        EXTRA_USERS_PARAMS = "usermod -P labsi root;"
    
    SSH-ul era deja configurat (dupa cum s-a mentionat si pe forum), din
imaginea basic.

    Pentru DHCP, am adaugat linia:
        ETH0_MODE = "dhcp"
care imi seteaza dhcp pe ETH0. (De asemenea, am observat ca din imaginea
basic se face dhcp automat)

    Urmatorul pas a fost sa adaug noi functionalitati, printre care avahi,
pagina web si parser-ul pentru fisiere. Pe langa mentionarea serviciului
avahi-daemon in build/conf/local.conf, am daugat un fisier numit hostname
in meta-raspberrypi/recipes-core/base-files/base-files pentru a configura
numele "tema2.local".

    Pentru a avea o pagina de web unde utilizatorul sa incarce reprezentarea
unui brad, am folosit Python3 si Flask. Am ales Flask deoarece este foarte
simplu de folosit. Astfel, am setat ca la ruta default ("/"), sa intoarca
un formular in care utilizatorul sa puna reprezentarea. Pentru a crea pagina
am folosit HTML si CSS. Astfel, am creat un formular mai prietenos. In 
momentul in care se apasa pe "Submit", datele sunt preluate din formular
si scris intr-un fisier numit "tree.txt" din "/". Sunt scrise aici pentru
a putea fi gasite de parser.

    Parser-ul este un script in Bash care citeste fisierul "tree.txt" si,
in functie de caracter, seteaza o variabila pentru a sti ce culoare sa
dea acelei bucati din brad. Pentru a colora ecranul, am incercat sa folosesc
atat biblioteca din Python, cat si utilitarul tput, insa bradul nu era 
desenat complet. Am gasit in mediul online faptul ca pot folosi printf si
asta am si facut.

    Script-ul bash-start este pus in etc/init.d pentru a fi rulat in
momentul in care sistemul boot-eaza. Astfel, dau drumul parser-ului si
a scriptului Python cu Flask si le trimit in background.