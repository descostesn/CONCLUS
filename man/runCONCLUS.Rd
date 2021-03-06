\name{runCONCLUS}
\alias{runCONCLUS}
\title{Run all CONCLUS steps at once}
\description{
This function performs the core CONCLUS workflow. 
}
\usage{
runCONCLUS <- function(dataDirectory, experimentName, columnsMetaData = NA,
		species = NA, colorPalette="default", statePalette="default",
		clusteringMethod="ward.D2", epsilon=c(1.3, 1.4, 1.5), minPoints=c(3, 4),
		k=0, PCs=c(4, 6, 8, 10, 20, 40, 50), perplexities=c(30,40), randomSeed = 42,
		deepSplit=4, preClustered = F, orderClusters = FALSE, cores=1,
		plotPDFcellSim = TRUE, deleteOutliers = TRUE, tSNEalreadyGenerated = FALSE,
		tSNEresExp = "", manualClusteringObject = NA)
}
\arguments{

\item{dataDirectory}{CONCLUS will create this directory if it doesn't exist and store there all output files.}

\item{experimentName}{Prefix used for output files.}

\item{columnsMetaData}{A data frame with information about cells. Not used if manualClusteringObject is defined. See details. Default = NA.}

\item{species}{Currently limited to human and mouse. Possible values are either 'mmu' or 'human'. Not used if manualClusteringObject is defined. Default = NA.}

\item{colorPalette}{A vector of colors for clusters. Default = "default", see details.}

\item{statePalette}{A vector of colors for states or conditions. Default = "default", See details.}

\item{clusteringMethod}{Clustering method passed to hclust() function. See ?hclust for a list of method. Default = "ward.D2"}

\item{epsilon}{Reachability distance parameter of fpc::dbscan() function. See Ester et al. (1996) for more details. Default = c(1.3, 1.4, 1.5)}

\item{minPoints}{Reachability minimum no. of points parameter of fpc::dbscan() function. See Ester et al. (1996) for more details. Default = c(3, 4)}

\item{k}{Preferred number of clusters. Alternative to deepSplit. A parameter of cutree() function. Default = 0}

\item{PCs}{a vector of first principal components.
For example, to take ranges 1:5 and 1:10 write c(5, 10). Default = c(4, 6, 8, 10, 20, 40, 50)}

\item{perplexities}{Numeric scalar defining the perplexity parameter, see ‘?Rtsne’ for more details. Default = c(30, 40)}

\item{randomSeed}{Random seed for reproducibility. Default = 42}

\item{deepSplit}{intuitive level of clustering depth. Options are 1, 2, 3, 4. Default = 4}

\item{preClustered}{Boolean precising if DBSCAN is run to calculate similarity matrices. Should be TRUE if manualClusteringObject is defined. Default="FALSE"}

\item{orderClusters}{If True, clusters in the similarity matrix of cells will be ordered by name. Default = FALSE}

\item{cores}{maximum number of jobs that CONCLUS can run in parallel. Default = 1}

\item{plotPDFcellSim}{if TRUE, the similarity matrix of cells will be saved in pdf format; png if FALSE.
FALSE is recommended for count matrices with more than 2500 cells due to large pdf file size. Default = TRUE}

\item{deleteOutliers}{ Boolean indicating if whether cells which were often defined as outliers by dbscan must be deleted.
It will require recalculating of the similarity matrix of cells. Default = FALSE.}

\item{tSNEalreadyGenerated}{TRUE if you already ran CONCLUS ones and have t-SNE coordinated saved. Default = FALSE}

\item{tSNEresExp}{experimentName of t-SNE coordinates which you want to use. This argument allows copying and pasting t-SNE coordinates between different CONCLUS runs without renaming the files. Default = ""}

\item{manualClusteringObject}{Result of the function addClusteringManually. Default = NA. See details}
}
\value{
A SingleCellExperiment object.
}
\details{
  This function performs the following steps: 1) It generates PCA and t-SNE coordinates, 2) runs DBSCAN 
3) Calculates similarity matrices of cells and clusters, 4) Assigns cells to clusters, 5) Searches for positive markers 
for each cluster, 6) Saves plots and tables into dataDirectory.

  columnsMetaData -- Dataframe containing three columns: cellName, state, and cellBarcode. Not used if manualClusteringObject is defined.
  
  colorPalette/statePalette -- A vector of colors for clusters/states or 'default' value. If 'default' is selected, the number of clusters is limited to 16. 
If an error message is thrown, re-run the function with your own color vector.  

  manualClusteringObject -- After running once runCONCLUS, one could which to modify the obtained clusters manually. This is achieved with the function 'addClusteringManually'. The result of 'addClusteringManually' should be passed
  to the manualClusteringObject parameter to re-run CONCLUS on the new defined clusters.

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
  
}
\keyword{CONCLUS}
\seealso{
  \code{\link{initialisePath}}
  \code{\link{normaliseCountMatrix}}
  \code{\link{generateTSNECoordinates}}
  \code{\link{runDBSCAN}}
  \code{\link{clusterCellsInternal}}
  \code{\link{plotCellSimilarity}}
  \code{\link{plotClusteredTSNE}}
  \code{\link{calculateClustersSimilarity}}
  \code{\link{exportMatrix}}
  \code{\link{rankGenes}}
  \code{\link{plotClustersSimilarity}}
}
 