#' @title Plot Kaplan-Meier survival curve.
#' @description The function `get_mut_survivalresult` uses to draw the Kaplan-Meier survival curve based on the mutated status of candidate module.
#' @param module The gene module,generated by `get_final_candidate_module`.
#' @param freq_matrix The mutations matrix,generated by `get_mut_status`.
#' @param sur A nx2 data frame of samples' survival data,the first line is samples' survival event and the second line is samples' overall survival.
#' @importFrom survival survfit
#' @importFrom survival Surv
#' @importFrom survminer ggsurvplot
#' @importFrom survminer theme_survminer
#' @importFrom patchwork wrap_plots
#' @importFrom utils read.delim
#' @return No return value
#' @export
#' @examples
#' #load the data.
#' data(mut_status)
#' sur<-system.file("extdata","sur.csv",package="ProgModule")
#' sur<-read.delim(sur,sep=",",header=TRUE,row.names=1)
#' data(final_candidate_module)
#' #perform the function `get_mut_survivalresult`.
#' get_mut_survivalresult(module=final_candidate_module,freq_matrix=mut_status,sur)

get_mut_survivalresult<-function(module,freq_matrix,sur){
  splots = list()
  length(module)
  for(n in 1:length(module)){
    #print(n)
    freq_matrix<-as.data.frame(freq_matrix)
    module_matrix<-freq_matrix[module[[n]],]
    sample_mut<-colSums(module_matrix)
    sample_mut[which(sample_mut>1)]<-1
    data<-cbind(sur,sample_mut)
    fit <- survfit(Surv(survival, event) ~ sample_mut, data = data)
    splots[[n]]<-ggsurvplot(fit, data = data,pval.size=3,conf.int = FALSE,pval = TRUE,title=paste0("M",n),palette=c("#1E76B5","#FF7E0E"),legend="right",legend.labs=c("WT","Mutant"),break.time.by = 2000,ggtheme=theme_survminer())$plot
  }

  p1<-patchwork::wrap_plots(splots)+patchwork::plot_layout(guides = "collect")###这个代码是按行排序,可以自己定义行列数
  p1
}

#' @title Draw a waterfall plot of mutated genes involved in the module
#' @description Load the data in MAF format and draws a waterfall plot of mutated genes involved in the module.
#' @param maf The patients' somatic mutation data, which in MAF format.
#' @param genes Modular gene set from final_candidate_module,generated by `get_final_candidate_module`.
#' @param removeNonMutated,top,minMut,altered,drawRowBar,drawColBar,leftBarData,leftBarLims,rightBarData,rightBarLims,topBarData,logColBar,includeColBarCN,clinicalFeatures,annotationColor,annotationDat,pathways,path_order,selectedPathways,pwLineCol,pwLineWd,draw_titv,titv_col,showTumorSampleBarcodes,barcode_mar,barcodeSrt,gene_mar,anno_height,legend_height,sortByAnnotation,groupAnnotationBySize,annotationOrder,sortByMutation,keepGeneOrder,GeneOrderSort,sampleOrder,additionalFeature,additionalFeaturePch,additionalFeatureCol,additionalFeatureCex,genesToIgnore,fill,cohortSize,colors,cBioPortal,bgCol,borderCol,annoBorderCol,numericAnnoCol,drawBox,fontSize,SampleNamefontSize,titleFontSize,legendFontSize,annotationFontSize,sepwd_genes,sepwd_samples,writeMatrix,colbar_pathway,showTitle,titleText,showPct see \code{\link[maftools]{oncoplot}}
#' @importFrom maftools oncoplot
#' @importFrom maftools read.maf
#' @return No return value
#' @export
#' @examples
#' #load the data.
#' maffile<-system.file("extdata","maffile.maf",package="ProgModule")
#' data(final_candidate_module)
#' #draw an oncoplot
#' get_oncoplots(maf=maffile,genes=final_candidate_module[[1]])

