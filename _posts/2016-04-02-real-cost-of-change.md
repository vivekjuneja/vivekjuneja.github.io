---
layout: post
title: The real cost of Change - Perspectives of adopting the DevOps, Microservices and Container Bandwagon 
---

![placeholder](https://vivekjuneja.files.wordpress.com/2016/04/shipping-containers.jpg?w=660 "shipping containers")


This happens quite often in the life of an organisation. New plateaus emerge, technologies become outdated, and the growing ball of mud becomes too big to endure. Technology teams become fascinated with the prospect of playing with new shiny things, some desperately trying to add new skills to their resume on the excuse of making “radical” changes, while others dumbstruck with the plethora of choices in front of them. Half baked understanding leads to shallow inferences, that often get propagated to the “real” decision makers. Meetings, after meetings, often mixed with a hint of “consultants” and “industry-pundits” become the immediate action items. Google searches for adoption stories, and blog posts, keep humming in the background, as the gardeners of technology hunt for information. Conferences and meetups, become the important part of the monthly ritual, some preferring to digest the video recordings over physical interaction. Graphs emerge, some hyped with hype cycle, and some hand-crafted with the elementary understanding of basic statistics.

For an organisation, that is torn between re-inventing itself into a technology company, and preserving its heritage, this journey into the unknown is becoming more difficult, than the actual process of adoption. This journey into the unknown represents the chaotic endeavour to make decisions about the implications of evolving technologies and making them relevant to the actual business. The situation is better in organisations that have embraced technology as its key asset, investing heavily in gathering enterprising minds who have depth and breadth to sustain this unpredictable journey. For the rest, they have to settle for the ordinary, who are stuck in their ways, fighting change as if it is a virus infecting their existence. The rest of the organizations are still in the midst of transformation, having battle scars from using technology to operate their businesses, and yet reluctant to acknowledge the real problem. It's for them, that this transformation, aided by the constant reminder of their ball of mud and the damage it's doing, is the most complex.

Microservices relates itself with 
Service Orientation done right". DevOps relates itself with "Agile done right". Containers relate itself with "Virtualisation done right". In the midst of the growing stories, and rising expectations from these transformation-enabling practices, organisations are increasingly finding hard to identify the real cost of this transformation. The real cost for this transformation relates to acknowledging the change that these practices would have on people, tools, process, culture and organisational politics. Most of the organisations are swayed easily with the ever increasing benefits of adopting these practices, without due diligence to the after effects if these practices are not embraced completely. This in part is quite similar to the accounts of misplaced Agile adoption stories. The poorly understood Agile manifesto remains as a mere mention on the presentation slides that technology teams present to the business. In retrospect, most Agile horror stories emerge from organisations that have had teams practicing some form of this methodology with poor attention to continuous deployment, continuous testing, continuous integration, continuous release, backlog grooming, and right user stories. These teams with poor implementation of Agile, often get stuck with the “religious” rituals like stand-up meetings, retrospectives, backlogs, burndown charts among others, and treat these rituals as the only basis for adopting Agile practices. These stories should be acknowledged, and considered as a reference to how good intentions, with misplaced expectations and understanding, can wreck havoc on an organisation.

The usual practice of pitching these transformation-enabling trio : Microservices, DevOps and Containers, is to account the benefits that they have when modernizing existing products and teams. Monoliths will be broken into Microservices, allowing a better granularity that leads to a coherent set of functions that are independent of the rest of the herd. DevOps is the way each team will build and operate these Microservices, allowing each team to have a shared success definition amongst the diverse set of roles in that team. This will lead to ownership, meaning people in these teams will care for their work, and the exposure to run and operate the services in production, will lead to better accountability and discipline. Containers will become the way these Microservices will be packaged, deployed, and released on infrastructure. This will lead to better infrastructure utilisation, and simplify the way a change is moved from a developer’s machine to the production environment.

While all the benefits do matter, the field of view of a technology team in such an organization usually misses the hidden and sometimes less-accounted concerns that will emerge from this change. These hidden and minimal-accounted concerns provide a basis for leveraging the practices of Microservices, DevOps and Containers in total, rather than in parts. Can Microservices be adopted, without DevOps ? Can Containers be adopted without considering Microservices ? These questions are fundamentally more insight worthy than mere adoption of the practices. To follow this up, questions could be asked to probe this even further like : What happens if I choose to build Microservices without having to use Containers and not leveraging DevOps ?

To identify the real cost of this transformation, it is relevant to talk about Complex Systems, and how they function. A Complex system is a System of Systems. Much like a human mind. In the seminal book by Marvin Minsky, “The Society of Mind”, the late extraordinary AI pioneer provides a view of how the mind is structured in the form of a Society. The Society contains independent service driven functions or members. Each member is unaware of the implications of its effort and function. However, to accomplish something as complex as picking up a cup of tea to drink requires a hierarchical execution of numerous such functions. Minsky theorizes the execution of these independent functions as the state of mind. So, the mind itself manifests in the various ways these functions work together, each oblivious of its impact to the greater self. Similar to the complexity of a human mind, a System of systems cannot function just by being there. It needs ways to manage the growing complexity of tens, hundreds, thousands and more such functions. It needs techniques to self-evolve through the continuous evolution of its functions. Each such function is easy to reason, and easy to evolve. Away from the mind, a large system that is composed of many systems, each of which could be a Microservice, is evolving continuously. Its evolution is marked by the individual evolution of each of the many systems that it's composed of. Each such system inside the large system is changing. And each such system needs a way to reliably and timely move its changes in operation, without disturbing the overall state of this large system.

A large system like Banking application when composed of Microservices may have 100’s of such systems. Each system is one or more collection of Microservices. At a microservice level, the system is simple and independent. However, the Banking system at large is complex. Compare this to perhaps an earlier iteration of the Banking application, which could have been a monolith. It also has many systems, however, they are not independent, and simple. Even with the best design practices, these systems inside Monolith would have shared state, and shared execution. Partitioning these individual systems from the Monolith and having them to run on individual machines (physical or virtual) means to have those many numbers of machines available in your arsenal. A Monolith may require only a few machines to run and operate, but with the partitioning, the individual systems require independent machines. These individual systems now need independent coverage of high availability, resilience, and fault tolerance. In the case of a Monolith, all such coverage would have been for just one big system. A Complex system if in a form of Monolith requires a single focussed effort for scaling, availability, fault tolerance and operational activities. The fallacies of a Distributed systems now apply to each such independent systems.

A Complex system being built with Microservices has more moving parts. The individual components of this system need individual attention and operation. Individual attributes apply to each such member inside the Complex system. Effectively, we now have multiplied our problems with the number of such individual systems or services that exist within this Complex system. A Complex system of such kind has its evolution dependent upon the many evolutions that happen among its many members. If a particular behavior of the Complex system requires change across many internal systems or services, then this means a combined effort of changes for all participating services. One slow moving or performing a change in any of these participating service means a slow changing Complex system. Each participating service in the Complex system now needs a way to move fast and needs access to capabilities so that it can produce change faster. This puts stress on changing the dynamics of each team that runs the individual system.

A study of a complex system cannot complete without mentioning about testing. Testing Complex system is harder when it is composed of many smaller systems like Microservices, each of which is independent and is constantly evolving. When a Complex system becomes even bigger, with 100’s of individual services, the only way to reason out problems is by teasing failures in various parts of the system, and finding out how individual systems behave. This is in itself a complex activity and requires new practices, tools, and processes to be useful. A complex system hence is like an organism. It's messy, chaotic, is continuously evolving and requires radical ways in understanding and making changes. Planning a change on such a complex system cannot happen with the traditional mindset of a control from the ivory tower.

The real cost of change to adopting Microservices, DevOps and Containers is to acknowledge the increasing complexity of a system that is based on these practices. The end system is a Complex being, which is fast, agile and continuously evolving. However, beneath its covers is a mess and chaos of many participating services that function independently, and each such service is oblivious of the overall goal of the function of the Complex system. At a service level, it is easy to reason out problems and concerns, but at a Complex system level, this is a completely new game. Existing practices will not scale for such a Complex system, instead, it will increase the cost of sustenance of such a system. The chaos, if managed from the ivory tower, will look like a mess, and may disappoint power herders who like to know and control everything. The way to arrive at the real cost of change is to question the existing practices, processes, and culture in an organisation in the light of this new Complex system. How will your organisation change when you have to deal with this Complex being ? That is the question that will merit more insight, and provide better answers that influence the success of such practices.

Notes: <a href="http://highscalability.com/blog/2015/4/27/how-can-we-build-better-complex-systems-containers-microserv.html">High Scalability : 
How Can We Build Better Complex Systems? Containers, Microservices, And Continuous Delivery.</a>
