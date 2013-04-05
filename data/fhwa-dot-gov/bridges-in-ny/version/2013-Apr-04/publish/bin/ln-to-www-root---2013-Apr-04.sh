#!/bin/bash
#
# run from Not recognized; see https://github.com/timrdf/csv2rdf4lod-automation/wiki/Directory-Conventions
#
# CSV2RDF4LOD_PUBLISH_LOD_MATERIALIZATION_WWW_ROOT
# was 
# 
# when this script was created. 

wwwroot=$CSV2RDF4LOD_PUBLISH_VARWWW_ROOT
if [ -z "$wwwroot" ]; then
  wwwroot=$CSV2RDF4LOD_PUBLISH_LOD_MATERIALIZATION_WWW_ROOT
fi
if [ -z "$wwwroot" ]; then
  echo "wwwroot not defined."
  exit 1
fi

verbose="no"
if [[ "$1" == "-v" ]]; then
  verbose="yes"
  shift
fi

symbolic=""
pwd=""
if [[ "$1" == "-s" || "$CSV2RDF4LOD_PUBLISH_VARWWW_LINK_TYPE" == "soft" ]]; then
  symbolic="-sf "
  pwd=`pwd`/
  shift
fi

sudo="sudo"
if [ `whoami` == root ]; then
   sudo=""
elif [[ "`stat --format=%U "$wwwroot/source"`" == `whoami` ]]; then
   sudo=""
fi

file="file"

##################################################
# Link all original files from the /file/ directory structure to the web directory.
# (these are from source/)
if [ -e "source/NY12.txt.csv" ]; then 
   wwwfile="$wwwroot/source//file//version/2013-Apr-04/source/NY12.txt.csv"
   if [ -e $wwwfile ]; then 
     $sudo rm -f $wwwfile
   else
     $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic "${pwd}source/NY12.txt.csv" "$wwwfile"
else
   echo "  -- source/NY12.txt.csv omitted --"
fi

if [ -e "source/NY12.txt.csv.pml.ttl" ]; then
   wwwfile="$wwwroot/source//file//version/2013-Apr-04/source/NY12.txt.csv.pml.ttl"
   if [ -e "$wwwfile" ]; then 
     $sudo rm -f $wwwfile
   else
     $sudo mkdir -p `dirname "$wwwfile"`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic "${pwd}source/NY12.txt.csv.pml.ttl" "$wwwfile"
else
   echo "  -- source/NY12.txt.csv.pml.ttl omitted --"
fi

##################################################
# Link all INPUT CSV files from the /file/ directory structure to the web directory.
# (this could be from manual/ or source/
if [ -e "source/NY12.txt.csv" ]; then 
   wwwfile="$wwwroot/source//file//version/2013-Apr-04/source/NY12.txt.csv"
   if [ -e "$wwwfile" ]; then 
      $sudo rm -f "$wwwfile"
   else
      $sudo mkdir -p `dirname "$wwwfile"`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic "${pwd}source/NY12.txt.csv" "$wwwfile"
else
   echo "  -- source/NY12.txt.csv omitted --"
fi

##################################################
# Link all raw and enhancement PARAMETERS from the file directory structure to the web directory.
#
if [ -e "automatic/NY12.txt.csv.raw.params.ttl" ]; then 
   wwwfile="$wwwroot/source//file//version/2013-Apr-04/automatic/NY12.txt.csv.raw.params.ttl"
   if [ -e "$wwwfile" ]; then 
     $sudo rm -f "$wwwfile"
   else
     $sudo mkdir -p `dirname "$wwwfile"`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic "${pwd}automatic/NY12.txt.csv.raw.params.ttl" "$wwwfile"
else
   echo "  -- automatic/NY12.txt.csv.raw.params.ttl omitted --"
fi

