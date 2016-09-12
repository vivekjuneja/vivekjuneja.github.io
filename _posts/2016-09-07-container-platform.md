---
layout: post
title: The building blocks for mass innovation
category: devops
---

Organizations starting to adopt Service Oriented or Microservices based architectures struggle to manage the complexity of building and releasing new services. Also, with the organization structure needed to support this new paradigm, it becomes increasingly challenging to support independent teams building new functionalities at a rapid scale, without coming in way of each other. 

One of the common ingredient to Microservices based development is the need for ownership of the services by teams. This means, the teams are not just responsible for development of the service, instead they also needed to own the testing and operations of the service. This is possible only if there is enough automation built around the system to support the entire lifecycle management of services. 

As new services get built and released, it increasingly becomes difficult to understand and visualize the various services and their dependencies. Each service also has its own timeline and roadmap, and this ideally should not become a bottleneck for the system to operate. The need of the hour is to provide consistent building blocks to the service development teams in order to manage the chaos and rapidly build or change services with minimum or no interruptions. 

This Solution stack is a congregation of key ideas needed to support the continuous development of services by independent teams. It brings together key tools, technologies and practices that make service oriented teams empowered. It aims to increase ownership in teams by reducing the cost of taking risks and infusing innovation.

Let us look at key concerns that the Solution stack will intend to resolve :-

1. Allow Developers to quickly get started with a service development project without wasting time on setting development environment, test harness, test environments and build-release practice. Much of this includes scaffolding and boilerplate projects that are used to avoid re-inventing the wheel. 

2. Each Service Development project needs to be configured with the development toolchain including Versioning, Build tools, Deployment tools, Testing and Monitoring tools among others.

3. The architecture and design governance rules including use of standard patterns like Timeouts, API response types, Circuit Breaker, Security Policies etc. need to be applied to the relevant service development

4. Allow Service Development team to build changes into their service reliably without worrying about breaking other dependent services

5. Service Development team to operate and maintain their services in Production and can quickly react to events of failure or degraded performance

6. Team can deploy their service independent of the infrastructure, be it Public cloud or Physical data center or Developer Laptop

7. Developers can perform Integration testing locally by having a snapshot of the entire application on their local development environment

8. Freedom to choose new languages and frameworks for the choice of development / replacement of a service without impacting the expectations of the application and other participating services

9. Release new experimental features in Production along side existing functionalities without breaking the release or impacting user experience

10. Ability to perform A/B Testing for new functionalities or changes to a service by progressively adding load to the service

11. Teams can maintain service level agreements (SLA) and assign threshold to their service to maintain operational behavior of the service they own
Service Development teams have access to unified monitoring, logging and analytics for their service

The overarching goal is to turn the development process into a commodity through standardization and automation. This will lead to quick adoption of new practices, innovative solutions and architecture governance without reducing the speed of development.

One thumb rule to measure the success of this stack is how quickly can a new team or engineer could start developing new services and publish them in production. This measure is a key driving goal for the success of this Solution stack.


# Solution Stack Ingredients

The Solution stack also called a Service Delivery Platform, is a congregation of modern software development techniques, especially when developing a large service oriented project in an organization.

It brings together key battle-proven ideas into practice and help developers to breeze through changes, and provides a safety net for them to innovate.

The following are the key ingredients to the Solution stack :-

## 1. Service Unit

A Service Unit refers to an independent cross-disciplinary service development team. The team is composed of Software Developers, Test Engineers and DevOps role amongst others. The goal is to have this team capable to develop, maintain and operate their service across all environments - Dev, Integration, Test and Production. The team owns most of the aspects of the development of a Service, even including Service feature roadmap, Operational guidelines, Monitoring the Service in Production etc. The Service Unit maps to a Service Development Team. These terms are used interchangeably across this text.

## 2. Service Starter Project

A Service Starter project is a standard boilerplate project template that encapsulates the design of the service. The project has a sample implementation and packaging structure for a simple domain, and helps the development team understand where to put the respective logic in the project. This includes the Domain logic, Service Interface, Persistence logic, and API implementation. The starter project is itself a ready to deploy and test artifact which the development team can quickly use to start their work. Examples of a Starter project includes :- DropWizard, Appfuse, Twitter Bootstrap amongst others. The Service Starter project is packaged with all the relevant dependencies that a Service needs to run, including the relevant API Facades / Service Mocks for other dependent services. It may also include Test assertions that the Service can use to test their services against the expectations of other dependent service teams. This template also has access to reusable libraries that can connect to Databases, Queue, Scheduler services to help quick development. Common patterns like Timeouts, Circuit Breaker etc. are available as libraries as well which the team can quickly use in their implementation. A common example of such a Microservices starter project is the Netflix Karyon project hosted on Github. This project is used by all Service teams inside Netflix to accelerate their development process. 

