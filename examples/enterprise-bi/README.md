## Enterprise BI example
Reference architecture shows how to perform incremental loading and extract, load, and transform (ELT) pipeline. 
Azure Data Factory automate the ELT pipeline which incrementally moves the latest OLTP data from SQL Server database into Azure Synapse. Transactional data is transformed into a tabular model for analysis.

### Scenario:
In typical enterprise data warehousing usecase some features are important- 
* Automation of the pipeline using Data Factory
* Incremental loading.
* Integrating multiple data sources.
* Loading binary data such as geospatial data and images.

![Example Architecture](../../_images/automated-enterprise-bi.PNG)
