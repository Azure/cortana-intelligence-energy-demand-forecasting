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
The essential goal of this part is to get the demand forecast of each region and visualize it. Power BI can directly connect to an Azure SQL database as its data source, where the prediction results are stored.

> Note:  1) In this step, the prerequisite is to download and install the free software [Power BI desktop](https://powerbi.microsoft.com/desktop). 2) We recommend you start this process 2-3 hours after you deploy the solution so that you have more data points to visualize.

1.  Get the database credentials.

    You can get your database credentials from the previous steps when you setting up the SQL database.

2.	Update the data source of the Power BI file
	-  Make sure you have installed the latest version of [Power BI desktop](https://powerbi.microsoft.com/desktop).

	-	In this Git repository, you can download the **'EnergyDemandForecastSolution.pbix'** file under the folder **'Power BI Template'** and then open it. **Note:** If you see an error massage, please make sure you have installed the latest version of Power BI Desktop.

  - On the top of the file, click **‘Edit Queries’** drop down menu. Then choose **'Data Source Settings'**.
  ![](Figures/PowerBI-7.png)

	- In the pop out window, click **'Change Source'**, then replace the **"Server"** and **"Database"** with	your own server and database names and click **"OK"**. For server
	name, make sure you specify the port 1433 in the end of your server string
	(**YourSolutionName.database.windows.net, 1433**). After you finish editing, close the 'Data Source Settings' window.

  - When you are asked to enter the user name and password, make sure you choose **'Database'** option, then enter the username and password that you choose when you setting up the SQL database.

	- On the top of the screen, you will see a message. Click **'Apply Changes'** and now the dashboard is updated to connect to your database. In the backend, model is scheduled to be refreshed every 1 hour. You can click **'Refresh'** button on the top to get the latest visualization as time moving forward.

3. (Optional) Publish the dashboard to [Power BI
    online](http://www.powerbi.com/). Note that this step needs a Power BI account (or Office 365 account).

	-   Click **"Publish"** on the top pannel. Choose **'My Workspace'** and few seconds later a window appears displaying "Publishing successed". Click the link on the screen to open it in a browser and enter your database credentials by following the instructions. To find detailed instructions, see [Publish from Power BI Desktop](https://support.powerbi.com/knowledgebase/articles/461278-publish-from-power-bi-desktop).

	-   Now you can see new items showing under 'Reports' and 'Datasets'. To create a new dashboard: click the **'+'** sign next to the
    **Dashboards** section on the left pane. Enter the name "Energy Demand Forecasting Demo" for this new dashboard.

	-   Once you open the report, click   ![Pin](Figures/PowerBI-4.png) to pin all the
		visualizations to your dashboard. To find detailed instructions, see [Pin a tile to a Power BI dashboard from a report](https://support.powerbi.com/knowledgebase/articles/430323-pin-a-tile-to-a-power-bi-dashboard-from-a-report). Here is an example of the dashboard.

      ![DashboardExample](Figures/PowerBI-11.png)


## Real-time Path Setup Steps

### 1. Setup Azure Blob Storage[PS]

### 2. Setup Azure Event Hub[PS]

### 3. Setup Azure Web Jobs[PS]

### 4. Azure Stream Analytics Jobs [YC]
#### 1) Provision a Stream Analytics job
#### 2) Specify job input
#### 3) Specify job query
#### 4) Specify job output

  - You can use the instructions in
[Azure Stream Analytics & Power BI: A real-time analytics dashboard for real-time visibility of streaming data](stream-analytics-power-bi-dashboard.md)
to set up the output of your Azure Stream Analytics job as your Power BI dashboard.

  - Locate the stream analytics job in your [Azure management portal](https://portal.azure.com). The name of the job should be: YourSolutionName+"saJob" (i.e. energydemosaJob). Click **'Outputs'** from the panel on the right.

  ![Add PowerBI output on ASA 1](Figures/PowerBI-1.png)

  - On the new window, click **'+Add'** on the top, and then it will show a window asking for information of the output. Under **'Sink'**, choose **'Power BI'**, then click **'Authorize'**. In the pop out window, log in with your Power BI account.

  - Once you successfully authorize your Power BI account, fill in other informtion as follows. Set the **Output Alias** as **'outputPBI'**. Set your **'Dataset Name'** and **'Table Name'** as **'EnergyForecastStreamData'**. Click **'Create'** once you finish.

  - Now you have added the Power BI output, you can click ![Start](Figures/PowerBI-2.png) at the top of the page to start the Stream Analytics job. You will get a confirmation message (e.g. 'Streaming Job started successfully').

#### 5) Start job for real-time processing

### 5. Setup Real-time Power BI [YC]
#### 1) Login on [Power BI online](http://www.powerbi.com)

-   On the left panel Datasets section in My Workspace, you should be able to see a new dataset showing on the left panel of Power BI. This is the streaming data you pushed from Azure Stream Analytics in the previous step.

-   Make sure the ***Visualizations*** pane is open and is shown on the
    right side of the screen.

#### 2) Create a visulization on PowerBI online
We will use this example to show you how to create the "Demand by Timestamp" tile:

-	Click dataset **EnergyForecastStreamData** on the left panel Datasets section.

-	Click **"Line Chart"** icon.![LineChart](Figures/PowerBI-3.png)

-	Click EnergyForecastStreamData in **Fields** panel.

-	Click **“time”** and make sure it shows under "Axis". Click **“demand”** and make sure it shows under "Values".

-	Click **'Save'** on the top and name the report as “EnergyStreamDataReport”. The report named “EnergyStreamDataReport” will be shown in Reports section in the Navigator pane on left.

-	Click **“Pin Visual”**![](Figures/PowerBI-4.png) icon on top right corner of this line chart, a "Pin to Dashboard" window may show up for you to choose a dashboard. Please select "EnergyStreamDataReport", then click "Pin".

## Validation and Results
need to discuss if we want to keep this
