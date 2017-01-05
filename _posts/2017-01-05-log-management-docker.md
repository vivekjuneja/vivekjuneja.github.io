---
layout: post
title: My thoughts on managing logs for a Container based environment
category: learning
---

![placeholder](https://raw.githubusercontent.com/vivekjuneja/vivekjuneja.github.io/master/images/Kibana3Logs.jpg
 "A Log Dashboard")


A log platform is essential when considering the adoption of containers. The ephemeral nature of containers and the need for creating lightweight container images that must disallow non-related process to co-exist in the same instance, insists on having a usable log platform. There are many go-to solutions that are offered today in the market. Some of them are SaaS-based like Logg.ly, Sematext and some can be hosted in-premise like ELK (Elasticsearch, Logstash, Kibana) stack, Splunk and others. The choice among these is beyond the context of this article. I would, however, like to bring out the considerations that my team took in one such implementation to simplify logs for our development teams dealing with the adoption of containers.

We have been using Elasticsearch for a while, and for various purposes. Most commonly, as our go-to search index for primary applications. Needless to say, we wanted to exploit this asset before evaluating other choices. The thing to know is that my team started to use Docker Containers in the organization in early 2015. At that time, Docker did not come with its own logging driver. With the addition of these drivers, log collection has become less painful.

At the beginning, we used a popular project on Github — <a href="https://github.com/gliderlabs/logspout">Logspout</a> from Gliderlabs. It had separated the log collection concern from the Docker daemon and ran on each Docker host to collect the logs from all running containers. Logspout was configured to transport the logs to our Logstash servers. We used multiple Logstash servers to allow for high availability and redundancy. At the other end of our solution was the Kibana dashboard that we customized to fit the needs of the development team. The customization had many facets. Most prominently, we had created disposable Kibana instances that we could launch on our shared Docker cluster alongside each Dev/Test environment that the development team provisioned. This means, we intentionally isolated our Kibana instances for each deployment of our Dev/Test environment. Also, the Kibana instance had its dashboard configured with the exact instance configuration that it needed to show logs from. This premise was designed to fit with our goal of providing an out-of-the-box solution to our development teams.

A Developer provisioned a full stack Dev environment, and a Kibana instance also got deployed for that particular instance. This Kibana instance is preconfigured with filters and fields that matched the particular instance of deployment, and developers could use it immediately. This was also critical for us to have, as we used a shared Elasticsearch for all our Dev/Test environments. The last thing we wanted was the developer worrying of using the right filter values to pick up the logs of the deployment of their liking. Imagine having 100’s of environments running at the same time, and developers requiring to use the right filter to pick up their logs from Elasticsearch. This was not a good developer experience in our case.

We also added exported extra fields to Logstash thanks to Logspout, that provided the appropriate metadata to allow filterings like container_id, container_host, and other relevant information. This was immensely useful for our developers to slice and dice the logs as they needed based on the multiple filter fields now available at their disposal.

We also faced significant challenges maintaining the causal order of log for applications that leverage synchronous request-response communication. We used multiple Logstash servers which would obviously mess up the order of logs as they come in from a particular Logspout instance on a host. Moreover, we were using @timestamp field in Elasticsearch to sort our logs. The challenge we faced was that we had multiple logs that spanned across the same Millisecond. This meant, that there was no way Elasticsearch could maintain the order of these logs at the same millisecond. This quickly became the most important problem that could derail our plans of getting our developers comfortable with a containerised environment that used a log aggregation platform. The logs in Kibana needed to be in the same order as they arrive from the process running in the Docker container.

We looked at solving this problem in multiple ways.

First, we wanted to check if we could increase the resolution of time, from milliseconds to nanoseconds. This was futile attempt, as a <a href="https://github.com/elastic/elasticsearch/issues/10005">bigger debate</a> carried in the community on the same. It was evident that there is not going to be support for this anytime soon.

