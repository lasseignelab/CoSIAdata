# CoSIAdata

### ExperimentHub package for CoSIA: **C**r**o**ss **S**pecies **I**nvestigation and **A**nalysis

[`CoSIA`](https://github.com/lasseignelab/CoSIA) is a package that provides researchers with an alternative 
methodology for comparing across species and tissues using normal wild-type RNA-Seq Gene Expression data from Bgee. 
Using RNA-Seq Gene Expression data, CoSIA provides multiple visualization tools to explore the transcriptome diversity and variation across genes, 
tissues, and species. CoSIA uses Coefficient of Variation and Shannon Entropy based Diversity and Specificity to calculate transcriptome diversity and variation. 
CoSIA also provides additional conversion tools and utilities to provide a streamlined methodology for cross-species comparison 
across the tissues and genes of five commonly used biomedical research species 
(*Mus musculus*, *Rattus norvegicus*, *Danio rerio*, *Drosophila melanogaster*, and *Caenorhabditis elegans*) in addition to *Homo sapiens*.


## Getting Started

### Installing

**In preparation for the Bioconductor 3.17 release, we have developed CoSIA within a Bioconductor docker. 
Follow the instructions on [Bioconductor's Docker Help Page](https://www.bioconductor.org/help/docker/) to install and run CoSIAdata within the `bioconductor_docker:devel` container.**

In R:

``` {r installation, eval=FALSE}
## Install BiocManager if necessary; Install CoSIAdata
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("CoSIAdata")
library(CoSIAdata)
```

## Using CoSIAdata
CoSIAdata has species-specific helper functions for accessing expression data
```{r download-c.elegan_data, eval=FALSE}
c_elegans_vst_counts <- CoSIAdata::Caenorhabditis_elegans()
```

Check out the vignette for more information on accesssing specific data in CoSIAdata.

## Authors

-   Anisha Haldar
-   Vishal H. Oza
-   Nathaniel DeVoss
-   Amanda D. Clark
-   Brittany N. Lasseigne

## Lasseigne Lab

[What is Happening in the Lasseigne Lab?](https://www.lasseigne.org/)

<img src="https://www.lasseigne.org/img/main/lablogo.png" width="75" height="75">

## Funding

This work was supported in part by the UAB Lasseigne Lab Start-Up funds (BNL, 
AH, ND, ADC and VHO), the UAB Pilot Center for Precision Animal Modeling (C-PAM)
(1U54OD030167) (BNL and VHO), UAB Pilot Center for Precision Animal Modeling 
(C-PAM) - Diversity Supplement (3U54OD030167-03S1) (ADC), and Mentored 
Experiences in Research, Instruction, and Teaching (MERIT) Program 
(K12 GM088010) (ADC).

## Acknowledgements

The authors would like to thank the members of the Lassigne lab for their 
support and feedback, in particular, Elizabeth J. Wilk, Jordan Whitlock, 
and Timothy C. Howton.

## License

This project is licensed under the MIT License - 
see the [LICENSE.md](LICENSE.md) file for details