## 3. Service Builder

A Service Builder is an automation tool that quickly builds the Service project and prepares a deployable ready for deployment onto any infrastructure. This process 
includes running the build task of a project, like in a Maven or Ant based projects. During the Build process, it could also run validation checks to ensure valid Test cases and required governance rules are followed during the development of the service. Post the build, it bundles the service into an independent deployable, like a Container Image or an Amazon Web Services Machine Image for example. This deployable is then registered and uploaded to a Registry that maintains the image and makes it easy for discovery and deployment process. A Service Builder also maintains and updates the versioning of the service when packaging it. At any point of time, there could be multiple versions of the same service in the form of versioned deployables in the registry. The Service Builder instance is independent of the Deployment strategy and infrastructure where the Service would eventually run. It ensures that the Service is rightly packaged and is available for deployment. The Service Builder will generate the deployable in the form that nothing else is needed to be installed or performed apart from dropping the same onto a particular infrastructure. The builder uses a standard package format like a Container image that is already pre-configured with Service Discovery, Package deployment and other necessary toolsets. The Container image is also “bastiled”, which means, it follows the standard governance and security policies, especially Public-Private keys and network ports. This ensures that all the Deployment packages / Deployables that are generated by the Service Builder from the Container Image are same. The Service Builder has two parts :- Service Builder CLI and Service Builder Task Instance. The CLI accepts the build request from the developer and puts it in a Build Request Queue. The Service Builder Task Instances are managed as a Task Pool or Worker Pool. If the Task Pool has some free Task instances, then one of them is allocated to work on the Build request from the Queue. This separation of Task Instance and CLI is important to allow for concurrent development build requests from the Service Development team. The Service Builder also exposes RESTful API to help integration and automation. The Service Builder can run on a Developer machine or on a cluster based on where the Build is needed.

## 4. Service Deployer

A Service Deployer is an automation tool that is responsible to deploy the Deployment package obtained from the Service Builder. The Service Deployer is configured to the respective endpoint of the infrastructure that will run the deployable. This configuration could point to a local developer laptop, a data center or a public IaaS (Infrastructure cloud) service. The Service Deployer encapsulates the complexity of launching environment (server, storage and network) resources on the supported platforms including OpenStack, AWS, Google Compute Engine, Virtual Box, Non-virtualized Hardware amongst others. The Service Deployer picks up the relevant version of the Service Deployable from the Registry and performs the deployment operations. The Service Deployer also has similar parts like Service Builder :- Service Deployer CLI and Service Deployer Tasks. The Service Deployer CLI accepts the deployment requests and puts them in a Deploy Queue. The Service Deployer Tasks are managed as a Pool. When a Deploy request is added to the Queue, a free Deployer Task is then provisioned to accept the request and process it. Similar to its counterpart, a Service Deployer also exposes RESTful API. A Service Deployer can be run on the developer machine or on a cluster,  based on the environment for which the Deployment is needed. 

## 5. Application, Environment and Machine manifests

The manifest holds the declaration of the Application, Environment and Machine specific configuration. Each such manifest defines the exact state that is needed for the running of the service and the application. The Application manifest holds the configuration of all the Services that constitute the service oriented application. Application manifest describes each Service and the configuration relating to it. This includes the Port where it could be running, the APIs it exposes, the URL to the service documentation and mocks etc. This manifest is could be used as a service discovery instrument for a local development environment instead of using a third party external system for it. A Service Development team has access to the entire Application manifest and can use it to perform local deployment of the Application for integration tests. 

The Environment manifest describes for each service, the details of the runtime infrastructure including Web Application server, Database, Queueing systems and other related information it needs. The relevant versions of each such dependencies of a Service is defined in this manifest. Each Development team can have access to the Environment manifest of the Service that it owns. This access includes both read and write. One development team usually does not have access to the Environment manifest of the other teams. However, privileges could be provided for a team to have access to multiple Environment manifests. The Environment manifest is enough to provision the test environment for a service. This is usually used by Service Deployer during the local development process and continuous deployment. 
Common examples of such Manifests are: CloudFormation template, Puppet / Chef DSL. VagrantFiles etc. 

## 6. Service Image Bakery