From there, we navigated to <a href="https://discuss.elastic.co/t/how-to-maintain-the-order-of-logs/53397/5">another solution</a> — to include an another field in Logstash that could be used to order the logs along with the @timestamp field. To accomplish this, <a href="https://github.com/vivekjuneja/logspout-logstash/blob/master/logstash.go#L202">we made changes to Logspout</a> to inject a number as part of a sequence generator for each log that it transported to Logstash. This meant, we had a new field to hold the sequence, let’s call it a seqId. This sequence field was sent over to Logstash, and then to Elasticsearch. We could then sort on this field in Kibana to get the logs in the order as needed.

There was one problem with this solution.

Logspout in our little experiment was <a href="https://github.com/gliderlabs/logspout/issues/194">messing up the log order</a>. We found that Logspout was not sending the logs in order to Logstash in the first place. So, the sequence generated in Logspout was already out of order as the logs arrived at Logstash. We could not go ahead with this change in Logspout.

We then moved over to Logstash instead. We experimented with having a <a href="https://github.com/pauljb/logstash-filter-sequence">Logstash filter</a> that could generate the sequence number as the logs arrive from Logspout. But, there was an another problem with this idea. As mentioned earlier, we used multiple Logstash servers which were load balanced. There was no guarantee for a set of logs coming from a particular Logspout instance, from a particular container to arrive at the same Logstash instance. With multiple containers running across distributed Docker hosts, and a sequence number that is generated at each Logstash instances, there was a need for each Logstash instance in the load balanced group to agree on the sequence. This is a classic distributed consensus problem, which we wanted to avoid solving at the moment.

To simplify this premise, we started looking at assumptions that we could take advantage of, to implement this idea. One such assumption was to have the Logstash servers be load balanced in a round robin fashion at all times. We went ahead with this assumption using an external load balancer with non-persistent TCP connections. We also <a href="https://github.com/vivekjuneja/logstash-filter-sequence/blob/master/lib/logstash/filters/sequence.rb">made changes to the Logstash filter</a> which generated the sequence number. The change was related to two important concepts when generating a number in the sequence — the starting number or seed and the increment factor. This meant we had each Logstash instance start with a seed number, and with a common increment factor. To elaborate this, let’s say we had three (3) Logstash servers : — L1, L2, L3.

L1 -> seed is set to 1, Increment factor is set to “Number of Logstash servers in the load balanced group” i.e. 3 here.

L2 -> seed is set to 2. Increment factor is same as L1, which is 3.

L3 -> seed is set to 3, Increment factor is same as L1, which is 3.

This mean the following pattern of sequence will be generated at each Logstash server in the load balanced group, if round robin is respected.

L1: 1, 4, 7…

L2: 2, 5, 8…

L3: 3, 6, 9…

This sequence is generated at each Logstash instance matching the above pattern. If a set of logs from a particular Docker Container is split across the three Logstash instances, each such log would carry an increasing sequence number. This meant, when we sort the logs in Elasticsearch, we were guaranteed to have the logs in the order. But, the biggest assumption was that logs have to arrive at each Logstash instance in a round robin fashion. If this does not happen, then this solution will not work. This was a critical constraint to our infrastructure. With persistent TCP connections and buffered writes, it was difficult to get a guarantee for each log line to be evenly sent to each Logstash instance. Moreover, this solution demanded an orchestrated maintenance primitives if a rogue Logstash instance goes down and comes back up. As you can imagine, a recovered Logstash instance would then mess up the order as it would be unaware of the prevailing sequence state.

Again, needless to say, this solution was discarded. However, in the test conditions, we were able to achieve the required order in the logs. We were jubilant, but with an impending sense of chaos when it goes into production. We moved on from this solution to something else.

We decided to throw away some <a href="https://en.wikipedia.org/wiki/Learned_helplessness">learned helplessness</a> that we had in our Log platform stack. We were using Logspout and were pretty comfortable with it. But, it had its own issues, especially around <a href="https://github.com/gliderlabs/logspout/issues/215">working with retries</a> when there were connection failures. The messing up of log order was another nail in the coffin. We reluctantly moved away from Logspout, to prefer the Log driver support built into Docker.

