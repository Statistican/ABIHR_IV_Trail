library(randomizeR)
library(tidyverse)
library(magrittr)

set.seed(1)

Stratums <- expand_grid(
  Zentrum = str_c("Zentrum_", str_pad(1:6, 3, "left", "0")),
  Altersgruppe = c('18 <= x <= 44', '45 <= x <=59', '60 <= x'),
  ICIQ_Gruppe = c('<13', '>= 13')) %>% 
  unite(Stratums, sep = '; ') %>% 
  as_vector()

rand_obj <- pbrPar(bc = rep(4,66), K = 2, groups = c('IG', 'KG'))
rand_seq <- genSeq(rand_obj, r = length(Stratums), seed = 1L) 
rand_dat <- getRandList(rand_seq) %>% set_rownames(Stratums) %>% t() %>% as.data.frame() 
rand_dat

rio::export(rand_dat, 'Randomisierungsliste-2025-09-25.xlsx')