if [ -e "manual/NY12.txt.csv.e1.params.ttl" ]; then 
   wwwfile="$wwwroot/source//file//version/2013-Apr-04/manual/NY12.txt.csv.e1.params.ttl"
   if [ -e "$wwwfile" ]; then 
     $sudo rm -f "$wwwfile"
   else
     $sudo mkdir -p `dirname "$wwwfile"`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic "${pwd}manual/NY12.txt.csv.e1.params.ttl" "$wwwfile"
else
   echo "  -- manual/NY12.txt.csv.e1.params.ttl omitted --"
fi

##################################################
# Link all PROVENANCE files that describe how the input CSV files were obtained.
#
if [ -e "source/NY12.txt.csv.pml.ttl" ]; then 
   wwwfile="$wwwroot/source//file//version/2013-Apr-04/source/NY12.txt.csv.pml.ttl"
   if [ -e "$wwwfile" ]; then
     $sudo rm -f "$wwwfile"
   else
     $sudo mkdir -p `dirname "$wwwfile"`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic "${pwd}source/NY12.txt.csv.pml.ttl" "$wwwfile"
else
   echo "  -- source/NY12.txt.csv.pml.ttl omitted --"
fi

##################################################
# Link all bundled RDF output files from the source/.../file directory structure to the web directory.
#
dump=--2013-Apr-04.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then 
   if [ -e $wwwfile.gz ]; then
    $sudo rm -f $wwwfile.gz
   else
     $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- full ttl omitted -- "
fi

dump=--2013-Apr-04.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then 
   if [ -e $wwwfile.gz ]; then
    $sudo rm -f $wwwfile.gz
   else
     $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- full nt omitted -- "
fi

dump=--2013-Apr-04.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then 
   if [ -e $wwwfile.gz ]; then
    $sudo rm -f $wwwfile.gz
   else
     $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- full rdf omitted -- "
fi

dump=--2013-Apr-04.raw.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- raw ttl omitted --"
fi

dump=--2013-Apr-04.raw.sample.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- raw sample ttl omitted --"
fi

dump=--2013-Apr-04.raw.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- raw nt omitted --"
fi

dump=--2013-Apr-04.raw.sample.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- raw sample nt omitted --"
fi

dump=--2013-Apr-04.raw.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- raw rdf omitted --"
fi

dump=--2013-Apr-04.raw.sample.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- raw sample rdf omitted --"
fi


dump=--2013-Apr-04.eWorking.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- eWorking ttl omitted --"
fi

dump=--2013-Apr-04.eWorking.sample.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- eWorking sample ttl omitted --"
fi

dump=--2013-Apr-04.eWorking.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- eWorking nt omitted --"
fi

dump=--2013-Apr-04.eWorking.sample.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- eWorking sample nt omitted --"
fi

dump=--2013-Apr-04.eWorking.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- eWorking rdf omitted --"
fi

dump=--2013-Apr-04.eWorking.sample.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- eWorking sample rdf omitted --"
fi


dump=--2013-Apr-04.edirectory.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- edirectory ttl omitted --"
fi

dump=--2013-Apr-04.edirectory.sample.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- edirectory sample ttl omitted --"
fi

dump=--2013-Apr-04.edirectory.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- edirectory nt omitted --"
fi

dump=--2013-Apr-04.edirectory.sample.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- edirectory sample nt omitted --"
fi

dump=--2013-Apr-04.edirectory.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- edirectory rdf omitted --"
fi

dump=--2013-Apr-04.edirectory.sample.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- edirectory sample rdf omitted --"
fi


dump=--2013-Apr-04.edoes.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- edoes ttl omitted --"
fi

dump=--2013-Apr-04.edoes.sample.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- edoes sample ttl omitted --"
fi

dump=--2013-Apr-04.edoes.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- edoes nt omitted --"
fi

dump=--2013-Apr-04.edoes.sample.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- edoes sample nt omitted --"
fi

dump=--2013-Apr-04.edoes.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- edoes rdf omitted --"
fi

dump=--2013-Apr-04.edoes.sample.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- edoes sample rdf omitted --"
fi


dump=--2013-Apr-04.enot.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- enot ttl omitted --"
fi

