#!/usr/local/bin/perl
# This programe use an eutils system by NCBI
# USAGE: ncbi_eutils_by_accession.pl <accession> 
#

use LWP::Simple;
## $acc_list = 'NM_009417,NM_000547,NM_001003009,NM_019353';
## @acc_array = split(/,/, $acc_list);

#append [accn] field to each accession
## for ($i=0; $i < @acc_array; $i++) {
##    $acc_array[$i] .= "[accn]";
## }

#join the accessions with OR

my ($acc) = @ARGV;
# $query = join('+OR+',@acc_array);
$query = $acc;

#assemble the esearch URL
$base = 'https://eutils.ncbi.nlm.nih.gov/entrez/eutils/';
$url = $base . "esearch.fcgi?db=nuccore&term=$query&usehistory=y";

#post the esearch URL
$output = get($url);
print "$output";

# #parse WebEnv and QueryKey
$web = $1 if ($output =~ /<WebEnv>(\S+)<\/WebEnv>/);
$key = $1 if ($output =~ /<QueryKey>(\d+)<\/QueryKey>/);

#assemble the efetch URL
$url = $base . "efetch.fcgi?db=nuccore&query_key=$key&WebEnv=$web";
$url .= "&rettype=organism&retmode=xml";

# #post the efetch URL
$taxonomy = get($url);
print "$taxonomy";


##  $url = "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nuccore&id=" . "$gi" . "&rettype=organism&retmode=xml";
##  $data = get($url);
##  print "$data" ;
