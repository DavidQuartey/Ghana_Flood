####Load Package####
library(ggmap)
library(ggplot2)
library(gganimate)


#Import Data into R
ghanafloods <- read.csv("C:/R/ghanafloods.csv")

#Make date R-readable
ghanafloods$date <- as.Date(ghanafloods$date, format = "%d/%m/%Y")

#Order by date
ghanafloods <- ghanafloods[order(ghanafloods$date),]

#Retrieve Ghana Map - uncomment for first time use
#p <- ggmap(get_map("Ghana", zoom = 7))
#saveRDS(p, file = "ghanafloods")
p <- readRDS(file = "ghanafloods")

#Plot Flood points on Ghana Map
p <- p + geom_point(data = ghanafloods, aes(x = lon, y = lat, 
                                            col = Legend, frame = date, 
                                            cumulative = TRUE), alpha = 0.3, size = 7) + 
  geom_jitter(width = 0.25) + scale_color_manual(values ="red1") + 
  labs(title = "Ghana Floods from March, 2016 - July, 2016 \n")

print(p)

#Make Flood GIF
gg_animate(p, outfile = "outfile.html", convert = "gm convert", 
           ani.width = 700, title_frame = TRUE)