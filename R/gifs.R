library(magick)

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
