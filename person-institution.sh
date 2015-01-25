#!sh

ENDPOINT=http://ff-dev.ontotext.com/sparql

# reverse sort, to keep the header line (?x ?name) on top

curl --data-urlencode query@person-institution-1-namesGenderNote.rq -Haccept:text/tab-separated-values $ENDPOINT | sort -r > person-institution-1-namesGenderNote.tsv
curl --data-urlencode query@person-institution-2-profession.rq      -Haccept:text/tab-separated-values $ENDPOINT | sort -r > person-institution-2-profession.tsv
curl --data-urlencode query@person-institution-3-nationality.rq     -Haccept:text/tab-separated-values $ENDPOINT | sort -r > person-institution-3-nationality.tsv
curl --data-urlencode query@person-institution-4-birth.rq           -Haccept:text/tab-separated-values $ENDPOINT | sort -r > person-institution-4-birth.tsv
curl --data-urlencode query@person-institution-5-death.rq           -Haccept:text/tab-separated-values $ENDPOINT | sort -r > person-institution-5-death.tsv

wc -l *.tsv

# comment this out if you're on unix not dos
conv --dos2unix person-institution-1-namesGenderNote.tsv
conv --dos2unix person-institution-2-profession.tsv     
conv --dos2unix person-institution-3-nationality.tsv    
conv --dos2unix person-institution-4-birth.tsv          
conv --dos2unix person-institution-5-death.tsv          

join -a1 -t '	' person-institution-1-namesGenderNote.tsv person-institution-2-profession.tsv \
  | join -a1 -t '	' - person-institution-3-nationality.tsv \
  | join -a1 -t '	' - person-institution-4-birth.tsv \
  | join -a1 -t '	' - person-institution-5-death.tsv > person-institution.tsv

wc -l person-institution.tsv