We started evaluating the Graylog driver in Docker, but it used UDP, and that meant the log order was not maintained near the source as evident in our experiments. We then moved on to the Syslog driver. Logs from Docker containers were written to the syslog on the host and then picked up by a Logstash forwarder implementation. Filebeat was selected as the forwarder. Filebeat monitored the syslog and sent the logs to the load balanced Logstash servers. The Logstash instance in this implementation was devoid of our previous attempts at integrating a Logstash filter, and was in the original shape and form right before we started this journey. Also, we analyzed the way our developers were using the Kibana dashboard. The major use case according to them was to filter down to an individual container and expect an ordered log for that particular container instance. This led us to use the <a href="https://discuss.elastic.co/t/regarding-filebeat-offset-value/44139/3">offset field</a> that was transported by the Filebeat instance to Logstash. The offset field maintained the order as the logs arrived from Filebeat to Logstash. This also meant that having a load balanced Logstash servers would not have any effect on the order of logs. The Developer could use Kibana and select the logs that arrive from a particular container by using the appropriate pre-configured filter fields, and then just sort the logs by the offset field.

Interestingly, this solution worked, and we hoped our enthusiasm with this implementation does not jinx it. The following represents our solution at a high level:-

![placeholder](https://cdn-images-1.medium.com/max/1600/1*HHrZi71VHuA1UsaOOOIkJQ.jpeg
 "Log Platform High Level Diagram")

We are currently in the midst of evaluating the above solution. We still need to manage various edge cases, especially with the offset field, when the syslog file rolls over, or Filebeat is restarted due to an unforeseen error. In the test conditions, these issues had limited effect on our results.

We learned quite a bit while investigating the solution to a proper log management solution for our containers. I summarized these learning in three important points, that I would like to remember and advise others pursuing the same road that we took.

1. Building a general purpose log platform for the variety of application use case is hard. Instead of managing at the destination, it is better to provide a consistent set of log patterns as a discipline to the developers. The more the developer sways from the agreed practice, the worse it gets at the destination, breaking the developer experience.

2. Sometimes, managing quirks in logging require optimization with the way we use the logs. This is critical when considering that a distributed logging solution that works well is not for the faint-hearted. Understanding and re-arranging the consumption of logs could avoid complicated engineering decisions.

3. Building a Test infrastructure that can validate all parts of a logging infrastructure like ours is a must before approaching experiments with various tools and practices. We build a certain amount of testability with our log platform that helped us navigate various iterations of our experiments, and reduced the time to investigate and decide on the right solution.

This journey is far away from completion, as we continue working to establish a stable log experience for our developers. We are also investigating ways to increase the resiliency in various parts of the solution. The current solution works with our defined optimization to allow log ordering for a particular container instance. However, if we need distributed log ordering across multiple container instances, then we need to exploit global clocks either through the use of consensus algorithms or through investigation into high resolution synchronized time clocks (in nanoseconds). This is all part of the future work that we are planning to undertake.

Lastly, most of the experiments, and tools that we built as part of it will get open sourced. I hope many of the readers who are embarking upon the route to manage the logs from containers will find this experience to learn from.

Further reading :-

1. A good primer for engineers to treat logging with respect that it deserves :- <a href="https://engineering.linkedin.com/distributed-systems/log-what-every-software-engineer-should-know-about-real-time-datas-unifying">https://engineering.linkedin.com/distributed-systems/log-what-every-software-engineer-should-know-about-real-time-datas-unifying</a>

2. Approach to logging when using Containers :- <a href="https://blog.treasuredata.com/blog/2016/08/03/distributed-logging-architecture-in-the-container-era/">https://blog.treasuredata.com/blog/2016/08/03/distributed-logging-architecture-in-the-container-era/</a>

-----


