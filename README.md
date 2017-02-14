# Energy Demand Forecasting - A Cortana Intelligence Solution

Accurately forecasting spikes in demand for products and services can give a company a competitive advantage. The better the forecasting, the more they can scale as demand increases, and the less they risk holding onto unneeded inventory. Use cases include predicting demand for a product in a retail/online store, forecasting hospital visits, and anticipating power consumption.

This solution focuses on demand forecasting within the energy sector. Storing energy is not cost-effective, so utilities and power generators need to forecast future power consumption so that they can efficiently balance the supply with the demand. During peak hours, short supply can result in power outages. Conversely, too much supply can result in waste of resources. Advanced demand forecasting techniques detail hourly demand and peak hours for a particular day, allowing an energy provider to optimize the power generation process. This solution using Cortana Intelligence enables energy companies to quickly introduce powerful forecasting technology into their business.

This solution package contains materials to help both technical and business audiences understand our demand forecasting solution for the energy industry built on the [Cortana Intelligence Suite](https://www.microsoft.com/en-us/server-cloud/cortana-intelligence-suite/Overview.aspx).

## Solution Dashboard
The snapshot below shows the PowerBI dashboard that visualizes the results of the energy demand forecast. You can view the dashboard live [here](https://pcsadwebapp-staging-1.azurewebsites.net/EnergyDemandForecasting/BYOD).
![DashboardExample](Automated Deployment Guide/Figures/PowerBI-11.png)

## Solution Architecture
![Solution Diagram](Automated Deployment Guide/Figures/energyforecastingdiagram.png)

## Business Audiences
In this repository you will find a folder labeled [*Solution Overview for Business Audiences*](https://github.com/Azure/cortana-intelligence-energy-forecasting-solution/tree/master/Solution%20Overview%20for%20Business%20Audiences). This folder contains:
- Infographic: covers the benefits of using advanced analytics for demand forecasting in the energy industry
- Solution At-a-glance: an introduction to a Cortana Intelligence Suite solution for demand forecasting
- Walking Deck: a  presentation covering this solution and benefits of using the Cortana Intelligence Suite

For more information on how to tailor Cortana Intelligence to your needs [connect with one of our partners](http://aka.ms/CISFindPartner).

## Automated Deployment
The solution described here can be automatically deployed through the [*Cortana Intelligence Gallery*](https://gallery.cortanaintelligence.com/Solution/Energy-Demand-Forecasting-4). For instructions to complete the solution after running the automated deployment, see the [*Automated Deployment Guide*](https://github.com/Azure/cortana-intelligence-energy-demand-forecasting/tree/master/Automated%20Deployment%20Guide) folder. See the [*Manual Deployment Guide*](https://github.com/Azure/cortana-intelligence-energy-demand-forecasting/tree/master/Manual%20Deployment%20Guide) in this repository for full details on how this solution is built piece by piece.

## Manual Deployment
See the  [*Manual Deployment Guide*](https://github.com/Azure/cortana-intelligence-energy-demand-forecasting/tree/master/Manual%20Deployment%20Guide) folder for a full set of instructions on how to put together and deploy a demand forecasting solution using the Cortana Intelligence Suite. For technical problems or questions about deploying this solution, please post in the issues tab of the repository.

## Related Resources
We have put together a number of resources that cover different approaches to building energy demand forecasting solutions. These resources are listed below and may be helpful to those exploring ways to build energy demand forecasting solutions using the Cortana Intelligence Suite.

#### [Energy Demand Forecasting Playbook](https://azure.microsoft.com/en-us/documentation/articles/cortana-analytics-playbook-demand-forecasting-energy/)
This playbook aims at providing a reference for energy demand forecasting solutions with the emphasis on major use cases. It is prepared to give the reader an understanding of the most common business scenarios of energy demand forecasting, challenges of qualifying business problems for such solutions, data required to solve these business problems, predictive modeling techniques to build solutions using such data and best practices with sample solution architectures.

#### [Energy Demand Forecast Template with SQL Server R Services](https://gallery.cortanaintelligence.com/Tutorial/Energy-Demand-Forecast-Template-with-SQL-Server-R-Services-1)
This tutorial walks users through the steps to create an on-premise energy demand forecasting solution using SQL Server R Services. Similar to the solution presented in this repository, the tutorial shows how to predict the electricity demand of multiple regions.

##### Disclaimer
©2016 Microsoft Corporation. All rights reserved.  This information is provided "as-is" and may change without notice. Microsoft makes no warranties, express or implied, with respect to the information provided here.  Third party data was used to generate the solution.  You are responsible for respecting the rights of others, including procuring and complying with relevant licenses in order to create similar datasets.