get_oncoplots<-function(maf,genes,removeNonMutated = TRUE,top = 20,minMut = NULL,altered = FALSE,drawRowBar = TRUE,drawColBar = TRUE,
                        leftBarData = NULL,leftBarLims = NULL,rightBarData = NULL,rightBarLims = NULL,topBarData = NULL,logColBar = FALSE,includeColBarCN = TRUE,
                        clinicalFeatures = NULL,annotationColor = NULL,annotationDat = NULL,pathways = NULL,path_order = NULL,selectedPathways = NULL,
                        pwLineCol = "#535c68",pwLineWd = 1,draw_titv = FALSE,titv_col = NULL,showTumorSampleBarcodes = FALSE,barcode_mar = 4,
                        barcodeSrt = 90,gene_mar = 5,anno_height = 1,legend_height = 4,sortByAnnotation = FALSE,groupAnnotationBySize = TRUE,annotationOrder = NULL,
                        sortByMutation = FALSE,keepGeneOrder = FALSE,GeneOrderSort = TRUE,sampleOrder = NULL,additionalFeature = NULL,additionalFeaturePch = 20,additionalFeatureCol = "gray70",
                        additionalFeatureCex = 0.9,genesToIgnore = NULL,fill = TRUE,cohortSize = NULL,colors = NULL,cBioPortal = FALSE,bgCol = "#CCCCCC",
                        borderCol = "white",annoBorderCol = NA,numericAnnoCol = NULL,drawBox = FALSE,fontSize = 0.8,SampleNamefontSize = 1,titleFontSize = 1.5,
                        legendFontSize = 1.2,annotationFontSize = 1.2,sepwd_genes = 0.5,sepwd_samples = 0.25,writeMatrix = FALSE,colbar_pathway = FALSE,
                        showTitle = TRUE,titleText = NULL,showPct = TRUE){
  maf<-read.maf(maf,isTCGA=T)
  oncoplot(maf=maf,genes=genes,removeNonMutated = removeNonMutated,top =top,minMut = minMut,altered = altered,drawRowBar = drawRowBar,drawColBar = drawColBar,
           leftBarData = leftBarData,leftBarLims = leftBarLims,rightBarData = rightBarData,rightBarLims = rightBarLims,topBarData = topBarData,logColBar = logColBar,includeColBarCN = includeColBarCN,
           clinicalFeatures = clinicalFeatures,annotationColor = annotationColor,annotationDat = annotationDat,pathways = pathways,path_order = path_order,selectedPathways = selectedPathways,
           pwLineCol =pwLineCol,pwLineWd=pwLineWd,draw_titv = draw_titv,titv_col = titv_col,showTumorSampleBarcodes = showTumorSampleBarcodes,barcode_mar = barcode_mar,
           barcodeSrt = barcodeSrt,gene_mar = gene_mar,anno_height =anno_height,legend_height = legend_height,sortByAnnotation = sortByAnnotation,groupAnnotationBySize = groupAnnotationBySize,annotationOrder = annotationOrder, sortByMutation = sortByMutation,keepGeneOrder = keepGeneOrder,
           GeneOrderSort = GeneOrderSort,sampleOrder = sampleOrder,additionalFeature = additionalFeature,additionalFeaturePch = additionalFeaturePch,additionalFeatureCol =additionalFeatureCol,
           additionalFeatureCex = additionalFeatureCex,genesToIgnore = genesToIgnore,fill = fill,cohortSize = cohortSize,colors = colors,cBioPortal = cBioPortal,bgCol = bgCol,
           borderCol = borderCol,annoBorderCol = annoBorderCol,numericAnnoCol = numericAnnoCol,drawBox = drawBox,fontSize = fontSize,SampleNamefontSize = SampleNamefontSize,titleFontSize = titleFontSize,
           legendFontSize = legendFontSize,annotationFontSize = annotationFontSize,sepwd_genes = sepwd_genes,sepwd_samples = sepwd_samples,writeMatrix = writeMatrix,colbar_pathway = colbar_pathway,
           showTitle = showTitle,titleText = titleText,showPct = showPct)
}


#' @title Draw an lollipopPlot for module genes
#' @description Load the data in MAF format and draws an lollipopPlot.
#' @param maf The patients' somatic mutation data, which in MAF format.
#' @param gene Modular gene from final_candidate_module,generated by `get_final_candidate_module`.
#' @param AACol,labelPos,labPosSize,showMutationRate,showDomainLabel,cBioPortal,refSeqID,proteinID,roundedRect,repel,collapsePosLabel,showLegend,legendTxtSize,labPosAngle,domainLabelSize,axisTextSize,printCount,colors,domainAlpha,domainBorderCol,bgBorderCol,labelOnlyUniqueDoamins,defaultYaxis,titleSize,pointSize see \code{\link[maftools]{lollipopPlot}}
#' @importFrom maftools lollipopPlot
#' @importFrom maftools read.maf
#' @return No return value
#' @export
#' @examples
#' #load the data.
#' maffile<-system.file("extdata","maffile.maf",package="ProgModule")
#' #draw an lollipopPlot
#' get_lollipopPlot(maf=maffile,gene="TP53")

