
#install.package("magick")
library("magick")
img1 <- image_read("/Users/romain/git/travel/static/img/nyc-2018/brooklyn-botanical-garden/agrume1.jpg")
img2 <- image_read("/Users/romain/git/travel/static/img/nyc-2018/brooklyn-botanical-garden/agrume2.jpg")
img3 <- image_read("/Users/romain/git/travel/static/img/nyc-2018/brooklyn-botanical-garden/agrume3.jpg")
img4 <- image_read("/Users/romain/git/travel/static/img/nyc-2018/brooklyn-botanical-garden/agrume4.jpg")

imgl1 <- image_append(c(img1, img2), stack = FALSE)
imgl2 <- image_append(c(img3, img4), stack = FALSE)

img <- image_scale(image_append(c(imgl1,imgl2), stack = TRUE),1920)

image_write(img, path = "/Users/romain/git/travel/static/img/nyc-2018/brooklyn-botanical-garden/agrumes.jpg", format = "jpg")


#recuperer le nom du fichier
library(purrr)
library(glue)

redim_all <- function(){
  files <- list.files("static/img", pattern="jpg$", recursive=TRUE, full.names=TRUE)
  vect_modif <- map_lgl(files, process_img)
  n_modif <- sum(vect_modif)
  n_total <- length(vect_modif)
  
  message(glue("J'ai modifié {n_modif} fichiers sur {n_total}"))
  
}

redim_img <-function(file, w){
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

#fonction pour redimensionner une image
process_img <- function(file){

  if (basename(file) == "header.jpg"){
    redim_img(file, w=1920)
  } else {
    redim_img(file, w=800)
    }
}

#aller dans les bons répertoires


