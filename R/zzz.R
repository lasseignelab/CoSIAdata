#' Resource Name Function
#'
#' @param libname The name of the Library.
#' @param pkgname The name of the Package.
#'
#' @return a set of functions specific to each resource species
#' @export
#'
#' @examples
#' CoSIAdata::`Danio rerio`()
#'
.onLoad <- function(libname, pkgname) {
    fl <- system.file("extdata", "metadata.csv", package = "CoSIAdata")
    species <- utils::read.csv(fl, stringsAsFactors = FALSE)$Species
    # createHubAccessors updated function from ExperimentHub to match by species
    createHubAccessors <- function(pkgname, species) {
        ## map species to ExperimentHub identifiers
        eh <-AnnotationHub::query(ExperimentHub(), pkgname)
        ## hubAccessorFactory function created by ExperimentHub
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
        ## create and export accessor functions in package namespace
        ns <- asNamespace(pkgname)
        for (i in seq_along(species)) {
            assign(species[[i]], .hubAccessorFactory(ehids[[i]]), envir = ns)
            namespaceExport(ns, species[[i]])
        }
    }
    createHubAccessors("CoSIAdata", species)
}
