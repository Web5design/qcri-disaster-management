#!/bin/bash

CSV2RDF4LOD_HOME=${CSV2RDF4LOD_HOME:?"not set; source csv2rdf4lod/source-me.sh or see https://github.com/timrdf/csv2rdf4lod-automation/wiki/CSV2RDF4LOD-not-set"}

delete=""
#if [ ! -e publish/--2013-Apr-04.nt ]; then
#  delete="publish/--2013-Apr-04.nt"
#  if [ -e publish/--2013-Apr-04.nt.gz ]; then
#    gunzip -c publish/--2013-Apr-04.nt.gz > publish/--2013-Apr-04.nt
#  elif [ -e publish/--2013-Apr-04.ttl ]; then
#    echo "cHuNking publish/--2013-Apr-04.ttl into publish/--2013-Apr-04.nt; will delete when done lod-mat'ing"
#    $CSV2RDF4LOD_HOME/bin/util/bigttl2nt.sh publish/--2013-Apr-04.ttl > publish/--2013-Apr-04.nt
#  elif [ -e publish/--2013-Apr-04.ttl.gz ]; then
#    gunzip -c publish/--2013-Apr-04.ttl.gz > publish/--2013-Apr-04.ttl
#    echo "cHuNking publish/--2013-Apr-04.ttl into publish/--2013-Apr-04.nt; will delete when done lod-mat'ing"
#    $CSV2RDF4LOD_HOME/bin/util/bigttl2nt.sh publish/--2013-Apr-04.ttl > publish/--2013-Apr-04.nt
#    rm publish/--2013-Apr-04.ttl
#  else
#    echo publish/--2013-Apr-04.nt, publish/--2013-Apr-04.nt.gz, publish/--2013-Apr-04.ttl, or publish/--2013-Apr-04.ttl.gz needed to lod-materialize.
#    delete=""
#    exit 1
#  fi
#fi
load_file=""
if [ -e     "publish/--2013-Apr-04.nt" ]; then
  load_file="publish/--2013-Apr-04.nt"
elif [ -e   "publish/--2013-Apr-04.ttl" ]; then
  load_file="publish/--2013-Apr-04.ttl"
elif [ -e   "publish/--2013-Apr-04.ttl.gz" ]; then
  load_file="publish/--2013-Apr-04.ttl"
  gunzip -c  publish/--2013-Apr-04.ttl.gz > publish/--2013-Apr-04.ttl
     delete="publish/--2013-Apr-04.ttl"
elif [ -e   "publish/--2013-Apr-04.nt.gz" ]; then
  load_file="publish/--2013-Apr-04.nt"
  gunzip -c  publish/--2013-Apr-04.nt.gz > publish/--2013-Apr-04.nt
     delete="publish/--2013-Apr-04.nt"
fi

mkdir publish/tdb                         &> /dev/null
rm    publish/tdb/*.dat publish/tdb/*.idn &> /dev/null

if [[ ${#load_file} -eq 0 ]]; then
   echo "[ERROR] `basename $0 `could not find dump file to load."
   exit 1
fi
echo `basename $load_file` into publish/tdb as 
  Working directory does not appear to be a dataset. You can run this from a dataset.
  (e.g. $whatever/source/mySOURCE/myDATASET/).

  Working directory does not appear to be a directory of versions. You can run this from a directory of versions.
  (e.g. $whatever/source/mySOURCE/myDATASET/version/).

  Working directory does not appear to be a conversion cockpit.
  You can run this from a conversion cockpit.
  (e.g. $whatever/source/mySOURCE/myDATASET/version/VVV/). >> publish/ng.info

#if [[ ! `which tdbloader` ]]; then
#   echo "ERROR: tdbloader not found."
#   exit
#fi
if [[ $load_file == "publish/--2013-Apr-04.ttl" && "`too-big-for-rapper.sh`" == "yes" ]]; then
  dir="publish"
  echo "cHuNking publish/--2013-Apr-04.ttl in $dir"
  rm $dir/cHuNk*.ttl &> /dev/null
  ${CSV2RDF4LOD_HOME}/bin/split_ttl.pl $load_file
  for cHuNk in $dir/cHuNk*.ttl; do
    echo giving $cHuNk to tdbloader
    tdbloader --loc=publish/tdb --graph=`cat publish/--2013-Apr-04.nt.graph` $cHuNk
    rm $cHuNk
  done
else
  tdbloader --loc=publish/tdb --graph=`cat publish/--2013-Apr-04.nt.graph` $load_file
fi

if [ ${#delete} -gt 0 ]; then
   rm $delete
fi
