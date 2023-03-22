library(ggplot2)
library(gggenes)

data <- read.csv("mydata.csv")
data2 <- read.csv("mydata2.csv")

ggplot(data, aes(xmin = start, xmax = end, y = molecule, fill = gene)) +
  geom_gene_arrow() +
  facet_wrap(~ molecule, scales = "free", ncol = 1) +
  scale_fill_brewer(palette = "Set3")


#Beautifying the plot with theme_genes


ggplot(data, aes(xmin = start, xmax = end, y = molecule, fill = gene)) +
  geom_gene_arrow() +
  facet_wrap(~ molecule, scales = "free", ncol = 1) +
  scale_fill_brewer(palette = "Set3") +
  theme_genes()


#Aligning genes across facets with make_alignment_dummies()


dummies <- make_alignment_dummies(
  data,
  aes(xmin = start, xmax = end, y = molecule, id = gene),
  on = "genE"
)

ggplot(data, aes(xmin = start, xmax = end, y = molecule, fill = gene)) +
  geom_gene_arrow() +
  geom_blank(data = dummies) +
  facet_wrap(~ molecule, scales = "free", ncol = 1) +
  scale_fill_brewer(palette = "Set3") +
  theme_genes()


#Labelling genes with geom_gene_label()


ggplot(
    data,
    aes(xmin = start, xmax = end, y = molecule, fill = gene, label = gene)
  ) +
  geom_gene_arrow(arrowhead_height = unit(3, "mm"), arrowhead_width = unit(1, "mm")) +
  geom_gene_label(align = "left") +
  geom_blank(data = dummies) +
  facet_wrap(~ molecule, scales = "free", ncol = 1) +
  scale_fill_brewer(palette = "Set3") +
  theme_genes()

#Reversing gene direction with the optional forward aesthetic

ggplot(data, aes(xmin = start, xmax = end, y = molecule, fill = gene, 
                          forward = orientation)) +
  geom_gene_arrow() +
  facet_wrap(~ molecule, scales = "free", ncol = 1) +
  scale_fill_brewer(palette = "Set3") +
  theme_genes()

#Viewing subgene segments


ggplot(data, aes(xmin = start, xmax = end, y = molecule)) +
  facet_wrap(~ molecule, scales = "free", ncol = 1) +
  geom_gene_arrow(fill = "white") +
  geom_subgene_arrow(data = data2,
    aes(xmin = start, xmax = end, y = molecule, fill = gene,
        xsubmin = from, xsubmax = to), color="black", alpha=.7) +
  theme_genes()


#strand

ggplot(subset(data, molecule == "Genome4" & gene == "genA"),
       aes(xmin = start, xmax = end, y = strand)
  ) +
  geom_gene_arrow() +
  geom_gene_label(aes(label = gene)) +
  geom_subgene_arrow(
    data = subset(data2, molecule == "Genome4" & gene == "genA"),
    aes(xsubmin = from, xsubmax = to, fill = subgene)
  ) +
  geom_subgene_label(
    data = subset(data2, molecule == "Genome4" & gene == "genA"),
    aes(xsubmin = from, xsubmax = to, label = subgene),
    min.size = 0
  )









































