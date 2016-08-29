---
layout: post
title: Using Docker to build a Computing cluster with ARM devices
---

For most part of last decade, ARM architecture has become a mainstream, thanks to widespread adoption of low-power devices, and IoT boom. However, for a significant part of the history, the x86 architecture has dominated the scene, especially with the large heavy-weight public cloud vendors behind them. There were clear boundaries between these two giants. Intel x86 dominating the server class, and desktop / laptop space. The ARM on the other hand, dominating the low-power embedded space, not to mention the maker space, especially with the advent of Raspberry Pi devices. These giants also, represent a clear division in their core philosophy and processor architecture type. x86 preferring the Complex instructions, and larger vocabulary set to perform operations, and ARM preferring the alternative RISC architecture. 

Docker has been phenomenally great for the developer and operations community, helping them streamline the process of building Ops friendly software. It not only democratized Linux containers by proposing and developing new patterns in software development, it also made containers mainstream amongst developers around the world. From its introduction in 2013, Docker predominately targeted the Linux users, with support for Mac and Windows being made available through the use of Virtual box and other virtualization software. However, the current generation of Docker natively supports MacOS and Windows, making it a darling for all developers across the camps. However, the adoption of Docker is still concentrated on the x86 hardware, as all the mainstream servers are still using this platform.

Raspberry Pi did to ARM, what Docker did to Containers. RPi made ARM more accessible to developers who were not into embedded or mobile development. The maker community used RPi as low-cost way to power their IoT implementations, and made ARM a household name for many. It was not long before, Docker came to RPi as well. Hypriot released the Docker release for ARM devices, especially Raspberry Pi, which became an instant hit. It attracted a lot of interest among developers, who wanted to exploit a low cost way of running containers. More than that, it just made the prospect of building large computing clusters that are made of low-power and yet performant architectures. 

Raspberry Pi opened the market for many players, each bringing additional specs and power to the low-cost devices. Pine64 had a successful Kickstarter campaign this year, and brought a low-cost 64 bit general purpose ARM computer to the market. It came in 3 flavors, with the choice between 512 MB, 1GB and 2GB RAM to choose from. This was months before Raspberry came with their Pi 3 with the same specs.

For me, the fun was to be able to run a mini-cluster that would serve Docker containers, and be able to run decent distributed system at a low-cost. I picked up 1 Raspberry Pi 3, with 1 GB RAM, and 3 Pine64 boards, each also having 2GB RAM. So, in total there are 4 low-cost boards, with the total RAM of 7 GB. 

Let us start with the specs first. 

![placeholder](https://www.raspberrypi.org/magpi/wp-content/uploads/2016/02/IMG_40901.jpg
 "Raspberry Pi")

<a href="https://www.raspberrypi.org/products/raspberry-pi-3-model-b/">RPi 3 offers</a>: 64 bit Quad-core ARMv8 CPU, 1.2 Ghz and 1 GB RAM

![placeholder](http://static.techspot.com/images2/news/ts3_thumbs/2015/12/2015-12-09-ts3_thumbs-9bb.jpg
 "Pine64")


<a href="https://www.pine64.com/faq-pine-64#toggle-id-4">Pine64 offers</a>: 64 bit Quad-core Cortex A53 CPU 1.2 Ghz and 2 GB RAM

In total, we have over 16-core CPU and 7 GB RAM in this cluster. 

![placeholder](https://dl.dropboxusercontent.com/s/xanyjw303p68r55/ARMCluster-Page11.jpeg?dl=0
 "cluster config")

I installed the <a href="http://blog.hypriot.com/downloads/">Hypriot Docker Debian package</a> for Raspberry Pi on the Raspbian operating system. Alternatively, one can use the <a href="http://blog.hypriot.com/getting-started-with-docker-on-your-arm-device/">Hypriot OS</a> to install a working image having Docker installed and configured on the RPi device. 

We use Docker Swarm to manage the cluster. We use the Raspberry Pi to run the Docker Swarm Manager. For the Swarm cluster, we will use Consul as the Service Discovery backend. The following command starts the consul server in bootstrap mode, meaning it will not work as cluster. This is good only for development use, and not recommended for Production. 

{% highlight js %}
docker run -d -p 8500:8500 --name=consul progrium/consul -server -bootstrap
{% endhighlight %}

I modified the “/etc/default/docker” file by adding DOCKER_HOST environment variable, and pointing it to "-H tcp://0.0.0.0:2376”. This exposes port 2376 for accessing the Docker REST API. 

