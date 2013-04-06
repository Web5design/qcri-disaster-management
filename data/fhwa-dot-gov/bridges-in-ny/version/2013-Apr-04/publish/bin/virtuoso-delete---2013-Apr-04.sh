#!/bin/bash
#
# run publish/bin/virtuoso-load---2013-Apr-04.sh
# from /home/dmiao/Documents/dig/QCRI/qcri-disaster-management/data/fhwa-dot-gov/bridges-in-ny/version/2013-Apr-04/
#
# graph was 
  Working directory does not appear to be a dataset. You can run this from a dataset.
  (e.g. $whatever/source/mySOURCE/myDATASET/).

  Working directory does not appear to be a directory of versions. You can run this from a directory of versions.
  (e.g. $whatever/source/mySOURCE/myDATASET/version/).

  Working directory does not appear to be a conversion cockpit.
  You can run this from a conversion cockpit.
  (e.g. $whatever/source/mySOURCE/myDATASET/version/VVV/). during conversion
# metadataset graph was auto during conversion
#
#        $CSV2RDF4LOD_PUBLISH_METADATASET_GRAPH_NAME            # <---- Loads into this with param --as-metadatset
#
#
#                               AbstractDataset                  # <---- Loads into this with param --abstract
#                     (http://.org/source/sss/dataset/ddd)                                                         
#                                     |                   \                                                        
# Loads into this by default -> VersionedDataset           meta  # <---- Loads into this with param --meta
#              (http://.org/source/sss/dataset/ddd/version/vvv)                                                    
#                                     |                                                                            
#                                LayerDataset                                                                      
#                                   /    \                                                                         
# Never loads into this ----> [table]   DatasetSample            # <---- Loads into this with param --sample
#
# See https://github.com/timrdf/csv2rdf4lod-automation/wiki/Aggregating-subsets-of-converted-datasets
# See https://github.com/timrdf/csv2rdf4lod-automation/wiki/Named-graph-organization

CSV2RDF4LOD_HOME=${CSV2RDF4LOD_HOME:?"not set; source csv2rdf4lod/source-me.sh or see https://github.com/timrdf/csv2rdf4lod-automation/wiki/CSV2RDF4LOD-not-set"}
CSV2RDF4LOD_BASE_URI=${CSV2RDF4LOD_BASE_URI:?"not set; source csv2rdf4lod/source-me.sh or see https://github.com/timrdf/csv2rdf4lod-automation/wiki/CSV2RDF4LOD-not-set"}

if [ `is-pwd-a.sh cr:dev` == 'yes' ]; then
   echo "Refusing to publish; see 'cr:dev and refusing to publish' at"
   echo "  https://github.com/timrdf/csv2rdf4lod-automation/wiki/CSV2RDF4LOD-environment-variables-%28considerations-for-a-distributed-workflow%29"
   exit 1
fi
if [ -e 'publish/bin/ln-to-www-root---2013-Apr-04.sh' ]; then
   # Make sure that the file we will load from the web is published
   publish/bin/ln-to-www-root---2013-Apr-04.sh
fi

