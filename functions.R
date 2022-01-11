

chroms <- c(as.character(1:19), "X")
interp_bp <- function(df) {
  
  df <- arrange(df, peak_chr, peak_cM)
  peak_gpos <- select(df, peak_chr, peak_cM)
  chr <- peak_gpos$peak_chr
  f <- factor(chr, chroms)
  peak_gcoord_list <- split(peak_gpos$peak_cM, f)
  peak_pcoord_list <- qtl2::interp_map(peak_gcoord_list, gmap, pmap)
  df$interp_bp_peak <- unsplit(peak_pcoord_list, f)
  df
}

rankZ <- function (x) {
  x <- rank(x, na.last = "keep", ties.method = "average")/(sum(!is.na(x)) + 1)
  qnorm(x)
}

split_map <- function (map, chr_names = NULL)
{
  map <- reorder_map_table(map, chr_names = chr_names)
  pos <- as.numeric(map[, 2])
  chr <- map[, 1]
  uchr <- unique(chr)
  names(pos) <- rownames(map)
  lapply(split(pos, factor(chr, uchr)), sort)
}

#This calls reorder_map_table() and the code for that is:
reorder_map_table <- function (map_tab, chr_col = 1, pos_col = 2, chr_names = NULL)
{
  chr <- map_tab[, chr_col]
  if (is.null(chr_names))
    chr_names <- unique(chr)
  chr <- factor(chr, levels = chr_names)
  pos <- suppressWarnings(as.numeric(map_tab[, pos_col]))
  map_tab[order(chr, pos, seq_len(nrow(map_tab))), , drop = FALSE]
}