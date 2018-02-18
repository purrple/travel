library(purrr)
library(glue)
library(magick)
library(assertthat)

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
  if (basename(file) == "header.jpg"){
    redim_img(file, w=1920)
  } else {
    redim_img(file, w=800)
  }
}

redim_img <-function(file, w){
  img <- image_read(file)
  width <- image_info(img)$width
  if(width > w){
    cat( glue("\rredim {file}                                                ") )
    image_scale(img, w) %>%
      image_write(path = file, format = "jpg")
    TRUE
  } else {
    cat( glue("\r{file} deja redim                                            ") )
    FALSE
  }
}

redim_all <- function(){
  files <- list.files("static/img", pattern="jpg$", recursive=TRUE, full.names=TRUE)
  vect_modif <- map_lgl(files, process_img)
  n_modif <- sum(vect_modif)
  n_total <- length(vect_modif)
  cat("\n")
  message(glue("J'ai modifié {n_modif} fichiers sur {n_total}"))
}


