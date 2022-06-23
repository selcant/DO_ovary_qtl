#!/usr/bin/env Rscript
# I want to get permutation results for ovary counts

# load packages
# .libPaths("/projects/munger-lab/projects/renv/cache/v5/R-4.1/x86_64-pc-linux-gnu/") # add renv library to path

library(qtl2)
#library(tidyverse)


# load prepped data
load("/projects/munger-lab/projects/DO_ovary_QTL/data/perm_objects_v2.RData")

# get significance thresholding for all
# # permutations:
qtl_map_perm_thres <- scan1perm(
  genoprobs = genoprobs,
  pheno =   ovary_counts_rankZ,
  kinship = kinship_loco,
  addcovar = covar,
  n_perm = 1000, 
  cores = 16
)
save( qtl_map_perm_thres, file = "/projects/munger-lab/projects/DO_ovary_QTL/data/perm_thres_v2.RData")