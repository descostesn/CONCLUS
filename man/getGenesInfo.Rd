\name{getGenesInfo}
\alias{getGenesInfo}
\title{Collect genes information to one table.}
\description{
The function takes a data frame containing gene symbols and (or) ENSEMBL IDs and returns
a data frame with additional information.
}
\usage{
getGenesInfo(genes, databaseDir = system.file("extdata", package =
  "conclus"), groupBy = "clusters", orderGenes = "initial",
  getUniprot = TRUE, silent = FALSE, cores = 1)
}
\arguments{
\item{genes}{A data frame with the first column called "geneName" containing gene symbols and (or) ENSEMBL IDs.
Other columns are optional. For example, the second column could be "clusters" with the name of the cluster 
for which the gene is a marker. Optional columns are kept in the output.}

\item{databaseDir}{A path to the database provided with CONCLUS. Default = "Mmus_gene_database_secretedMol.tsv".}

\item{groupBy}{A column in the input table used for grouping the genes in the output tables.
This option is useful if a table contains genes from different clusters. Default = "clusters"}

\item{orderGenes}{If "initial" then the order of genes will not be changed. The other option is "alphabetical". Default = "initial".}

\item{getUniprot}{Boolean, whether to get information from UniProt or not. Default = TRUE.}

\item{silent}{Whether to show messages from intermediate steps or not. Default = FALSE}

\item{cores}{Maximum number of jobs that the function can run in parallel. Default = 1}
}
\value{
Returns a data frame with different information. See details.
}
\details{

  The output dataframe is composed of the following columns:
  
  - geneName: official gene symbol or ENSEMBL ID.
  - clusters: The cluster to which the gene is associated.
  - Name: The complete gene name.
  - Feature.Type: protein coding gene, lincRNA gene, miRNA gene, unclassified non-coding RNA gene,
                 or pseudogene.
  - go_id: Gene Ontology (GO) identification number.
  - name_1006: Whether or not a gene belongs to GO terms containing proteins on the cell surface or 
               involved in secretion.
  - MGI: Knockout information from MGI.
  - NCBI: A summary from NCBI.
  - chromosome_name: The chromosome on which the gene is located    
  - Symbol: Official gene symbol
  - Ensembl: Ensembl ID
  - MGI.Gene.Marker.ID: MGI ID
  - Entrez.Gene.ID: Entrez ID
  - Uniprot.ID: Uniprot ID
}