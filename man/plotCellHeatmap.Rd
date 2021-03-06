\name{plotCellHeatmap}
\alias{plotCellHeatmap}
\title{Generate markers heatmap.}
\description{
This function plots heatmap with marker genes on rows and clustered cells on columns.
}
\usage{
plotCellHeatmap(markersClusters, sceObject, dataDirectory, experimentName,
  fileName, meanCentered = TRUE, colorPalette = "default",
  statePalette = "default", clusteringMethod = "ward.D2",
  orderClusters = FALSE, similarity = FALSE, orderGenes = FALSE, returnPlot = FALSE,
  saveHeatmapTable = FALSE, width = 10, height = 8.5, ...)
}
\arguments{

\item{markersClusters}{Dataframe obtained from conclus::getMarkerGenes() function. See  details.}

\item{sceObject}{A SingleCellExperiment object with your experiment.}

\item{dataDirectory}{Output directory of a given CONCLUS run (supposed to be the same than the one used with runCONCLUS).}

\item{experimentName}{Prefix used for output files (supposed to be the same than the one used with runCONCLUS).}

\item{fileName}{Name of the output file}

\item{meanCentered}{Boolean, should mean centering be applied to the expression data or not. Default = TRUE.}

\item{colorPalette}{A vector of colors for clusters. Default = "default", see details.}

\item{statePalette}{A vector of colors for states or conditions. Default = "default", See details.}

\item{clusteringMethod}{Clustering method passed to hclust() function. See ?hclust for a list of method. Default = "ward.D2"}

\item{orderClusters}{If True, clusters in the similarity matrix of cells will be ordered by name. Default = FALSE}

\item{similarity}{Boolean, should the heatmap be structured by similarities. Default = FALSE.}

\item{orderGenes}{Boolean, should the heatmap be structured by gene. Default = FALSE.}

\item{returnPlot}{Boolean, whether to return a ggplot object with the plot or not. Default = FALSE}

\item{saveHeatmapTable}{Boolean, whether to save the expression matrix used for heatmap into a .csv file or not.
The file will be saved into 'dataDirectory/output_tables' with the same name as the .pdf plot.}

\item{width}{Width of the plot. Default = 10.}

\item{height}{Height of the plot. Default = 8.5.}

\item{...}{Additional parameters to pass to pdf() and pheatmap() functions.}
}
\value{
A ggplot object of the plot if needed. The function saves pdf in "dataDirectiry/pictures" folder.
}
\details{

   markersClusters -- Data frame where the first column is "geneName", corresponding to the ones of sceObject, and the second column is their corresponding "clusters". All names from that column must come from the column 
"clusters" of the colData(sceObject).

  colorPalette/statePalette -- A vector of colors for clusters/states or 'default' value. If 'default' is selected, the number of clusters is limited to 16. 
If an error message is thrown, re-run the function with your own color vector.

}
\examples{

  outputDirectory <- "./YourOutputDirectory" ## Replace by the path to the directory in which results should be written
  experimentName <- "Bergiers"

  countMatrix <- read.delim(file.path(system.file("extdata", package = "conclus"),
                                    "Bergiers_counts_matrix_filtered.tsv"), 
                          stringsAsFactors = FALSE)
  columnsMetaData <- read.delim(file.path(system.file("extdata", package = "conclus"), 
                                "Bergiers_colData_filtered.tsv"))

  sceObjectCONCLUS <- runCONCLUS(outputDirectory, 
                               experimentName,
                               columnsMetaData,
		                       species = "mmu", 
                               plotPDFcellSim = TRUE, # FALSE for > 2500 cells
                               k = 10, cores = 1,
                               statePalette = c("bisque", "cadetblue2", 
                                                "coral1", "cornflowerblue"),
                               deleteOutliers = FALSE)

  genesNumber <- 10
  markersClusters <- conclus::getMarkerGenes(outputDirectory, sceObjectCONCLUS, 
                                  experimentName = experimentName,
                                  genesNumber = genesNumber)
                                  
  orderClusters <- T # F will apply hierarchical clustering to all cells
  orderGenes <- T    # F will apply hierarchical clustering to all genes
  meanCentered <- T  # F to show normalized counts

  conclus::plotCellHeatmap(markersClusters, sceObjectCONCLUS, outputDirectory, 
                experimentName, 
                paste0("clusters",
                       length(levels(SummarizedExperiment::colData(sceObjectCONCLUS)$clusters)),
                       "_meanCentered",meanCentered,
                       "_orderClusters",orderClusters,
                       "_orderGenes",orderGenes,"_top",
                       genesNumber, "markersPerCluster"), 
                meanCentered = meanCentered, 
                colorPalette = RColorBrewer::brewer.pal(10, "Paired"),
                orderClusters = orderClusters,
                orderGenes = orderGenes,
                fontsize_row = 4,
                statePalette = c("bisque", "cadetblue2", 
                                 "coral1", "cornflowerblue"),
                color = colorRampPalette(c("#023b84","#4b97fc", 
                                           "#FEE395", 
                                           "#F4794E", "#D73027",
                                           "#a31008","#7a0f09"))(100),
                returnPlot = TRUE,
                width = 7.5, height = 6.5)

}

