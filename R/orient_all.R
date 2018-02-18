library(purrr)
library(glue)
library(magick)
library(assertthat)
library(progress)
library(exiv)
library(dplyr)

orient_all <- function( files ){
  pb <- progress_bar$new(total = length(files))
  orientations <- map_int( files, ~{
    or <- read_exif(.x) %>% 
      filter( exif_key == "Exif.Image.Orientation") %>% 
      pull(exif_val) %>% 
      as.integer()
    pb$tick()
    if( length(or) ) or else 0L
  })
  files <- files[ orientations > 1]
  
  pb <- progress_bar$new(total = length(files))
  walk( files, ~{
    image_read(.x) %>% 
      image_orient() %>% 
      image_write(path = .x)
    pb$tick()
  })
}
