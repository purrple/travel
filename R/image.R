
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
  cat("\n")
  message(glue("J'ai modifié {n_modif} fichiers sur {n_total}"))
  
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

#fonction pour redimensionner une image
process_img <- function(file){

  if (basename(file) == "header.jpg"){
    redim_img(file, w=1920)
  } else {
    redim_img(file, w=800)
    }
}

re#gif alix qui saute
img1 <- image_read("/Users/romain/git/travel/static/img/nyc-2018/times-square/IMG_3480.jpg")
img2 <- image_read("/Users/romain/git/travel/static/img/nyc-2018/times-square/IMG_3481.jpg")
img3 <- image_read("/Users/romain/git/travel/static/img/nyc-2018/times-square/IMG_3482.jpg")
img4 <- image_read("/Users/romain/git/travel/static/img/nyc-2018/times-square/IMG_3483.jpg")
img5 <- image_read("/Users/romain/git/travel/static/img/nyc-2018/times-square/IMG_3484.jpg")
img6 <- image_read("/Users/romain/git/travel/static/img/nyc-2018/times-square/IMG_3485.jpg")

vect <- c(img1,img2,img3,img4,img5,img6)
vect <- image_scale(vect, 800)
gif <- image_animate(vect, fps = 5)

image_write(image = gif, path= "/Users/romain/git/travel/static/img/nyc-2018/times-square/alix.gif", 
  format = "gif")

#gif
img1 <- image_read("/Users/romain/git/travel/static/img/nyc-2018/times-square/IMG_3388.jpg")
img2 <- image_read("/Users/romain/git/travel/static/img/nyc-2018/times-square/IMG_3389.jpg")

vect <- c(img1,img2)
vect <- image_scale(vect, 800)
gif <- image_animate(vect, fps = 5)

image_write(image = gif, path= "/Users/romain/git/travel/static/img/nyc-2018/times-square/romain.gif", 
  format = "gif")
