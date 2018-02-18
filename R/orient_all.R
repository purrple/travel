library(purrr)
library(glue)
library(magick)
library(assertthat)
library(progress)

orient_all <- function( files ){
  pb <- progress_bar$new(total = length(files))
  walk( files, ~{
    image_read(.) %>% 
      image_orient() %>% 
      image_write(path = .)
    pb$tick()
  })
}
