#' Resource Name Function
#' @title .onLoad Function for Resource Name
#' @aliases Caenorhabditis_elegans
#' @aliases Danio_rerio
#' @aliases Drosophila_melanogaster
#' @aliases Homo_sapiens
#' @aliases Mus_musculus
#' @aliases Rattus_norvegicus
#' 
#' @param libname The name of the Library.
#' @param pkgname The name of the Package.
#'
#' @return a set of functions specific to each resource species
#'
#' @examples
#' CoSIAdata::Danio_rerio()
#' @references Morgan M, Shepherd L (2022). ExperimentHub: Client to access ExperimentHub resources. R package version 2.6.0.

# onLoad function creates functions for each resource specific to the species
# this code has been adapted from ExperimentHub
.onLoad <- function(libname, pkgname) {
    fl <- system.file("extdata", "metadata.csv", package = pkgname)
    species <- utils::read.csv(fl, stringsAsFactors = FALSE)$Species
    species <- sub(" ", "_", species)
    # createHubAccessors adapted function from ExperimentHub to match by species
    createHubAccessors <- function(pkgname, species) {
        ## map species to ExperimentHub identifiers
        eh <-AnnotationHub::query(ExperimentHub(), pkgname)
        ## hubAccessorFactory function adapted by ExperimentHub
        .hubAccessorFactory <- function(ehid) {
            force(ehid)
            function(metadata = FALSE) {
                eh <- ExperimentHub()
                if (metadata) {
                    eh[ehid]
                } else {
                    eh[[ehid]]
                }
            }
        }
        ehids <- vapply(species, function(spe, exactMatch) {
            ehid <- names(subset(eh, species == spe))
            if (length(ehid) == 0L) {
                stop(sQuote(spe), " not found in ExperimentHub")
            } else if (length(ehid) != 1L) {
                stop(
                    sQuote(spe),
                    " matches more than 1 ExperimentHub resource"
                )
            }
            ehid
        }, character(1))
        ## create and export accessory functions in package namespace
        ns <- asNamespace(pkgname)
        for (i in seq_along(species)) {
            assign(species[[i]], .hubAccessorFactory(ehids[[i]]), envir = ns)
            namespaceExport(ns, species[[i]])
        }
    }
    createHubAccessors(pkgname, species)
}
