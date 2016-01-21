
# This programe use an eutils system by NCBI
# USAGE: ncbi_eutils_by_gi.pl <gi> 
#
 use LWP::Simple;

 my ($gi) = @ARGV;
 $url = "http://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nuccore&id=" . "$gi" . "&rettype=organism&retmode=xml";
 $data = get($url);
 print "$data" ;
