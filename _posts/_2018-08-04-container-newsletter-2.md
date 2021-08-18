---
layout: post
title: Container and Cloud - Newsletter for the week Edition 2
category: newsletter_old
---

![placeholder](https://vivekjuneja.files.wordpress.com/2016/04/shipping-containers.jpg?w=660 "shipping containers")

1. [Systems@Scale at Facebook](https://code.fb.com/core-data/systems-scale-2018-recap/)

	I particularly enjoyed the talk from Liz Fong-Jones about how to debug outages. The talk went over the Debugging Feedback loop, based on the concepts from <a href="https://en.wikipedia.org/wiki/OODA_loop">OODA loop</a>. Liz introduced the steps that Google takes when diagnosing critical outages. The key ideas from that talk includes :- 
		
	a. Invest in data visualization that allows drill down and aggregated view across multiple dimensions to get good at dissecting the problem 

	b. Dynamic data joins that allows layering data sources instead of just using a precomputed dashboard to find correlations 

	c. Sample the data observed to keep atleast ONE representative example that caused the problem. This is crucial when trying to answer for eg:- "Where is this latency coming as indicated in the aggregated result?".	


2. [Knative launched during Google Cloud Next event](https://cloud.google.com/knative/)

	KNative is a simpler way for developers to deploy and run *serverless* applications on Kubernetes and Istio. There are 3 parts to KNative : Build, Serving and Eventing. The project was announced by Google during Next 2018 conference. The goal was to provide a clean way for developers to package containers into serverless workloads, meaning as a developer I could have automatic scaling up or down of my workload based on traffic, which will allow request-driven compute model. With event management system baked in, developers will be able to manage event subscription within the Knative environment. Expect a full write up on this shortly after I grease the tires. 

3. [How we scaled nginx and saved the world 54 years every day](https://blog.cloudflare.com/how-we-scaled-nginx-and-saved-the-world-54-years-every-day/)

    CloudFare shared an account on the changes they did on NGINX to improve performance and scale to extreme high I/O loads. Noticeable among them was the change to avoid blocking Event loop. The team at CloudFare also made use of the linux kernel's ability to bind multiple services on one port using the SO_REUSEPORT socket option. This allowed the kernel to distribute the incoming connections among the workers listening to socket on the same address and port. CloudFare claims that they secured  improvement in peak p99 by 33%. 
    
4. [Falco provides runtime security for systems running container workloads](https://sysdig.com/opensource/falco/)

    Falco provides runtime security for systems running container workloads. It detects abnormal behavior in the container workload and ensures a fast turnaround for teams to take control. It comes with a Rules engine that operates on the system call events obtained from the Sysdig Kernel module and metadata providers (Kubernetes, Marathon, Mesos and Docker). Falco's adoption is driven by the approach to have an open community drive the various rule sets for security exploits. Being a Sysdig user, I liked the approach that Falco is taking to make secure container workload easy to manage. The [proposal](https://docs.google.com/document/d/1uf20azEZ_CciqzdG60rtqjrqzrUVlyVOwevPrxhfpoA/edit#) from Sysdig to CNCF about Falco is a good place to obtain more information about the project.
    
    
That's it folks. See you next week for more exciting findings in the container and cloud native eco-system. 
