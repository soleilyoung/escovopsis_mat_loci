library(ggtree)
library(ggplot2)
library(phytools)
library(rphylopic)
#read in tree (replace file names and object names with specific gene ids)
raMat_1_1_1 <- read.tree("Mat_1_1_1_all.raxml.support")
#get internal node numbers
p <- ggtree(raMat_1_1_1)
p + geom_text2(aes(subset=!isTip, label=node), hjust=-.3) + geom_tiplab()
#root to internal node
raMat_1_1_1_root <- phytools::reroot(raMat_1_1_1, position=0.5, 37)
#round bootstrap values
raMat_1_1_1$node.label <- round(as.numeric(raMat_1_1_1$node.label), digits =3)
raMat_1_1_1$node.label <- as.character(raMat_1_1_1$node.label)
raMat_1_1_1$node.label <- replace(raMat_1_1_1$node.label, 1, "Root")

#plot
proot <- ggtree(raMat_1_1_1,size=0.8) + geom_rootedge(0.2) + geom_tiplab(size=1.9) +
  ggtitle(label="Mat 1-1-1") + geom_treescale(x=0.2,width=0.1) + 
  geom_nodelab(size = 2, hjust = 1.6, vjust= -0.5)
#add ant-agriculture on
ant_ag_info <- read.csv("mat_1_1_1_info.csv",header=TRUE,row.names = "Strain")
p_heatmap <-gheatmap(proot,ant_ag_info, offset = 0.45,
                     width = 0.06, colnames = FALSE, legend_title = "Ant Agriculture") +
  scale_fill_manual(breaks=c("Coral", "Non-ant_associated", "Leafcutter","Lower",
                             "Higher"), 
                    values=c("#EA824A","#DCB9FF", "#1D96D9","#EAB231","#76B1D1"), name="Ant agriculture")
p_heatmap

ggsave("Mat_1_1_1_tree.pdf")
