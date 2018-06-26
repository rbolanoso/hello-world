#!/bin/bash

# Performs a dump of target database and compresses result.
# Outputs to: $DUMPDIR/$DUMPNAME.tar.xz

# Note: Absolute paths are required for use in cron jobs

DBNAME=test
ROOTDIR=/mediastream
DUMPDIR=$ROOTDIR/dump
LOGDIR=/var/log/
TAR=`which tar`

set -o nounset
set -o errexit

mkdir -p $DUMPDIR
mkdir -p $LOGDIR

LOGFILE=$LOGDIR/mongo_backup.log
DATE=$(date +"%Y%m%d%H%M")
DUMPNAME=mongodump-$DBNAME-$DATE

echo `date '+%Y-%m-%d %H:%M:%S'` Dumping database >> $LOGFILE


# Create raw dump
mongodump --db $DBNAME --out $DUMPDIR/$DUMPNAME >> $LOGFILE

# Archive dump
$TAR -cvJf $DUMPDIR/$DUMPNAME.tar.xz -C $DUMPDIR $DUMPNAME . 2>> $LOGFILE

# Clean up working folder
rm -r $DUMPDIR/$DUMPNAME

echo "Dump complete: $DUMPNAME.tar.xz" >> $LOGFILE
echo "" >> $LOGFILE

# Echo again so will show up in cronjob email
echo "Dump complete: $DUMPNAME.tar.xz"
