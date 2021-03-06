exportMatrix <- function(matrix, dataDirectory, experimentName, name){
	
	fileName <- paste0(experimentName, "_", name, ".csv")
	write.table(matrix, file=file.path(dataDirectory, "output_tables", fileName),
			sep = ",")
}


exportData <- function(sceObject, dataDirectory, experimentName){
	# exports all the data from workflow, including .RData files
	
	outputDataDirectory <- "output_tables"
	
	################ EXPORT MATRIX, COLDATA, ROWDATA, FULL WORKSPACE
	write.table(Biobase::exprs(sceObject), file=file.path(dataDirectory,
					outputDataDirectory, paste0(experimentName, "_",
							"expression_matrix.tsv")), sep="\t",
			row.names = TRUE, quote = FALSE, col.names = TRUE)
	write.table(SummarizedExperiment::colData(sceObject), file=file.path(dataDirectory,
					outputDataDirectory, paste0(experimentName, "_",
							"colData.tsv")), sep="\t",
			row.names = TRUE, quote = FALSE, col.names = TRUE)
	write.table(rowData(sceObject), file=file.path(dataDirectory,
					outputDataDirectory, paste0(experimentName, "_",
							"rowData.tsv")), sep="\t",
			row.names = TRUE, quote = FALSE, col.names = TRUE)
	save.image(file=file.path(dataDirectory, outputDataDirectory,
					paste0(experimentName, "_", "full_workspace.RData")))
	
}

exportClusteringResults <- function(sceObject, dataDirectory,
		experimentName, fileName){
	
	tableData <- S4Vectors::DataFrame(clusters = SummarizedExperiment::colData(sceObject)$clusters,
			row.names = SummarizedExperiment::colData(sceObject)$cellName)
	write.table(tableData,
			file = file.path(dataDirectory, "output_tables",
					paste0(experimentName,"_", fileName)),
			sep = "\t", quote = FALSE)
}
