#!/bin/sh
#
if [ -r credentials.sh ] ; then
   . ./credentials.sh
fi

[ ! -z $1 ] && SPDM_DB_HOST=$1
[ ! -z $2 ] && SPDM_DB_PORT=$2
[ ! -z $3 ] && SPDM_DB_INSTANT=$3
[ ! -z $4 ] && SPDM_DB_USER=$4
[ ! -z $5 ] && SPDM_DB_PASS=$5

echo ${PWD}
ls -l ${PWD}

ORIGFILE=${PWD}/setenv.sh

if [ -r ${ORIGFILE} ] ; then
   . ${ORIGFILE}
fi
if [ -z ${SPDM_DB_USER} ] || [ -z {SPDM_DB_PASS} ] ; then
   echo "Env SPDM_DB_USER or SPDM_DB_PASS undefined for ${SPDM_DB_HOST}:${SPDM_DB_PORT}/${SPDM_DB_INSTANT}!"
   exit
fi
echo "Updating ${ORIGFILE} with database credentials"
echo ${SPDM_DB_USER}:${SPDM_DB_PASS}@${SPDM_DB_HOST}:${SPDM_DB_PORT}/${SPDM_DB_INSTANT}
NEWFILE=./setenv.sh.new
# refresh back to original file
[ -e ${ORIGFILE}.orig ] && mv ${ORIGFILE}.orig ${ORIGFILE}
# update with your credentials
sed 's/FILEMGR_DB_USER=/FILEMGR_DB_USER='${SPDM_DB_USER}'/' ${ORIGFILE} |  \
sed 's/FILEMGR_DB_PASS=/FILEMGR_DB_PASS='${SPDM_DB_PASS}'/' | \
sed 's/DB_HOST=/DB_HOST='${SPDM_DB_HOST}'/' | \
sed 's/DB_PORT=/DB_PORT='${SPDM_DB_PORT}'/' | \
sed 's/DB_INSTANT=/DB_INSTANT='${SPDM_DB_INSTANT}'/' | \
sed 's/localhost/`hostname`/g' > ${NEWFILE}
mv ${ORIGFILE} ${ORIGFILE}.orig
mv ${NEWFILE} ${ORIGFILE}
grep DB_ ${ORIGFILE}