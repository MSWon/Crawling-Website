install.packages("rvest")
install.packages("stringr")

library(rvest)
library(stringr)

main_url = "https://kin.naver.com/search/list.nhn?sort=none&query=대학생&period=1m&section=kin&page="

kin_list = character()
title_list = character()
date_list = character()

for(page_url in 1:10){
  
    number = 1
    
    url = paste(main_url,page_url,sep="")
    content = read_html(url)
    
    link_node = html_nodes(content,"._nclicks\\:kin\\.txt")
    link_urls = html_attr(link_node, "href")
    title = html_text(link_node)
    title_list = append(title_list, title)
    
    date_node = html_nodes(content,".txt_inline")
    date = html_text(date_node)
    date = as.Date(gsub("\\.","-",date))
    date_list = append(date_list, date)
    

    for(link in link_urls){
      
        sub_content = read_html(link)
        node1 = html_nodes(sub_content, "#contents_layer_0 ._endContentsText")

        kin = html_text(node1)
        kin = gsub("\n|\t","",kin)
        kin_list = append(kin_list, kin)
        
        print(sprintf("Number of article is %d", number))
        number = number + 1 
    }
}

df = data.frame(date_list, title_list, kin_list)
df = df[order(df$date_list,decreasing = FALSE),]

setwd("C:/Users/Big Data Guru/Desktop")
write.csv(df, "네이버지식in.csv" , sep ="," , row.names=FALSE)
