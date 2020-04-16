# COVID-19/IL-6 Project

## Introduction

This repo has the R scripts and code used to generate the results and figures for the **COVID-19/IL-6** project. [This is where we will link the paper when we get it published]().

## Quickstart

You can quickly generate the data and results with minimal intervention. It helps if you are using Linux or macOS but if you are using windows, you can rely on [Windows Subsystem for Linux]().

```bash
# Clone the repository
git clone https://github.com/AliSajid/ssri_il6.git
cd covid_tnf
# Run the analysis
make
```

This will run all the scripts, downlaod the data, perform the analysis and then generate figures.

## Prerequisites

* R (https://r-project.org)
* git (for keeping up with the latest version or contributing)
* make (For running the Makefile for unattended run)
* RStudio (https://rstudio.com) (Using the project-related features)

This project uses packrat. If you have packrat installed, it will automatically download and install the dependency packages.


## Structure

The repository consists of three main scripts that are supposed to be run in sequence.

1. curate_signatures.R
2. process_signatures.R
3. analyse_data.R

There are several `figureX.R` files to generate the figures

In addition, there's a helper file called `pipeline.R` that contains the helper functions used to access the iLINCS API

### curate_signatures.R

This file takes the signature files placed in the signature_data directory and generates the list of signatures we need to process.

This can be separately invoked like this:

```bash
make curate
```

### process_signatures.R

This file takes the list of signature IDs generated previously and obtains their L1000 signatures. This is then used to find the concordant gene knockout signatures.

All the data is saved in the `data` directory.

This can be separately invoked like this:

```bash
make process
```

### analyse_data.R

This file takes all the data generated and performs a series of analyses the results of which are stored in the `results` directory.

This can be separately invoked like this:

```bash
make analyse
```

### figureX.R

These files generate a series of figures.

This can be separately invoked like this:

```bash
make visualise
```
