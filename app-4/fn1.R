    dt=read.table('data/xx.txt', header=T,row.names=1);
    hist(dt[,1], n=10)
    plot(dt[,1], dt[,2])
    library('pheatmap')
    pheatmap(dt, scale='row')