---
layout: post
title: Container and Cloud - Newsletter for the week Edition 1
category: newsletter
---

![placeholder](https://vivekjuneja.files.wordpress.com/2016/04/shipping-containers.jpg?w=660 "shipping containers")

1.  <a target="_blank" href="https://www.infoq.com/articles/Graal-Java-JIT-Compiler?utm_medium=email&utm_source=topic+optin&utm_campaign=awareness&utm_content=20180721+prog+nl&mkt_tok=eyJpIjoiT0RrMU5URmxPVEF6TWpreCIsInQiOiIrOGtTUDRGdkRPb0gwZ2ZsTGIxUm4wdlwvXC9oREJmbmhHVXAySEdYRkF6Tmk0Q2NEcnBoVXl1clpZZnNVUXhoeXA2U1wvTnk5cGVjQjR3YUFMaStOSG5DWkZIRGo4MXZVMGxUcGQzMGx2Rjl2dG9uamk2eDlCaDFxcTk4NGtkT2xpcyJ9">Getting to Know Graal, the New Java JIT Compiler</a>

	GraalVM was announced by Oracle as a replacement for HotSpot VM for Java. A part of this is the Graal JIT compiler for Hotspot, and a new Polyglot VM (GraalVM). Graal JIT Compiler is written in Java and uses new JVM compiler interface (JVMCI). This compiler is expected to outperform AOT (Ahead of Time) compilers like GCC or Go compiler. The GraalVM offers the ability to fully embed polyglot languages in apps build with Java, which is an alternative to JSR 223. I really enjoyed this article that goes deep into the workings of this new JIT compiler and VM, proving that innovation is still happening in Java world. 

2. <a target="_blank"  href="https://status.cloud.google.com/incident/cloud-networking/18012">Postmortem for last GCP outage</a>

	This is an interesting post mortem that is connected to how engineers release new features in production. New features are released in production, but are often behind feature flags that are turned off to prevent the feature being used. This is ideally performed as there could be dependency for this new feature (like a backend service) that may not ready in time. This allows engineers to move fast without waiting for features to remain in branch (unmerged) when an implementation is ready and tested. Google would fix this in long term as identified in the article by creating a consolidated dashboard for all config changes for the service in question. 

3. <a target="_blank"  href="https://github.com/GoogleContainerTools/kaniko">Kaniko is a tool to build container images from a Dockerfile, inside a container or Kubernetes cluster</a> :

	If you have a CI and CD Pipeline that builds container images to deploy on the various environments, we need to have access to Docker daemon with root privileges. On Kubernetes, this could be a problem, as we need to either mount Docker socket in the "Container image creation" container, or use the DinD (docker in docker) approach. Providing root privilege just to build a container image could lead to security hole, and breaks the least privilege principle. Kaniko is an alternative to Docker build process that does not need Docker daemon, and can run in user space which means no more root access. This allows secure container build processes, and is Kubernetes friendly. Do try it out. 


4. <a target="_blank"  href="https://github.com/prometheus/prometheus/blob/master/documentation/internal_architecture.md">Internal architecture of Prometheus</a>

	A beautiful example of documentation for newbies to an existing codebase. I would love to use this format for my existing and future projects. Not only it opens up the scope for contribution by others, its a good example of how not to overdo an introductory documentation for a project. It took me not more 30 min. to go over this, and jump between the code, to have a decent understanding of Prometheus codebase. 

5. <a target="_blank"  href="https://nabla-containers.github.io/">Nabla containers: a new approach to container isolation</a> :

	Nabla introduces a new approach to container isolation by blocking system calls, and therefore reducing the surface vector to as minimal as possible. This leads to minimal containers that are restrictive in what they could do. This project comes from IBM Research, and uses Unikernel techniques to reduce the number of system calls to just 9. If lean and highly secure containers are your thing, this project is worth looking into. 


7. <a target="_blank"  href="https://www.infoq.com/presentations/netflix-titus?utm_source=presentations_about_Containers&utm_medium=link&utm_campaign=Containers">A Series of Unfortunate Container Events @Netflix</a> :

	A fantastic journey into the development of Titus scheduler and container infrastructure at Netflix. The session goes into the details of various incidents and issues that the team had to face as they scaled their container infrastructure. I really like how Netflix addressed the container security problems with respect to cases when potentially containers do not respect the system boundaries and compromise the host. Overall, I see learning around staffing, API management and fail safe mechanisms. If you are considering setting up similar infrastructure in your team / organization, the information in the talk is worth every penny. 

