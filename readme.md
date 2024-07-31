## Accompanied script for manuscript "Tumor-Associated Antigen Burden Correlates with Immune Checkpoint Blockade Benefit in Non-exhausted Tumor Immune Context"

## License

This project is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License. See the [LICENSE](LICENSE) file for details.

[![License: CC BY-NC-SA 4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)

## Example script for calculating TAB based on a TAA gene list

This code has been tested in R version 4.1.2. To install, please unzip the package into a hard drive location and specify the work directory below.

### Load the data and R module

Set work directory. Please change to the location where the package is unzipped.

```r
setwd("your work directory")
```

Source the TAB calculation module.

```r
source("R/TAB.modules.Githubv1.R")
```

To calculate CTA burden, we compared the tumor expression with the GTEx normal tissue expression data. The expression data in the tumor dataset and GTEx dataset were first normalized using quantile normalization. To mitigate batch effects between the tumor dataset, and the GTEX dataset, which gathers normal tissue data from healthy individuals, we employed the "ComBat" R package. The example tumor and normal expression datasets below are already quantile normalized, and batch-effect corrected.

Load example tumor gene expression data.

```r
load("Data/Tumor.exp.rda")
```

Load sample information for GTEX normal tissue samples.

```r
load("Data/GTEX_Normal.exp.rda")
```

Load the list of known CT antigens. 

```r
load("Data/known.CT.antigen.list.rda")
```
Load the list of predicted tumor associated antigens. 

```r
load("Data/HEPA.TAA.list.rda")
```

### Calculate TAA burden

Calculate cancer testis antigen burden based on CT antigens.

```r
CTA.burden = calculate.TAB.combine(
  tumor.expData = Tumor.exp, 
  normal.expData = GTEX_Normal.exp, 
  TAA.List = known.CT.antigen.list
)
```

Calculate tumor associated antigen burden based on putative TAAs identified by HEPA analysis, and known CT antigens.

```r
TAA.burden = calculate.TAB.combine(
  tumor.expData = Tumor.exp, 
  normal.expData = GTEX_Normal.exp, 
  TAA.List = c(HEPA.TAA,known.CT.antigen.list)
)
```