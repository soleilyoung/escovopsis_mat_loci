#libraries
library(ggplot2)

#fubar
fubar_csv<- read.csv("fubar.csv")
purifying_selection <- fubar_csv$X.beta...alpha.
purifying_selection_plot <- ggplot(fubar_csv,aes(x=purifying_selection))+
  geom_density(fill="#434490",alpha=0.8)+
  geom_vline(xintercept=0, linetype='dotted', col = 'black')+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))
purifying_selection_plot + labs(title="gene_id",x="Strength of purifiying selection (beta - alpha)",y="Density")+
  theme(plot.title = element_text(face = "italic")) +xlim(-20,5)
ggsave("fubar_selection.pdf")


purifying_selection_prob <- fubar_csv$Prob..alpha...beta..
purifying_selection_probplot <- ggplot(fubar_csv,aes(x=purifying_selection_prob))+
  geom_density(fill="#434490",alpha=0.8)+
  geom_vline(xintercept=0.95, linetype='dotted', col = 'black')+
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_line(colour = "black"))
purifying_selection_probplot
purifying_selection_probplot + labs(title="gene_id",x="Posterior probability of purifying selection [alpha > beta]",y="Density")+
  theme(plot.title = element_text(face = "italic")) +xlim(0,1)
ggsave("fubar_pp.pdf")