get_lollipopPlot<-function(maf,gene ,AACol = NULL,labelPos = NULL,labPosSize = 0.9, showMutationRate = TRUE,showDomainLabel = TRUE,
                           cBioPortal = FALSE,refSeqID = NULL,proteinID = NULL,roundedRect = TRUE,repel = FALSE,collapsePosLabel = TRUE,showLegend = TRUE,legendTxtSize = 0.8,
                           labPosAngle = 0,domainLabelSize = 0.8,axisTextSize = c(1, 1),printCount = FALSE,colors = NULL,domainAlpha = 1,domainBorderCol = "black",
                           bgBorderCol = "black",labelOnlyUniqueDoamins = TRUE,defaultYaxis = FALSE,titleSize = c(1.2, 1),pointSize = 1.5){
  maf<-read.maf(maf,isTCGA=T)
  lollipopPlot(maf=maf,gene = gene,AACol = AACol,labelPos = labelPos,labPosSize = labPosSize, showMutationRate = showMutationRate,showDomainLabel = showDomainLabel,
               cBioPortal = cBioPortal,refSeqID = refSeqID,proteinID = proteinID,roundedRect = roundedRect,repel = repel,collapsePosLabel = collapsePosLabel,showLegend = showLegend,legendTxtSize = legendTxtSize,
               labPosAngle = labPosAngle,domainLabelSize = domainLabelSize,axisTextSize = axisTextSize,printCount = printCount,colors = colors,domainAlpha = domainAlpha,domainBorderCol = domainBorderCol,
               bgBorderCol = bgBorderCol,labelOnlyUniqueDoamins = labelOnlyUniqueDoamins,defaultYaxis = defaultYaxis,titleSize =titleSize,pointSize = pointSize)
}

#' @title Exact tests to detect mutually exclusive, co-occuring and altered genesets or pathways.
#' @description Performs Pair-wise Fisher's Exact test to detect mutually exclusive or co-occuring events.
#' @param module The gene module,generated by `get_final_candidate_module`.
#' @param genes The modular gene,generated by `get_final_candidate_module`.
#' @param freq_matrix The mutations matrix,generated by `get_mut_status`.
#' @param pvalue,returnAll,fontSize,showSigSymbols,showCounts,countStats,countType,countsFontSize,countsFontColor,colPal,nShiftSymbols,sigSymbolsSize,sigSymbolsFontSize,pvSymbols,limitColorBreaks see \code{\link[pathwayTMB]{plotMutInteract}}
#' @importFrom pathwayTMB plotMutInteract
#' @return No return value
#' @export
#' @examples
#' \donttest{#load the data.
#' data(plotMutInteract_moduledata,plotMutInteract_mutdata)
#' #draw an plotMutInteract of genes
#' get_plotMutInteract(genes=unique(unlist(plotMutInteract_moduledata)),
#' freq_matrix=plotMutInteract_mutdata)
#' #draw an plotMutInteract of modules
#' get_plotMutInteract(module=plotMutInteract_moduledata,
#' freq_matrix=plotMutInteract_mutdata)}



get_plotMutInteract<-function(module=NULL,genes=NULL,freq_matrix,pvalue = c(0.05, 0.01),returnAll = TRUE,fontSize = 0.8,showSigSymbols = TRUE,showCounts = FALSE,
                              countStats = "all",countType = "all",countsFontSize = 0.8,countsFontColor = "black",colPal = "BrBG",nShiftSymbols = 5,sigSymbolsSize = 2,
                              sigSymbolsFontSize = 0.9,pvSymbols = c(46, 42),limitColorBreaks = TRUE){

  if(!is.null(genes)){
    matr<-as.data.frame(freq_matrix[genes,])
    gene<-rownames(matr)

    if(!is.null(module)){
      stop("Please use genes or module")
    }

  } else if(!is.null(module)){
    matr<-c()
    for(i in 1:length(module)){
      a<-colSums(freq_matrix[module[[i]],])
      matr<-as.data.frame(rbind(matr,a))
    }
    rownames(matr)<-paste0("M",(1:length(module)))
    matr[matr>1]<-1
    gene<-paste0("M",(1:length(module)))


  }
  plotMutInteract(freq_matrix = matr,genes =gene,pvalue =pvalue,returnAll = returnAll,fontSize = fontSize,
                  showSigSymbols = showSigSymbols,showCounts = showCounts,countStats =countStats,countType = countType,countsFontSize = countsFontSize,
                  countsFontColor =countsFontColor,colPal =colPal,nShiftSymbols = nShiftSymbols,sigSymbolsSize = sigSymbolsSize,sigSymbolsFontSize = sigSymbolsFontSize,
                  pvSymbols = pvSymbols,limitColorBreaks = limitColorBreaks)
}
