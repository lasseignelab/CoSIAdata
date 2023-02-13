#' @keywords internal
#' @name CoSIAdata
#' @aliases CoSIAdata
#' @import ExperimentHub
#' @description 
#' CoSIAdata includes Variance Stabilized Transformation of Read Counts from 
#' Bgee RNA-Seq Expression Data across six species (Homo sapiens, Mus musculus,
#' Rattus norvegicius,Danio rerio, Drosophila melanogaster, and Caenorhabditis 
#' elegans) and more than 132 tissues. Each species has its own independent 
#' dataframe with its unique set of tissue and gene specific expression data.
#' 
#' CoSIAdata is meant to be integrated into the CoSIA Package, a visualization 
#' tool for cross species comparison of expression metrics. However, it can be 
#' used to conduct independent species, tissue, and gene-specific 
#' expression analysis.
#' 
#' Researchers might find this data useful as it provides Variance Stabilized 
#' Transformation of Read Counts in order to quantify the RNA-Seq Expression.
#' 
#' @format Multiple dataframes
#' 
#' @examples
#' library(ExperimentHub)
#' query(ExperimentHub(), "CoSIAdata")
#'
#' CoSIAdata <- ExperimentHub()[[""]]
#' CoSIAdata
"_PACKAGE"

## usethis namespace: start
## usethis namespace: end
NULL
