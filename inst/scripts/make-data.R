# Experimental Hub Script for Downloading and Filtering RNA Seq Gene 
  # Expression data from Bgee

# install and load BgeeDB as well as other package that are needed to build this 
  # data frame (make sure that all packages are up to data)
if (!require("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}
BiocManager::install("BgeeDB")
library(BgeeDB)
install.packages("dplyr")
library(dplyr)
install.packages("magrittr")
library(magrittr)
install.packages("tidyr")
library(tidyr)
install.packages("tibble")
library(tibble)
install.packages("stringr")
library(stringr)

# Functions for Loading and Filtering Data
# This function downloads species specific data from Bgee, filters for 
  # necessary columns, and creates a column of the Variance 
  # Stabilized Transformations of Read Counts for this data.
Bgee_Download <- function(species, dataType) {
  bgee_db <- BgeeDB::Bgee$new(species = species, dataType = dataType)
  species_db <- BgeeDB::getData(bgee_db) # get the data as a bgee object
  # remove the quotations from the anatomical entities
  species_db$Anatomical.entity.name <- gsub('"', 
                                            "", 
                                            species_db$Anatomical.entity.name) 
  # filter the bgee data by these columns
  species_specific <- data.frame(dplyr::select(species_db, 
                                               Library.ID, Experiment.ID, 
                                               Gene.ID, Anatomical.entity.ID, 
                                               Anatomical.entity.name, TPM, 
                                               Read.count)) 
  VST_calc <- species_db %>% select(Gene.ID, 
                                    Library.ID, Anatomical.entity.name, 
                                    Read.count)
  VST_calc$Library.ID_Tissue <- paste(VST_calc$Library.ID, 
                                      VST_calc$Anatomical.entity.name, 
                                      sep = "_")
  VST_calc <- VST_calc %>% select(Gene.ID, Library.ID_Tissue, Read.count)
  VST_calc <- VST_calc %>%
    tidyr::pivot_wider(names_from = Library.ID_Tissue, 
                       values_from = Read.count) %>%
    column_to_rownames(var = "Gene.ID") %>%
    as.matrix() %>%
    round(., 0)
  VST_matrix <- as.data.frame(DESeq2::vst(VST_calc))
  VST_matrix <- tibble::rownames_to_column(VST_matrix, "Gene.ID")
  VST_df <- pivot_longer(VST_matrix, cols = -1, 
                         names_to = "Library.ID_Tissue", values_to = "VST")
  VST_df[c("Library.ID", "Anatomical.entity.name")] <- str_split_fixed(VST_df$Library.ID_Tissue, "_", 2)
  VST_df <- VST_df %>% select(Gene.ID, Library.ID, Anatomical.entity.name, VST)
  species_specific <- merge(VST_df, 
                            species_specific, 
                            by = c("Gene.ID", "Library.ID", 
                                   "Anatomical.entity.name"))
  return(species_specific)
}

# This function organizes the species specific data from above into 
  # the correct format for Experimental Hub.
Species_Dataframe <- function(dfBgee, species_name) {
  Species <- dfBgee %>%
    group_by(Gene.ID, Anatomical.entity.name) %>%
    summarise(Sample_size = n(), Median_VST = median(VST), 
              Scaled_Median_VST = median(scale(VST, center = FALSE)), 
              VST = paste(unique(VST), collapse = ", "), 
              Experiment_ID = paste(unique(Experiment.ID), collapse = ", "))
  Species_tissue <- dfBgee %>% select(Anatomical.entity.ID,
                                      Anatomical.entity.name)
  Species_tissue <- unique(Species_tissue)
  Species <- merge(Species, Species_tissue, by = "Anatomical.entity.name")
  names(Species)[names(Species) == "Anatomical.entity.name"] <- "Anatomical_entity_name"
  names(Species)[names(Species) == "Anatomical.entity.ID"] <- "Anatomical_entity_ID"
  names(Species)[names(Species) == "Gene.ID"] <- "Ensembl_ID"
  Species$Species <- species_name
  return(Species)
}

# Use functions to get Species-specific filtered BgeeDB

zebrafish_specific <- Bgee_Download("Danio_rerio", "rna_seq")
rat_specific <- Bgee_Download("Rattus_norvegicus", "rna_seq")
mouse_specific <- Bgee_Download("Mus_musculus", "rna_seq")
human_specific <- Bgee_Download("Homo_sapiens", "rna_seq")
fly_specific <- Bgee_Download("Drosophila_melanogaster", "rna_seq")
nematode_specific <- Bgee_Download("Caenorhabditis_elegans", "rna_seq")

# Get Species Experimental Hub Data
GEx_Bulk_Bgee_Zebrafish <- Species_Dataframe(zebrafish_specific, "Danio_rerio")
save(GEx_Bulk_Bgee_Zebrafish, file = "CoSIAdata/GEx_Bgee/EH_Dr.Rda")
GEx_Bulk_Bgee_Mouse <- Species_Dataframe(mouse_specific, "Mus_musculus")
save(GEx_Bulk_Bgee_Mouse, file = "CoSIAdata/GEx_Bgee/EH_Mm.Rda")
GEx_Bulk_Bgee_Rat <- Species_Dataframe(rat_specific, "Rattus_norvegicus")
save(GEx_Bulk_Bgee_Rat, file = "CoSIAdata/GEx_Bgee/EH_Rn.Rda")
GEx_Bulk_Bgee_Human <- Species_Dataframe(human_specific, "Homo_sapiens")
save(GEx_Bulk_Bgee_Human, file = "CoSIAdata/GEx_Bgee/EH_Hs.Rda")
GEx_Bulk_Bgee_Fly <- Species_Dataframe(fly_specific, "Drosophila_melanogaster")
save(GEx_Bulk_Bgee_Fly, file = "CoSIAdata/GEx_Bgee/EH_Dm.Rda")
GEx_Bulk_Bgee_Nematode <- Species_Dataframe(nematode_specific, 
                                            "Caenorhabditis_elegans")
save(GEx_Bulk_Bgee_Nematode, file = "CoSIAdata/GEx_Bgee/EH_Ce.Rda")
