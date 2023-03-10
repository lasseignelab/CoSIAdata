### =========================================================================
### CoSIAdata metadata
### -------------------------------------------------------------------------
###

meta <- data.frame(
  Title = c(
    paste0(
      "VST normalized RNA-Sequencing data with annotations ",
      "for 362,533,125 Homo sapiens samples from Bgee"
    ),
    paste0(
      "VST normalized RNA-Sequencing data with annotations ",
      "for 31,405,642 Mus musculus samples from Bgee"
    ),
    paste0(
      "VST normalized RNA-Sequencing data with annotations ",
      "for 3,814,428 Rattus norvegicus samples from Bgee"
    ),
    paste0(
      "VST normalized RNA-Sequencing data with annotations ",
      "for 5,235,720 Danio rerio samples from Bgee"
    ),
    paste0(
      "VST normalized RNA-Sequencing data with annotations ",
      "for 4,576,399 Drosophila melanogaster samples from Bgee"
    ),
    paste0(
      "VST normalized RNA-Sequencing data with annotations ",
      "for 1,923,064 Caenorhabditis elegans samples from Bgee"
    )
  ),
  Description = c(
    paste0(
      "RNA-seq Variance Stabilized Transformation of Read ",
      "Counts Expression Data and Annotations for 362,533,125 ",
      "Homo sapiens samples across 132 tissues, represented as ",
      "an RData file. R data representation derieved from Bgee."
    ),
    paste0(
      "RNA-seq Variance Stabilized Transformation of Read ",
      "Counts Expression Data and Annotations for 31,405,642 ",
      "Mus musculus samples across 71 tissues, represented as ",
      "an RData file. R data representation derieved from Bgee."
    ),
    paste0(
      "RNA-seq Variance Stabilized Transformation of Read ",
      "Counts Expression Data and Annotations for 3,814,428 ",
      "Rattus norvegicus samples across 21 tissues, represented ",
      "as an RData file. R data representation derieved from Bgee."
    ),
    paste0(
      "RNA-seq Variance Stabilized Transformation of Read ",
      "Counts Expression Data and Annotations for 5,235,720 ",
      "Danio rerio samples across 25 tissues, represented as ",
      "an RData file. R data representation derieved from Bgee."
    ),
    paste0(
      "RNA-seq Variance Stabilized Transformation of Read ",
      "Counts Expression Data and Annotations for 4,576,399 ",
      "Drosophila melanogaster samples across 18 tissues, represented",
      "as an RData file. R data representation derieved from Bgee."
    ),
    paste0(
      "RNA-seq Variance Stabilized Transformation of Read Counts",
      "Expression Data and Annotations for 1,923,064",
      "Caenorhabditis elegans samples across 5 tissues represented as",
      "an RData file. R data representation derieved from Bgee."
    )
  ),
  BiocVersion = rep("3.17", 6),
  Genome = c("GRCh38.p13", "GRCm38.p6", "Rnor_6.0", "GRCz11", 
             "BDGP6.28", "WBcel235"),
  SourceType = rep("tar.gz", 6),
  SourceUrl = c(
    "https://bgee.org/ftp/bgee_v15_0/download/processed_expr_values/rna_seq/Homo_sapiens/Homo_sapiens_RNA-Seq_read_counts_TPM_FPKM.tar.gz",
    "https://bgee.org/ftp/bgee_v15_0/download/processed_expr_values/rna_seq/Mus_musculus/Mus_musculus_RNA-Seq_read_counts_TPM_FPKM.tar.gz",
    "https://bgee.org/ftp/bgee_v15_0/download/processed_expr_values/rna_seq/Rattus_norvegicus/Rattus_norvegicus_RNA-Seq_read_counts_TPM_FPKM.tar.gz",
    "https://bgee.org/ftp/bgee_v15_0/download/processed_expr_values/rna_seq/Danio_rerio/Danio_rerio_RNA-Seq_read_counts_TPM_FPKM.tar.gz",
    "https://bgee.org/ftp/bgee_v15_0/download/processed_expr_values/rna_seq/Drosophila_melanogaster/Drosophila_melanogaster_RNA-Seq_read_counts_TPM_FPKM.tar.gz",
    "https://bgee.org/ftp/bgee_v15_0/download/processed_expr_values/rna_seq/Caenorhabditis_elegans/Caenorhabditis_elegans_RNA-Seq_read_counts_TPM_FPKM.tar.gz"
  ),
  SourceVersion = rep("Bgee v15.0", 6),
  Species = c("Homo sapiens", "Mus musculus", "Rattus norvegicus", 
              "Danio rerio", "Drosophila melanogaster", 
              "Caenorhabditis elegans"),
  TaxonomyId = c(9606, 10090, 10116, 7955, 7227, 6239),
  Coordinate_1_based = FALSE,
  DataProvider = "Bgee",
  Maintainer = "Amanda D. Clark <amanda@freshairfamily.org>",
  RDataClass = c(rep("data.frame", 6)),
  DispatchClass = c(rep("Rda", 6)),
  RDataPath = c(
    "CoSIAdata/GEx_Bgee/EH_Hs.RData",
    "CoSIAdata/GEx_Bgee/EH_Mm.RData",
    "CoSIAdata/GEx_Bgee/EH_Rn.RData",
    "CoSIAdata/GEx_Bgee/EH_Dr.RData",
    "CoSIAdata/GEx_Bgee/EH_Dm.RData",
    "CoSIAdata/GEx_Bgee/EH_Ce.RData"
  )
)

write.csv(meta, file = "inst/extdata/metadata.csv", row.names = FALSE)
