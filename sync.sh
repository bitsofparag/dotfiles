#!/bin/bash

# Invoke rsync directly
# If using SSH, add:
#   -e "ssh -T -c none -o Compression=no -x"

if [ $# -ne 3 ]; then
    echo "Error: not enough arguments!"
    echo "Usage is: $0 r_src r_dest r_logfile"
    exit 2
fi

R_SRC=$1
R_DEST=$2
R_LOGFILE=$3

# Options:

R_OPTIONS="-rltgoDhv --inplace --progress --log-file="${R_LOGFILE}

# Files to exclude:

R_EXCLUDE="--exclude={'.git','*.log','*.env','build','dist','*.egg*','Thumbs.db'} --exclude='sync.log'"

echo "+---------------------------------------------------------------------------------" | tee -a "${R_LOGFILE}"
echo "+ $(date): Copy $R_SRC to $R_DEST" | tee -a "${R_LOGFILE}"
echo "+---------------------------------------------------------------------------------" | tee -a "${R_LOGFILE}"
rsync ${R_OPTIONS} ${R_EXCLUDE} ${R_SRC} ${R_DEST}
echo "+ $(date) Sync completed" | tee -a "${R_LOGFILE}"
exit
