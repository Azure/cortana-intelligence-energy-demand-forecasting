# Energy Demand Forecasting - A Cortana Intelligence Solution

Accurately forecasting spikes in demand for products and services can give a company a competitive advantage. The better the forecasting, the more they can scale as demand increases, and the less they risk holding onto unneeded inventory. Use cases include predicting demand for a product in a retail/online store, forecasting hospital visits, and anticipating power consumption.

This solution focuses on demand forecasting within the energy sector. Storing energy is not cost-effective, so utilities and power generators need to forecast future power consumption so that they can efficiently balance the supply with the demand. During peak hours, short supply can result in power outages. Conversely, too much supply can result in waste of resources. Advanced demand forecasting techniques detail hourly demand and peak hours for a particular day, allowing an energy provider to optimize the power generation process. This solution using Cortana Intelligence enables energy companies to quickly introduce powerful forecasting technology into their business.

## Solution Architecture
![Solution Diagram](Post-Deployment Instructions/Figures/energyforecastingdiagram.png)

## What's under the hood
1.	The sample data is streamed by newly deployed **Azure Web Jobs**.

2.	This synthetic data feeds into the **Azure Event Hubs** and **Azure SQL** service as data points or events, that will be used in the rest of the solution flow.

3.	**Azure Stream Analytics** analyze the data to provide near real-time analytics on the input stream from the event hub and directly publish to PowerBI for visualization.

4.	The **Azure Machine Learning** service is used to make forecast on the energy demand of particular region given the inputs received.

5.	**Azure SQL Database** is used to store the prediction results received from the **Azure Machine Learning** service. These results are then consumed in the **Power BI** dashboard.

6. **Azure Data Factory** handles orchestration, and scheduling of the hourly model retraining.

7.	Finally, **Power BI** is used for results visualization, so that users can monitor the energy consumption from a region in real time and use the forecast demand to optimize the power generation or distribution process.

# Getting Started #
This solution package contains materials to help both technical and business audiences understand our demand forecasting solution for the energy industry built on the [Cortana Intelligence Suite](https://www.microsoft.com/en-us/server-cloud/cortana-intelligence-suite/Overview.aspx).

# Business Audiences
In this repository you will find a folder labeled **Solution Overview for Business Audiences**. This folder contains:
- Infographic: covers the benefits of using advanced analytics for demand forecasting in the energy industry
- Solution At-a-glance: an introduction to a Cortana Intelligence Suite solution for demand forecasting
- Walking Deck: a  presentation covering this solution and benefits of using the Cortana Intelligence Suite

For more information on how to tailor Cortana Intelligence to your needs [connect with one of our partners](http://aka.ms/CISFindPartner).

# Technical Audiences
See the **Technical Deployment Guide** folder for a full set of instructions on how to put together and deploy a demand forecasting solution using the Cortana Intelligence Suite. For technical problems or questions about deploying this solution, please post in the issues tab of the repository.

# Related Resources
We have put together a number of resources that cover different approaches to building energy demand forecasting solutions. These resources are listed below and may be helpful to those exploring ways to build energy demand forecasting solutions using the Cortana Intelligence Suite.

### [Demand Forecasting for Energy Solution](https://gallery.cortanaintelligence.com/SolutionTemplate/Demand-Forecasting-for-Energy-1)
This solution template in the Cortana Intelligence Gallery provides a semi-automated deployment of the same solution described by the Technical Deployment Guide here. The deployment guide in this repository is intended to provide implementers with a more in-depth understanding of how the end-to-end solution presented in the gallery is built.

### [Energy Demand Forecasting Playbook](https://azure.microsoft.com/en-us/documentation/articles/cortana-analytics-playbook-demand-forecasting-energy/)
This playbook aims at providing a reference for energy demand forecasting solutions with the emphasis on major use cases. It is prepared to give the reader an understanding of the most common business scenarios of energy demand forecasting, challenges of qualifying business problems for such solutions, data required to solve these business problems, predictive modeling techniques to build solutions using such data and best practices with sample solution architectures.

### [Energy Demand Forecast Template with SQL Server R Services](https://gallery.cortanaintelligence.com/Tutorial/Energy-Demand-Forecast-Template-with-SQL-Server-R-Services-1)
This tutorial walks users through the steps to create an on-premise energy demand forecasting solution using SQL Server R Services. Similar to the solution presented in this repository, the tutorial shows how to predict the electricity demand of multiple regions.

##### Disclaimer
©2016 Microsoft Corporation. All rights reserved.  This information is provided "as-is" and may change without notice. Microsoft makes no warranties, express or implied, with respect to the information provided here.  Third party data was used to generate the solution.  You are responsible for respecting the rights of others, including procuring and complying with relevant licenses in order to create similar datasets.
