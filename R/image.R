library(purrr)
library(glue)
library(magick)
library(assertthat)
library(progress)
devtools::install_github("hrbrmstr/exiv")
library(exiv)
library(dplyr)

src <- c("static/img/nyc-2018/times-square/IMG_0604.jpg", 
  "static/img/nyc-2018/times-square/IMG_3409.jpg",
  "static/img/nyc-2018/times-square/IMG_3408.jpg",
  "static/img/nyc-2018/times-square/IMG_3412.jpg",
  "static/img/nyc-2018/times-square/IMG_3407.jpg")

imgs <- map( src, image_read )

imgl1 <- image_scale(image_append(c(imgs[[1]], imgs[[2]]), stack = FALSE), "800x533")
imgl1 <- image_scale(image_append(c(imgl1, imgs[[3]]), stack = FALSE), "800x480")
imgl2 <- image_scale(image_append(c(imgs[[4]], imgs[[5]]), stack = FALSE), 800)
img <- image_append(c(imgl1,imgl2), stack=TRUE)

image_write(img, path = "static/img/nyc-2018/times-square/mms.jpg", format = "jpg" )

#' montage de 4 images
#' 
#' @param src Les fichiers à monter
#' @param dest Le fichier de montage à créer
montage4 <- function( src, dest ){
  assert_that( length(src) == 4 )
  assert_that( all(file.exists(src)) )
  
  imgs <- map( src, image_read )
  
  imgl1 <- image_append(c(imgs[[1]], imgs[[2]]), stack = FALSE)
  imgl2 <- image_append(c(imgs[[3]], imgs[[4]]), stack = FALSE)
  
  img <- image_scale(image_append(c(imgl1,imgl2), stack = TRUE),1920)
  
  image_write(img, path = dest, format = "jpg" )
}

#fonction pour redimensionner une image
process_img <- function(file){
  w <- if (basename(file) == "header.jpg") 1920 else 800
  img <- image_read(file)
  width <- image_info(img)$width
  if(width > w){
    image_scale(img, w) %>%
      image_write(path = file, format = "jpg")
    TRUE
  } else {
    FALSE
  }
}

redim_all <- function(files){
  if( missing(files) ){
    files <- list.files( "static/img", full.names = TRUE, recursive = TRUE, pattern = "(JPG|jpg)$")
  }
  message( "redimensionnement")
  p <- progress_bar$new(total = length(files))
  vect_modif <- map_lgl(files, ~{
    on.exit(p$tick())
    process_img(.x)
  })
  n_modif <- sum(vect_modif)
  n_total <- length(vect_modif)
  cat("\n")
  message(glue("J'ai modifié {n_modif} fichiers sur {n_total}"))
}

orient_all <- function( files ){
  message( "reorientation")
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
  
  message(glue("J'ai réorienté {length(files)} fichiers"))
  
}

clean_all <- function( files ){
  if( missing(files) ){
    files <- list.files( "static/img", full.names = TRUE, recursive = TRUE, pattern = "jpg$")
  }
  redim_all(files)
  orient_all(files)
}
