## Big data advance analytics
Combine any data at any scale, and build and deploy advance analytics application and machine learning models at scale.

### Scenario:
* Bring together all your structured, unstructured and semi-structured data (logs, files, and media) using Azure Data Factory to Azure Data Lake Storage
* Use Azure Databricks to clean and transform the structureless datasets and combine them with structured data from operational databases or data warehouses
* Use scalable machine learning/deep learning techniques, to derive deeper insights from this data using Python, R or Scala, with inbuilt notebook experiences in Azure Databricks
* Leverage native connectors between Azure Databricks and Azure Synapse Analytics to access and move data at scale.
* Query and report on data in Power BI.
* Take the insights from Azure Databricks to Cosmos DB to make them accessible through web and mobile apps.

![Example Architecture](../../_images/advance-analytics.PNG)


### Apply the landingzone template
```bash
# Set the folder name of this example
example=bigdata-advance-analytics

# Deploy networking
rover -lz /tf/caf/landingzones/landingzone_networking/ \
      -tfstate landingzone_networking.tfstate \
      -var-file /tf/caf/examples/${example}/landingzone_networking.tfvars \
      -a apply
	  
# Run data landing zone deployment
rover -lz /tf/caf/ \
      -tfstate ${example}_landingzone_data.tfstate \
      -var-file /tf/caf/examples/${example}/configuration.tfvars \
      -var tfstate_landingzone_networking=${example}_landingzone_networking.tfstate \
      -var landingzone_tag=${example}_landingzone_dap \
      -a apply
	  
```