We will now start the Swarm Manager. The following command will start the Swarm manager that exposes the port 4000 on the host for the Swarm API. The consul backend address is provided to the Swarm manager. 

{% highlight js %}
docker run -d -p 4000:4000 swarm manage -H :4000 --advertise 192.168.99.100:4000 consul://<consul-host-ip>:8500
{% endhighlight %}

Next, we would need to install Docker on Pine64 board. We use the pine64 ubuntubase image based on the longsleep kernel. I downloaded this image from <a href=
"https://www.pine64.pro/getting-started-linux/"
>https://www.pine64.pro/getting-started-linux/</a> The exact version is 3.10.65 BSP, dated April 24 2016. The link has all the details to install the OS Image on the pine64 board. I had no issues installing the image, and was fairly simple to setup.

Once the operating system was installed on all Pine64 boards, I took to installing the Docker service on the board. Thankfully, the Debian repository has the Docker package, and is easy to install it via the package manager.

{% highlight js %}
apt-get install docker.io
{% endhighlight %}

Post installation of docker, I had to setup the Swarm agent could communicate to the Swarm manager. Before that, we would require to expose the port that could communicate with the Docker REST API on the Pine64 board. I modified the “/etc/default/docker” file by adding DOCKER_HOST environment variable, and pointing it to "-H tcp://0.0.0.0:2376”. This exposes port 2376 for accessing the Docker REST API. 

For running the Swarm agent on the Pine64 board, I used the rpi-swarm image from Hypriot. I also provided the Consul backend to the swarm container to allow for it to be discovered by the Swarm manager. Remember, we used the same consul backend for the Swarm manager earlier. 

The following command starts the Swarm agent on the Pine64 board :-

{% highlight js %}
docker run -d hypriot/rpi-swarm:latest join --advertise=<pine64-host-ip>:2376 consul://<consul-host-ip>:8500
{% endhighlight %}

The above instructions needs to be repeated on each of the Pine64 board. 

To verify if the Swarm cluster is setup, we can issue the following to check the configuration of the cluster :-

{% highlight js %}
docker -H :4000 info
{% endhighlight %}

We can also check if any containers are running on the cluster using the following :-

{% highlight js %}
docker -H :4000 ps
{% endhighlight %}

If everything is installed correctly, the cluster is ready for use. To run some sample containers on the cluster, issue the following command on the Swarm manager :-

{% highlight js %}
docker -H :4000 run -e reschedule:on-node-failure -p 3000:3000 hypriot/rpi-python python -m SimpleHTTPServer 3000
{% endhighlight %}


The above command runs a Python container on the cluster, and exposes port 3000 on the container host. The Swarm manager schedules the container to run on the cluster. 

I also used the <a href="https://github.com/kevana/ui-for-docker">Docker UI</a> project to manage the swarm cluster, and provides a simple Web UI to visualize the basic adminstration tasks for the cluster. One can also use the project <a href="https://github.com/bfirsh/swarm-viz">Swarm Viz</a> to visualize the swarm cluster, and display how the containers are laid out on the cluster. Its a simple visualization, that adds to the appeal of the running a container cluster. 


I also added Monit agent on each Docker host to gather the monitoring information. The M/Monit Dashboard can be installed to collect the monitoring information from all the Monit agents. 

I also tested the limits of the cluster by bombarding it with container creation requests through the Docker client. I used the following command to deploy 1000 containers on the cluster in a sequence :-

{% highlight js js %}
start_port=5000; for i in `seq 1 1000`; do port=$((start_port+i)); echo $port; docker -H :4000 run -e reschedule:on-node-failure -p $port:$port hypriot/rpi-python python -m SimpleHTTPServer $port; done
{% endhighlight %}


Together with the <a href="https://mmonit.com/">M/Monit</a> dashboard, it is possible to identify how the above command leads to change in performance of the cluster. One can identify the cpu and memory performance on issuing the load on the cluster. 

The next target for me is to test out a distributed application containing a proxy and load balancer, web servers, application server and a database. It would be good to deploy these services in a redundant and highly available mode, and then use Docker swarm to test the resilience of the cluster. 

<iframe src="https://player.vimeo.com/video/180603848" width="640" height="360" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
<p><a href="https://vimeo.com/180603848">Running Docker Swarm on Pine64 cluster</a> from <a href="https://vimeo.com/user4434842">vivek juneja</a> on <a href="https://vimeo.com">Vimeo</a>.</p>

In the next installment of this post, I will deploy the distributed application on the cluster, and also put some screencasts visualizing the performance of the cluster. 



