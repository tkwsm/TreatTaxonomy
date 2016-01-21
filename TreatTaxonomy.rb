
module TreatTaxonomy

  def TreatTaxonomy.by_gid( gid )
    bulk_stream = ` ncbi_eutilsby_gid.pl #{gid}`
    return bulk_stream
  end

  def TreatTaxonomy.taxdata_by_gid( gid )
    bulk_stream = TreatTaxonomy.by_gid( gid )
    seq_id_gi_l        = ""; seq_id_gi        = "";
    biosource_genome_l = ""; biosource_genome = "";
    org_ref_taxname_l  = ""; org_ref_taxname  = "";
    orgname_lineage_l  = ""; orgname_lineage  = "";
    bulk_stream.split("\n").each do |x|
      seq_id_gi_l        = x.chomp if x =~ /\<Seq-id_gi\>/
      biosource_genome_l = x.chomp if x =~ /\<BioSource_genome/
      org_ref_taxname_l  = x.chomp if x =~ /\<Org-ref_taxname\>/
      orgname_lineage_l  = x.chomp if x =~ /\<OrgName_lineage\>/
    end
    seq_id_gi        = seq_id_gi_l.slice(/\<Seq-id_gi\>([^\<]+)/, 1)
    biosource_genome = biosource_genome_l.slice(/_genome value=\"([^\"]+)/, 1)
    org_ref_taxname  = org_ref_taxname_l.slice(/\<Org-ref_taxname\>([^\<]+)/, 1)
    orgname_lineage  = orgname_lineage_l.slice(/\<OrgName_lineage\>([^\<]+)/, 1)
    return [ seq_id_gi,
             biosource_genome,
             org_ref_taxname,
             orgname_lineage ]
  end

end


if $0 == __FILE__

  gid_list = []
  gid_list_file = open( ARGV.shift )
  gid_list_file.each{ |x| gid_list << x.chomp }

  gid_list.each do |gid| 
    puts TreatTaxonomy.taxdata_by_gid( gid ) 
  end

end