dump=--2013-Apr-04.enot.sample.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- enot sample ttl omitted --"
fi

dump=--2013-Apr-04.enot.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- enot nt omitted --"
fi

dump=--2013-Apr-04.enot.sample.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- enot sample nt omitted --"
fi

dump=--2013-Apr-04.enot.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- enot rdf omitted --"
fi

dump=--2013-Apr-04.enot.sample.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- enot sample rdf omitted --"
fi


dump=--2013-Apr-04.eappear.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- eappear ttl omitted --"
fi

dump=--2013-Apr-04.eappear.sample.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- eappear sample ttl omitted --"
fi

dump=--2013-Apr-04.eappear.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- eappear nt omitted --"
fi

dump=--2013-Apr-04.eappear.sample.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- eappear sample nt omitted --"
fi

dump=--2013-Apr-04.eappear.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- eappear rdf omitted --"
fi

dump=--2013-Apr-04.eappear.sample.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- eappear sample rdf omitted --"
fi


dump=--2013-Apr-04.eto.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- eto ttl omitted --"
fi

dump=--2013-Apr-04.eto.sample.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- eto sample ttl omitted --"
fi

dump=--2013-Apr-04.eto.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- eto nt omitted --"
fi

dump=--2013-Apr-04.eto.sample.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- eto sample nt omitted --"
fi

dump=--2013-Apr-04.eto.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- eto rdf omitted --"
fi

dump=--2013-Apr-04.eto.sample.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- eto sample rdf omitted --"
fi


dump=--2013-Apr-04.ebe.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ebe ttl omitted --"
fi

dump=--2013-Apr-04.ebe.sample.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ebe sample ttl omitted --"
fi

dump=--2013-Apr-04.ebe.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ebe nt omitted --"
fi

dump=--2013-Apr-04.ebe.sample.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ebe sample nt omitted --"
fi

dump=--2013-Apr-04.ebe.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ebe rdf omitted --"
fi

dump=--2013-Apr-04.ebe.sample.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ebe sample rdf omitted --"
fi


dump=--2013-Apr-04.ea.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ea ttl omitted --"
fi

dump=--2013-Apr-04.ea.sample.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ea sample ttl omitted --"
fi

dump=--2013-Apr-04.ea.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ea nt omitted --"
fi

dump=--2013-Apr-04.ea.sample.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ea sample nt omitted --"
fi

dump=--2013-Apr-04.ea.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ea rdf omitted --"
fi

dump=--2013-Apr-04.ea.sample.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ea sample rdf omitted --"
fi


dump=--2013-Apr-04.econversion.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- econversion ttl omitted --"
fi

dump=--2013-Apr-04.econversion.sample.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- econversion sample ttl omitted --"
fi

dump=--2013-Apr-04.econversion.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- econversion nt omitted --"
fi

dump=--2013-Apr-04.econversion.sample.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- econversion sample nt omitted --"
fi

dump=--2013-Apr-04.econversion.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- econversion rdf omitted --"
fi

dump=--2013-Apr-04.econversion.sample.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- econversion sample rdf omitted --"
fi


dump=--2013-Apr-04.ecockpit..ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ecockpit. ttl omitted --"
fi

dump=--2013-Apr-04.ecockpit..sample.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ecockpit. sample ttl omitted --"
fi

dump=--2013-Apr-04.ecockpit..nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ecockpit. nt omitted --"
fi

dump=--2013-Apr-04.ecockpit..sample.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ecockpit. sample nt omitted --"
fi

dump=--2013-Apr-04.ecockpit..rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ecockpit. rdf omitted --"
fi

dump=--2013-Apr-04.ecockpit..sample.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ecockpit. sample rdf omitted --"
fi


dump=--2013-Apr-04.eYou.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- eYou ttl omitted --"
fi

dump=--2013-Apr-04.eYou.sample.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- eYou sample ttl omitted --"
fi

dump=--2013-Apr-04.eYou.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- eYou nt omitted --"
fi

