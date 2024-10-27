library(readr)
library(SummarizedExperiment)

# Especificamos la ruta a los archivos y los cargamos
data_path <- "C:/Users/Edurne/OneDrive - Sanquin/Edurne/UOC/5 Análisis de datos ómicos/PEC1/ST000002_AN000002_clean.csv"
data <- read.csv(data_path,sep = "\t", header = TRUE) #Usamos sep = "\t" porque los datos estaban separados por tabulaciones en lugar de comas. 
                                                      #La opción header = TRUE indica que la primera fila del archivo contiene los nombres de las columnas.
# Inspeccionamos el dataset
head(data) # muestra las primeras filas del dataset
           # La primera fila presenta los grupos
str(data) # Vemos que los datos estan en formato character, por lo que deberíamos cambiarlos a numeric
summary(data) 

# Omitimos la fila de grupos
data <- data[-1, ]

# Extraemos los nombres de los metabolitos (primera columna)
metabolites <- data[, 1]  

# Extraemos los datos de metabolitos (el resto de las columnas)
samples <- as.matrix(data[, -c(1)])  
samples <- apply(samples, 2, as.numeric) #Convertimos los datos a numérico

# Creamos los metadatos 
## Las filas serán los metabolitos y las columnas las muestras
row_data <- DataFrame(metabolite_id = metabolites)
col_data <- DataFrame(sample_id = colnames(samples))

# Creamos el objeto SummarizedExperiment
se <- SummarizedExperiment(assays = SimpleList(counts = samples), 
                           rowData = row_data, 
                           colData = col_data)

# Guardamos el objeto 'se' en un archivo .Rda
save(se, file = "data_metabolomics.Rda")

# Vemos la estructura del objeto
se

# Vemos las dimensiones del objeto SummarizedExperiment
dim(se)
# Nombres de las muestras
colnames(se)
# Nombres de los metabolitos
rownames(se)  
# Resumen estadístico general
summary(assay(se))
# Vemos la estructura del objeto
str(se)               


