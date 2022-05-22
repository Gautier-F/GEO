library(Seurat)


list_dir = list.dirs()[-1]
list_dir = gsub("./", "", list_dir)

# Initializes the progress bar
pb <- txtProgressBar(min = 0,      # Minimum value of the progress bar
                     max = length(list_dir), # Maximum value of the progress bar
                     style = 3,    # Progress bar style (also available style = 1 and style = 2)
                     width = 50,   # Progress bar width. Defaults to getOption("width")
                     char = "=")   # Character used to create the bar
i = 1
for ( d in list_dir ){

	list_f = list.files(paste(d, "/",sep = ""))
	features = "../../../GSE161529_features.tsv"
	
	rawData = ReadMtx(mtx = paste(d, "/", list_f[2], sep = ""),
					  cells = paste(d, "/", list_f[1], sep = ""),
					  features = features) 
					  
	so = CreateSeuratObject(counts = rawData, project = d, min.cells = 3)
	
	saveRDS(so, paste(d,".rds",sep=""))
	
	setTxtProgressBar(pb, i)
	i = i+1
}
close(pb)