A Service Image Bakery is a tool that encapsulates the process of creating standard baseline images for various technology stacks and service environment. This helps the teams to consistently use a deployment package that is consistent for all teams, and is hotwired with all the relevant configurations needed to support the service. For example:- A Java-Spring Boot based Microservice will have its own Image that is ready to be deployed on an infrastructure of choice. The image is preconfigured the Database option, Queue and all required configuration needed to run the Microservice. The Image Bakery provides tools to create this reusable Image that can then be checked into a Registry that versions and hold the image. A Starter project uses a particular baked image obtained through this process. The images can also rebaked using the tool. This allows for constant changes and updation to reflect the images. The new modified images obtained can automatically be used by the Developers when Service Builder is used for local development and during the continuous integration process. A Common example is AMInator from Netflix which provides the similar capability. 

## 7. Service Registry

The Service Registry is an entity in a Service oriented system that hosts the information of each Service that is part of an Application. It can be used for Service Discovery and Service Visualization. It provides ability to view the Service dependencies and the active-inactive services in an application at any point of time. This information is helpful for overall governance of the Services and provides a 
consistent view to all stakeholders. A Service Registry can also have a RESTful API endpoint that can then be used to get access to an existing Service in the respective Environment (Test, Dev, Prod). The Service Registry also allows for Service playground for development teams who are interested to quickly check and trial services. This registry also has capability to provide a shared understanding of the Release milestones of each Service, and which service versions are being used in which environment. A Service Registry is synonymous to API Registry. Common examples of Service Registry include Zookeeper, Netflix Eureka, Consul, etcd among others. 

## 8. Versioning System
	
A Distributed Versioning system provides capability to hold versionable assets including Service Code, Starter Projects, Application, Environment, Machine Manifests. The required versioning system must allow for common versioning capabilities including branching, tagging, multi-repositories, hooks, authentication and authorization. The system should be highly reliable and available. Common examples:- Mercurial, Git, SVN etc. 
	
## 9. Continuous Integration and Deployment System

A Continuous Integration and Deployment system is a tool that provides capability of creating build and deploy pipelines for rapidly putting code in production. It integrates with other solution stack components like Service Builder and Service Deployer. For each service built and released, the tool can provision a pipeline specific to that service. The tool also provides capability to work in a distributed manner, allowing multiple slaves to work on the build and deploy pipelines at the same time. This distribution is essential to make this system multi-tenant and perform in a rapid build-release cycle for a service oriented project. The System is integrated to watch the versioning system for changes that occur in the source code, manifests and any other versioned artifacts. These changes are then used as events to trigger build and release process. This provides a consistent feedback for all Service Development teams participating to build the project. 

## 10. Environment Provisioning System

This system is used to provision a set of infrastructure that is configured to host a single service or bunch of services. This system reads a Environment manifest through the Service deployer and in return provisions the infrastructure needed to reflect the environment. This includes the change in File system, NFS shared, IPtable configuration, OS Permissions and other required aspects of setting up an Environment. The Environment here maps to a single Service, and is used / operated by a single Service Development team. 

## 11. Package and Configuration Management

A Package and Configuration Management is a system that allows for installing the relevant packages needed to setup a usable Service Image. This is extensively used by the Service Image Bakery when building images to support the Service deployment. This tool automates the packaging and installation of software dependencies to form a reusable image. Different type of packages could be installed on a Service image including a third party dependency, service implementation and policy enforcement. This tool is a meta-tool and is used to set up the Microservices Solution stack as well. Examples of such tools include Zinst, Puppet, Chef, CFEngine etc. 

## 12. Infrastructure resource management and cluster scheduler
	
## 13. Infrastructure Provisioning system

## 14. End to End Service Monitoring

## 15. Log aggregation and Log visualizer

## 16. Service Dependency Management

## 17. Service SLA management

## 18. Service Notification system

## 19. End to End Service Analytics

## 20. Service Validator and Governance Engine

Service Validator and Governance Engine is a tool that allows for enforcing standard guidelines to all services built and published. This allows for a consistency to be maintained in a distributed service oriented environment. New rules could be added or old rules could be removed at any point of time. This Engine is used while build and release cycle for all Service development teams. A Team could also use this tool for local development to check if any service built by the team is non-compliant to the said governance rules. The enforcement happens through a process of monitoring and code inspection, along with metadata that is collected from a published service. For example: A service image used by a team can have a open SSH port to all, which could be a potential security breach. Similarly, a Service could be using an old Service Mock that is currently or deprecated. The Service Validator and Governance Engine can work with the Service Notification engine notifying the Service Development team on any non-compliance or slippage, and issue warnings. At some stage, the Validator and Governance can auto correct the configuration itself provide some set of self-healing capability to an application runtime. This allows it to take proactive steps to prevent future failure. 





