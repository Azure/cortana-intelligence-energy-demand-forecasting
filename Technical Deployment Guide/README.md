# Energy Demand Forecasting in Cortana Intelligence Suite


## Abstract [YC]


The recently published [Energy Demand Forecasting Solution Template](https://gallery.cortanaintelligence.com/SolutionTemplate/Demand-Forecasting-for-Energy-1) provides one-click deployment of an energy demand forecasting solution in Cortana Intelligence Suite. This [blog](https://blogs.technet.microsoft.com/machinelearning/2016/03/22/solution-template-for-energy-demand-forecasting/) gives a high level overview of the solution template. Advanced analytics solution implementers, i.e. Data Scientists and Data Engineers, usually need deeper understanding of the template components and architecture in order to use, maintain, and improve the solution.

This documentation provides more details of the solution template and step-by-step deployment instructions. Going through this manual deployment process will help implementers gain an inside view on how the solution is built and the function of each component.

## Requirements [PS]

You will need the following accounts and software to create this solution:

1.  Source code and instructions from this GitHub repo

2.  A Microsoft Azure subscription. (<https://azure.microsoft.com/>) **NOTE:** You need to have at least 20 cores quota under your Azure subscription for the on-demand HDInsight cluster. To see your quota, go to *portal.azure.com -> log in -> Subscriptions -> select your subscription -> All settings -> Usage + quotas*.

3.  An Azure Machine Learning Studio account (<http://studio.azureml.net>)

4.  A Microsoft Office 365 subscription for Power BI access.

5.  A network connection

6.  SQL Server Management Studio (<https://msdn.microsoft.com/en-us/library/mt238290.aspx>), Visual Studio (<https://www.visualstudio.com/en-us/visual-studio-homepage-vs.aspx>), or another similar tool to access a SQL server database.

7.  Microsoft Azure Storage Explorer (<http://storageexplorer.com/>)

8.  Power BI Desktop (<https://powerbi.microsoft.com/en-us/desktop>)

It will take about one day to implement this solution if you have all the required software/resources ready to use. The content of the document **Energy Demand Forecasting in Cortana Intelligence Suite_Deployment Guide.docx** is the same as this readme file. Use that documentation if you prefer reading a word document.

## Architecture[YC]
<img src="Figures/energyforecastingdiagram.png"/>

1.	The sample data is streamed by newly deployed **Azure Web Jobs**.

2.	This synthetic data feeds into the **Azure Event Hubs** and **Azure SQL** service as data points or events, that will be used in the rest of the solution flow.

3.	**Azure Stream Analytics** analyze the data to provide near real-time analytics on the input stream from the event hub and directly publish to PowerBI for visualization.

4.	The **Azure Machine Learning** service is used to make forecast on the energy demand of particular region given the inputs received.

5.	**Azure SQL Database** is used to store the prediction results received from the **Azure Machine Learning** service. These results are then consumed in the **Power BI** dashboard.

6. **Azure Data Factory** handles orchestration, and scheduling of the hourly model retraining.

7.	Finally, **Power BI** is used for results visualization, so that users can monitor the energy consumption from a region in real time and use the forecast demand to optimize the power generation or distribution process.

## Setup Steps

There are two paths: Batch path and real-time path.
Explain each path here.

## Batch Path Setup Steps

### 1. Create a new Azure Resource Group [PS]

### 2. Setup Azure SQL Database[PS]

### 3. Setup Azure Web Job/Data Simulator[PS]

### 4. Setup Azure Machine Learning [YC]

### 5. Setup Azure Data Factory [YC]

### 6. Setup Power BI [YC]


## Real-time Path Setup Steps

### 1. Setup Azure Blob Storage[PS]

### 2. Setup Azure Event Hub[PS]

### 3. Setup Azure Web Jobs[PS]

### 4. Azure Stream Analytics Jobs [YC]

### 5. Setup Real-time Power BI [YC]

## Validation and Results
need to discuss if we want to keep this