dump=--2013-Apr-04.eYou.sample.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- eYou sample nt omitted --"
fi

dump=--2013-Apr-04.eYou.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- eYou rdf omitted --"
fi

dump=--2013-Apr-04.eYou.sample.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- eYou sample rdf omitted --"
fi


dump=--2013-Apr-04.ecan.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ecan ttl omitted --"
fi

dump=--2013-Apr-04.ecan.sample.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ecan sample ttl omitted --"
fi

dump=--2013-Apr-04.ecan.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ecan nt omitted --"
fi

dump=--2013-Apr-04.ecan.sample.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ecan sample nt omitted --"
fi

dump=--2013-Apr-04.ecan.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ecan rdf omitted --"
fi

dump=--2013-Apr-04.ecan.sample.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ecan sample rdf omitted --"
fi


dump=--2013-Apr-04.erun.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- erun ttl omitted --"
fi

dump=--2013-Apr-04.erun.sample.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- erun sample ttl omitted --"
fi

dump=--2013-Apr-04.erun.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- erun nt omitted --"
fi

dump=--2013-Apr-04.erun.sample.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- erun sample nt omitted --"
fi

dump=--2013-Apr-04.erun.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- erun rdf omitted --"
fi

dump=--2013-Apr-04.erun.sample.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- erun sample rdf omitted --"
fi


dump=--2013-Apr-04.ethis.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ethis ttl omitted --"
fi

dump=--2013-Apr-04.ethis.sample.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ethis sample ttl omitted --"
fi

dump=--2013-Apr-04.ethis.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ethis nt omitted --"
fi

dump=--2013-Apr-04.ethis.sample.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ethis sample nt omitted --"
fi

dump=--2013-Apr-04.ethis.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ethis rdf omitted --"
fi

dump=--2013-Apr-04.ethis.sample.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ethis sample rdf omitted --"
fi


dump=--2013-Apr-04.efrom.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- efrom ttl omitted --"
fi

dump=--2013-Apr-04.efrom.sample.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- efrom sample ttl omitted --"
fi

dump=--2013-Apr-04.efrom.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- efrom nt omitted --"
fi

dump=--2013-Apr-04.efrom.sample.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- efrom sample nt omitted --"
fi

dump=--2013-Apr-04.efrom.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- efrom rdf omitted --"
fi

dump=--2013-Apr-04.efrom.sample.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- efrom sample rdf omitted --"
fi


dump=--2013-Apr-04.ea.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ea ttl omitted --"
fi

dump=--2013-Apr-04.ea.sample.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ea sample ttl omitted --"
fi

dump=--2013-Apr-04.ea.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ea nt omitted --"
fi

dump=--2013-Apr-04.ea.sample.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ea sample nt omitted --"
fi

dump=--2013-Apr-04.ea.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ea rdf omitted --"
fi

dump=--2013-Apr-04.ea.sample.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ea sample rdf omitted --"
fi


dump=--2013-Apr-04.econversion.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- econversion ttl omitted --"
fi

dump=--2013-Apr-04.econversion.sample.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- econversion sample ttl omitted --"
fi

dump=--2013-Apr-04.econversion.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- econversion nt omitted --"
fi

dump=--2013-Apr-04.econversion.sample.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- econversion sample nt omitted --"
fi

dump=--2013-Apr-04.econversion.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- econversion rdf omitted --"
fi

dump=--2013-Apr-04.econversion.sample.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- econversion sample rdf omitted --"
fi


dump=--2013-Apr-04.ecockpit..ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ecockpit. ttl omitted --"
fi

dump=--2013-Apr-04.ecockpit..sample.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ecockpit. sample ttl omitted --"
fi

dump=--2013-Apr-04.ecockpit..nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ecockpit. nt omitted --"
fi

dump=--2013-Apr-04.ecockpit..sample.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ecockpit. sample nt omitted --"
fi

dump=--2013-Apr-04.ecockpit..rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ecockpit. rdf omitted --"
fi

dump=--2013-Apr-04.ecockpit..sample.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- ecockpit. sample rdf omitted --"
fi


