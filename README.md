
# ProgModule

[![Current devel version: 0.1.2](https://img.shields.io/badge/devel%20version-0.1.2-blue.svg)](https://github.com/Dawn-Pan/ProgModule)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![License: GPL v2](https://img.shields.io/badge/License-GPL_v2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/09b138b2fa9242229f081cd180f6fc91)](https://app.codacy.com/gh/Dawn-Pan/ProgModule/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://makeapullrequest.com)


ProgModule is a bioinformatics tool to identify driver modules for predicting the prognosis of cancer patients.

## Introduction

`ProgModule` is a bioinformatics tool to identify driver modules for predicting the prognosis of cancer patients, which balances the exclusive coverage of mutations and simultaneously considers the mutation combination-mediated mechanism in cancer.

![A simple schema of the labyrinth](inst/flowchart.png)


## A notice on operating system compatibility

We recommended these dependencies to be installed:

- ** R (≥ 4.0.0)**: We developed this R package using R version 4.2.0.



## Installation

Install `ProgModule` using:

``` r
install.packages('devtools')
devtools::install_github("hanjunwei-lab/ProgModule")
```


## Usage

Load the package using `library(ProgModule)`. We provide a vignette for the package that can be called using: `vignette("ProgModule")`. Alternatively, you can view the online version on [CRAN](https://cran.r-project.org/web/packages/ProgModule/index.html). The examples I provided would take several minutes to run on a normal desktop computer.



