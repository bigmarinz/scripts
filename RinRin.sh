#!/bin/bash
# 
# RinRin.sh
# Daniele Marinello <marinz at email dot it>
# v 0.1
#
# Rinomina i file di una serie televisiva nel formato <stagione>x<puntata>, es: 1x01 1x02...
# oppure nel formato s01e01 s01e02...


# parametri da editare:

stagione=1               # numero della stagione, es: "s01" or "1"
estensione=avi          # estensione dei filmati

# -------------------------

#don't edit:
#
#
delimitatore_it=x;     # eg: 1x01 
delimitatore_en=e;   # eg: s01e01

# ---


if [ -f lista_mv ]; then
    rm lista_mv
fi

zero=0; i=1;
var=$(ls | grep $delimitatore_it$zero$i);

if [ "$var" != "" ]; then
        delimitatore=$delimitatore_it;
else

        var=$(ls | grep $delimitatore_en$zero$i);

        if [ "$var" != "" ]; then
                delimitatore=$delimitatore_en;
        else
                echo "delimitatore non riconosciuto" && read temp
                exit
        fi              
fi   

echo mv \"$var\" \"$stagione$delimitatore$zero$i.$estensione\" >> lista_mv
let "i+=1"; 
next=$(ls | grep $delimitatore$zero$i);    

while [ "$next" != "" ]
do   
        if [ "$i" -gt "9" ]; then 
                echo mv \"$next\" \"$stagione$delimitatore$i.$estensione\" >> lista_mv
                let "i+=1";     
                next=$(ls | grep $delimitatore$i);
        else if [ "$i" -lt "9" ]; then 
                echo mv \"$next\" \"$stagione$delimitatore$zero$i.$estensione\" >> lista_mv
                let "i+=1";     
                next=$(ls | grep $delimitatore$zero$i);
        else
                echo mv \"$next\" \"$stagione$delimitatore$zero$i.$estensione\" >> lista_mv
                let "i+=1";     
                next=$(ls | grep $delimitatore$i);
        fi
        fi
done

echo "Verranno rinominati i file in questo modo:"
echo "-----------------------------------------------"
cat lista_mv
echo "Vuoi continuare? (s/n)"
read sel
case $sel in
s)
       bash lista_mv
       rm lista_mv
;;
n)
        exit
;;
esac
