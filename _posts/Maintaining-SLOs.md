---
layout: post
title: My upcoming posts
category: learning
---

![placeholder](https://raw.githubusercontent.com/vivekjuneja/vivekjuneja.github.io/master/images/writing.jpg
 "A Log Dashboard")

My learning from the Site Reliability Workbook :-

#### Without SLOs, there is no need for SRE

#### How to setup Error budget approach for SRE 
* All stakeholders have approved the SLOs
* Service owners have agreed and have all the means neccessary to maintain the SLOs
* There is a Error budget policy that the org has committed for prioritization
* There are measures to refine SLOs on an ongoing basis

#### Below the SLO threshold, customers would likely complain or stop using the service

#### Setting up SLIs
* Treat SLI as the ratio between good events and total events
* In a request driven application (Web app), Quality could also be a credible SLI apart from latency and availability. Quality refers to proportion of responses which were served in an undegraded state even when the service degraded. This indicates that the service can degrade gracefully when overloaded or when a backend system is unavailable.  

#### Calculating Error Budget
Error 
Let us say that a given SLO for a Web App is latency < 500ms for 90th percentile. This means, that upto 90% of requests to this Web App is lower than 500 ms (Lower the latency, faster is the response). Lets say in a week there are 100,000 requests to this Web App. This means for upto 10,000 requests the latency can go above 500ms. and for the rest it is guaranteed to be less than 500ms. So the allowed failures is 10,000 requests in a week that can have latency more than 500ms. We could consider this as a budget. So, a service can change with new features or bug fixes and even scale to meet the demands of customers, all while affecting the latency of no more than 10,000 requests. 
To make this number translate to actual cost in Dollars :-
Let us calculate how much money we spend as an organization to maintain this Web app :-
We hire 3 FTE (full time employees) to build and maintain the service. We pay them 50,000 USD per year. Total expenditure in one month : (50,000\*3)/12 => 12,500 USD. We operate this Web App on an infrastructure that costs 3000 USD per month. The cost to rent the office and utility is 1000 USD per month. So the total cost of operating this team is : 16,500 USD per month. For a week, this comes to 4,125 USD. 
Next, we can identify how many successful requests we can service given the current infrastructure. This should be possible through a capacity plan either by doing a load test to identify the thresholds. Lets say we can service upto 100,000 requests in a week. 
So, to provide 100,000 requests in a week, we spend 4,125 USD. We have already defined our SLO to have 10,000 requests that can go above 500 ms, which is our Error budget. This is 10% of 4,125 USD, which 412.5 USD in a week. Translating this in terms of time, this comes to : 9 hours of time every week. This means, as a team we have a room to spend upto 9 hours of time as part of our Error budget to ensure the SLOs are maintained at all times. (assuming 6 hours of productive time per FTE, and for 5 full working days, this comes to 90 hours every week in total spent to provide 100,000 requests. Error budget is then 10% of 90 hours). 
This is however, a gross simplification of the process of arriving at Error budgets. The appropriate time window also influences this number. Weekend traffic may differ from the weekday traffic, which has to then be included. 
* Shorter time windows allows to make decisions to correct missed SLOs quickly. Longer time windows help with strategic decisions. 