base="${CSV2RDF4LOD_BASE_URI_OVERRIDE:-$CSV2RDF4LOD_BASE_URI}"
graph="$base/source//dataset//version/2013-Apr-04"
metaGraph="$graph"
if [ "$1" == "--sample" ]; then
   layerSlug="raw"
   sampleGraph="$graph/conversion/$layerSlug/subset/sample"
   sampleURL="$base/source//file//version/2013-Apr-04/conversion/--2013-Apr-04.raw.sample.ttl"
   echo pvdelete.sh $sampleGraph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $sampleGraph

   layerSlug="enhancement/Working"
   sampleGraph="$graph/conversion/$layerSlug/subset/sample"
   sampleURL="$base/source//file//version/2013-Apr-04/conversion/--2013-Apr-04.eWorking.sample.ttl"
   echo pvdelete.sh $sampleGraph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $sampleGraph

   layerSlug="enhancement/directory"
   sampleGraph="$graph/conversion/$layerSlug/subset/sample"
   sampleURL="$base/source//file//version/2013-Apr-04/conversion/--2013-Apr-04.edirectory.sample.ttl"
   echo pvdelete.sh $sampleGraph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $sampleGraph

   layerSlug="enhancement/does"
   sampleGraph="$graph/conversion/$layerSlug/subset/sample"
   sampleURL="$base/source//file//version/2013-Apr-04/conversion/--2013-Apr-04.edoes.sample.ttl"
   echo pvdelete.sh $sampleGraph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $sampleGraph

   layerSlug="enhancement/not"
   sampleGraph="$graph/conversion/$layerSlug/subset/sample"
   sampleURL="$base/source//file//version/2013-Apr-04/conversion/--2013-Apr-04.enot.sample.ttl"
   echo pvdelete.sh $sampleGraph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $sampleGraph

   layerSlug="enhancement/appear"
   sampleGraph="$graph/conversion/$layerSlug/subset/sample"
   sampleURL="$base/source//file//version/2013-Apr-04/conversion/--2013-Apr-04.eappear.sample.ttl"
   echo pvdelete.sh $sampleGraph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $sampleGraph

   layerSlug="enhancement/to"
   sampleGraph="$graph/conversion/$layerSlug/subset/sample"
   sampleURL="$base/source//file//version/2013-Apr-04/conversion/--2013-Apr-04.eto.sample.ttl"
   echo pvdelete.sh $sampleGraph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $sampleGraph

   layerSlug="enhancement/be"
   sampleGraph="$graph/conversion/$layerSlug/subset/sample"
   sampleURL="$base/source//file//version/2013-Apr-04/conversion/--2013-Apr-04.ebe.sample.ttl"
   echo pvdelete.sh $sampleGraph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $sampleGraph

   layerSlug="enhancement/a"
   sampleGraph="$graph/conversion/$layerSlug/subset/sample"
   sampleURL="$base/source//file//version/2013-Apr-04/conversion/--2013-Apr-04.ea.sample.ttl"
   echo pvdelete.sh $sampleGraph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $sampleGraph

   layerSlug="enhancement/conversion"
   sampleGraph="$graph/conversion/$layerSlug/subset/sample"
   sampleURL="$base/source//file//version/2013-Apr-04/conversion/--2013-Apr-04.econversion.sample.ttl"
   echo pvdelete.sh $sampleGraph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $sampleGraph

   layerSlug="enhancement/cockpit."
   sampleGraph="$graph/conversion/$layerSlug/subset/sample"
   sampleURL="$base/source//file//version/2013-Apr-04/conversion/--2013-Apr-04.ecockpit..sample.ttl"
   echo pvdelete.sh $sampleGraph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $sampleGraph

   layerSlug="enhancement/You"
   sampleGraph="$graph/conversion/$layerSlug/subset/sample"
   sampleURL="$base/source//file//version/2013-Apr-04/conversion/--2013-Apr-04.eYou.sample.ttl"
   echo pvdelete.sh $sampleGraph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $sampleGraph

   layerSlug="enhancement/can"
   sampleGraph="$graph/conversion/$layerSlug/subset/sample"
   sampleURL="$base/source//file//version/2013-Apr-04/conversion/--2013-Apr-04.ecan.sample.ttl"
   echo pvdelete.sh $sampleGraph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $sampleGraph

   layerSlug="enhancement/run"
   sampleGraph="$graph/conversion/$layerSlug/subset/sample"
   sampleURL="$base/source//file//version/2013-Apr-04/conversion/--2013-Apr-04.erun.sample.ttl"
   echo pvdelete.sh $sampleGraph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $sampleGraph

   layerSlug="enhancement/this"
   sampleGraph="$graph/conversion/$layerSlug/subset/sample"
   sampleURL="$base/source//file//version/2013-Apr-04/conversion/--2013-Apr-04.ethis.sample.ttl"
   echo pvdelete.sh $sampleGraph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $sampleGraph

   layerSlug="enhancement/from"
   sampleGraph="$graph/conversion/$layerSlug/subset/sample"
   sampleURL="$base/source//file//version/2013-Apr-04/conversion/--2013-Apr-04.efrom.sample.ttl"
   echo pvdelete.sh $sampleGraph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $sampleGraph

   layerSlug="enhancement/a"
   sampleGraph="$graph/conversion/$layerSlug/subset/sample"
   sampleURL="$base/source//file//version/2013-Apr-04/conversion/--2013-Apr-04.ea.sample.ttl"
   echo pvdelete.sh $sampleGraph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $sampleGraph

   layerSlug="enhancement/conversion"
   sampleGraph="$graph/conversion/$layerSlug/subset/sample"
   sampleURL="$base/source//file//version/2013-Apr-04/conversion/--2013-Apr-04.econversion.sample.ttl"
   echo pvdelete.sh $sampleGraph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $sampleGraph

   layerSlug="enhancement/cockpit."
   sampleGraph="$graph/conversion/$layerSlug/subset/sample"
   sampleURL="$base/source//file//version/2013-Apr-04/conversion/--2013-Apr-04.ecockpit..sample.ttl"
   echo pvdelete.sh $sampleGraph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $sampleGraph

   layerSlug="enhancement/(e.g."
   sampleGraph="$graph/conversion/$layerSlug/subset/sample"
   sampleURL="$base/source//file//version/2013-Apr-04/conversion/--2013-Apr-04.e(e.g..sample.ttl"
   echo pvdelete.sh $sampleGraph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $sampleGraph

   layerSlug="enhancement/$whatever/source/mySOURCE/myDATASET/version/VVV/)."
   sampleGraph="$graph/conversion/$layerSlug/subset/sample"
   sampleURL="$base/source//file//version/2013-Apr-04/conversion/--2013-Apr-04.e)..sample.ttl"
   echo pvdelete.sh $sampleGraph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $sampleGraph

   exit 1
