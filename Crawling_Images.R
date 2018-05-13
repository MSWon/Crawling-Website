install.packages("rvest")
install.packages("stringr")

library(rvest)
library(stringr)

url = "http://news.naver.com/main/read.nhn?mode=LSD&mid=shm&sid1=100&oid=421&aid=0003064130" ## with image

sess <- read_html(url)
node <- html_node(sess,"#articleBodyContents img")
imgurl <- html_attr(node,"src")

download.file(imgurl, destfile = "image_test.jpeg" , method = 'curl')

