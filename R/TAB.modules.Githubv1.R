packages=c("dplyr")
if (!require("BiocManager")) install.packages("BiocManager")
#Checking if the package belongs to CRAN or to Bioconductor and installing them accordingly.
for(lib in packages){
  if(!lib %in% installed.packages()){
    if(lib %in% available.packages()[,1]){
      install.packages(lib,dependencies=TRUE)
    }else {(BiocManager::install(lib))
    }}
}
#Loading the libraries
sapply(packages,require,character=TRUE)


#############calculate TAB based on a list of TAAs
calculate.TAB.combine<-function(tumor.expData,normal.expData,TAA.List){
  TAA.List<-intersect(TAA.List,rownames(tumor.expData))
  TAA.List<-intersect(TAA.List,rownames(normal.expData))
  tumor.expData<-tumor.expData[TAA.List,] %>% as.data.frame()
  normal.expData<-normal.expData[TAA.List,] %>% as.data.frame()
  normal.expData$rank.percentile<-apply(normal.expData,1,function(x){quantile(x,probs = 0.95) %>% as.numeric()})
  TAB<-apply(tumor.expData,2,function(x){
    y=(x[!is.na(x)]-normal.expData$rank.percentile[!is.na(x)])*10
    if (sum(y>709)>0){
      y <- mpfr(y, precBits = 106)
    }
    z=as.numeric(exp(y)/(1+exp(y)))
    TAB=sum(z)/length(x[!is.na(x)])
    return(TAB)
  })
  return(TAB)
}