elif [[ "$1" == "--meta" && -e 'publish/--2013-Apr-04.void.ttl' ]]; then
   metaURL="$base/source//file//version/2013-Apr-04/conversion/--2013-Apr-04.void.ttl"
   metaGraph="$base"/vocab/Dataset
   echo pvdelete.sh $metaGraph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $metaGraph
   exit 1
fi

# Change the target graph before continuing to load everything
if [[ "$1" == "--unversioned" || "$1" == "--abstract" ]]; then
   # strip off version
   graph="`echo $graph\ | perl -pe 's|/version/[^/]*$||'`"
   graph="$base/source//dataset/"
   echo populating abstract named graph \($graph\) instead of versioned named graph.
elif [[ "$1" == "--meta" ]]; then
   metaGraph="$base/vocab/Dataset"
elif [[ "$1" == "--as-metadataset" ]]; then
   graph="${CSV2RDF4LOD_PUBLISH_METADATASET_GRAPH_NAME:-'http://purl.org/twc/vocab/conversion/MetaDataset'}"
   metaGraph="$graph"
elif [ $# -gt 0 ]; then
   echo param not recognized: $1
   echo usage: `basename $0` with no parameters loads versioned dataset
   echo usage: `basename $0` --{sample, meta, abstract}
   exit 1
fi

# Load the metadata, either in the same named graph as the data or into a more global one.
metaURL="$base/source//file//version/2013-Apr-04/conversion/--2013-Apr-04.void.ttl"
echo pvdelete.sh $metaGraph
${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $metaGraph
if [[ "$1" == "--meta" ]]; then
   exit 1
fi



dump='publish/--2013-Apr-04.nt'
url='http://dig.csail.mit.edu/2013/QCRI/bridges/source//file//version/2013-Apr-04/conversion/--2013-Apr-04.nt'
if [ -e $dump ]; then
   echo pvdelete.sh $graph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $graph
   exit 1
elif [ -e $dump.gz ]; then
   echo pvdelete.sh $graph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $graph
   exit 1
fi

dump='publish/--2013-Apr-04.ttl'
url='http://dig.csail.mit.edu/2013/QCRI/bridges/source//file//version/2013-Apr-04/conversion/--2013-Apr-04.ttl'
if [ -e $dump ]; then
   echo pvdelete.sh $graph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $graph
   exit 1
elif [ -e $dump.gz ]; then
   echo pvdelete.sh $graph
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $graph
   exit 1
fi

dump='publish/--2013-Apr-04.rdf'
url='http://dig.csail.mit.edu/2013/QCRI/bridges/source//file//version/2013-Apr-04/conversion/--2013-Apr-04.rdf'
if [ -e $dump ]; then
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $graph
   exit 1
elif [ -e $dump.gz ]; then
   ${CSV2RDF4LOD_HOME}/bin/util/pvdelete.sh $graph
   exit 1
fi
#3> <> prov:wasAttributedTo <http://dig.csail.mit.edu/2013/QCRI/bridges/id/csv2rdf4lod/cad7f75d46fbc5c430a2045bc1a07fad> .
#3> <> prov:generatedAtTime "2013-04-05T21:58:57-04:00"^^xsd:dateTime .
#3> <http://dig.csail.mit.edu/2013/QCRI/bridges/id/csv2rdf4lod/cad7f75d46fbc5c430a2045bc1a07fad> foaf:name "convert-bridges-in-ny.sh" .