dump=--2013-Apr-04.e(e.g..ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- e(e.g. ttl omitted --"
fi

dump=--2013-Apr-04.e(e.g..sample.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- e(e.g. sample ttl omitted --"
fi

dump=--2013-Apr-04.e(e.g..nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- e(e.g. nt omitted --"
fi

dump=--2013-Apr-04.e(e.g..sample.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- e(e.g. sample nt omitted --"
fi

dump=--2013-Apr-04.e(e.g..rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- e(e.g. rdf omitted --"
fi

dump=--2013-Apr-04.e(e.g..sample.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- e(e.g. sample rdf omitted --"
fi


dump=--2013-Apr-04.e$whatever/source/mySOURCE/myDATASET/version/VVV/)..ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- e$whatever/source/mySOURCE/myDATASET/version/VVV/). ttl omitted --"
fi

dump=--2013-Apr-04.e$whatever/source/mySOURCE/myDATASET/version/VVV/)..sample.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- e$whatever/source/mySOURCE/myDATASET/version/VVV/). sample ttl omitted --"
fi

dump=--2013-Apr-04.e$whatever/source/mySOURCE/myDATASET/version/VVV/)..nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- e$whatever/source/mySOURCE/myDATASET/version/VVV/). nt omitted --"
fi

dump=--2013-Apr-04.e$whatever/source/mySOURCE/myDATASET/version/VVV/)..sample.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- e$whatever/source/mySOURCE/myDATASET/version/VVV/). sample nt omitted --"
fi

dump=--2013-Apr-04.e$whatever/source/mySOURCE/myDATASET/version/VVV/)..rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- e$whatever/source/mySOURCE/myDATASET/version/VVV/). rdf omitted --"
fi

dump=--2013-Apr-04.e$whatever/source/mySOURCE/myDATASET/version/VVV/)..sample.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- e$whatever/source/mySOURCE/myDATASET/version/VVV/). sample rdf omitted --"
fi


dump=--2013-Apr-04.sameas.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- sameas ttl omitted --"
fi

dump=--2013-Apr-04.sameas.sample.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- sameas sample ttl omitted --"
fi

dump=--2013-Apr-04.sameas.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- sameas nt omitted --"
fi

dump=--2013-Apr-04.sameas.sample.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- sameas sample nt omitted --"
fi

dump=--2013-Apr-04.sameas.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- sameas rdf omitted --"
fi

dump=--2013-Apr-04.sameas.sample.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- sameas sample rdf omitted --"
fi


dump=--2013-Apr-04.void.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- void ttl omitted --"
fi

dump=--2013-Apr-04.void.sample.ttl
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- void sample ttl omitted --"
fi

dump=--2013-Apr-04.void.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- void nt omitted --"
fi

dump=--2013-Apr-04.void.sample.nt
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- void sample nt omitted --"
fi

dump=--2013-Apr-04.void.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump.gz ]; then
   if [ -e $wwwfile.gz ]; then
      $sudo rm -f $wwwfile.gz
   else
      $sudo mkdir -p `dirname $wwwfile.gz`
   fi
   echo "  $wwwfile.gz"
   $sudo ln $symbolic ${pwd}publish/$dump.gz $wwwfile.gz

   if [ -e $wwwfile ]; then
      echo "  $wwwfile" - removing b/c gz available
      $sudo rm -f $wwwfile # clean up to save space
   fi
elif [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- void rdf omitted --"
fi

dump=--2013-Apr-04.void.sample.rdf
wwwfile=$wwwroot/source//file//version/2013-Apr-04/conversion/$dump
if [ -e publish/$dump ]; then 
   if [ -e $wwwfile ]; then 
      $sudo rm -f $wwwfile
   else
      $sudo mkdir -p `dirname $wwwfile`
   fi
   echo "  $wwwfile"
   $sudo ln $symbolic ${pwd}publish/$dump $wwwfile
else
   echo "  -- void sample rdf omitted --"
fi


