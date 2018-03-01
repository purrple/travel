library(magick)

#' animation de n images
#' 
#' @param src Les images à animer

src = c("/home/cecile/Images/guibb.jpg", "/home/cecile/Images/guibb2.jpg", "/home/cecile/Images/ccbb.jpg") 
anim <- function(src, vitesse, taille ){
  n <- length(src)
  img <- src %>%
    image_read() %>%
    image_scale(taille) %>%
    image_animate(fps = vitesse)
  img
}

anim(src, 2, 200)

runGist("https://gist.githubusercontent.com/jeroen/bd1d0a30e7184a5320695ee2bda12c70/raw/ece820dc1b13e5c97e6df48f3792097e09647506/magickshiny.R")

source("https://gist.githubusercontent.com/jeroen/bd1d0a30e7184a5320695ee2bda12c70/raw/ece820dc1b13e5c97e6df48f3792097e09647506/magickshiny.R")


img1 <- image_read("static/img/nyc-2018/times-square/IMG_3480.jpg")
img2 <- image_read("static/img/nyc-2018/times-square/IMG_3481.jpg")
img3 <- image_read("static/img/nyc-2018/times-square/IMG_3482.jpg")
img4 <- image_read("static/img/nyc-2018/times-square/IMG_3483.jpg")
img5 <- image_read("static/img/nyc-2018/times-square/IMG_3484.jpg")
img6 <- image_read("static/img/nyc-2018/times-square/IMG_3485.jpg")

vect <- c(img1,img2,img3,img4,img5,img6)
vect <- image_scale(vect, 800)
gif <- image_animate(vect, fps = 5)

image_write(image = gif, path= "static/img/nyc-2018/times-square/alix.gif", 
  format = "gif")

#gif
img1 <- image_read("static/img/nyc-2018/times-square/IMG_3388.jpg")
img2 <- image_read("static/img/nyc-2018/times-square/IMG_3389.jpg")

vect <- c(img1,img2)
vect <- image_scale(vect, 800)
gif <- image_animate(vect, fps = 5)

image_write(image = gif, path= "static/img/nyc-2018/times-square/romain.gif", 
  format = "gif")
