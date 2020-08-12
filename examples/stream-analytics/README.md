## Stream Analytics example

This reference architecture shows an end-to-end stream processing pipeline. The pipeline ingests data from two sources, correlates records in the two streams, and calculates a rolling average across a time window. The results are stored for further analysis.

### Scenario:
The data sources that generate data streams in real time. Each data source sends a stream of data to the associated event hub.
A Stream Analytics job reads the data streams from the event hubs and performs stream processing.
The output from the Stream Analytics job is a series of records, which are written as JSON documents to a Cosmos DB document database.
Further this can be used for visualization and for ML usec case or other downstream systems. 

![Example Architecture](../../_images/stream-analytics.PNG)

### Apply the landingzone template
```bash
# Set the folder name of this example
example=stream-analytics

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
