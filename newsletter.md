---
layout: page
title: Newsletter
---


<div class="related">
  <h2>Past newsletters</h2>
  <ul class="related-posts">
    {% assign posts = site.categories["newsletter"] %}
    {% for post in posts %}
      <li>
        <h3>
          <a href="{{ post.url }}">
            {{ post.title }}
            <small>{{ post.date | date_to_string }}</small>
          </a>
        </h3>
      </li>
    {% endfor %}
  </ul>
</div>


<div class="posts">
<p>
   <form style="border:1px solid #ccc;padding:3px;text-align:center;" action="https://tinyletter.com/vivekjuneja" method="post" target="popupwindow" onsubmit="window.open('https://tinyletter.com/vivekjuneja', 'popupwindow', 'scrollbars=yes,width=800,height=600');return true"><p>
    Subscribe to my Weekly Newsletter
    <h2> "Crafting the Container"</h2>
    <i>A weekly curated list of information about the Container eco-system, Cloud services, and Cloud Native software development.</i><br /><br />
    <label for="tlemail">Enter your email address</label></p><p><input type="text" style="width:140px" name="email" id="tlemail" /></p><input type="hidden" value="1" name="embed"/><input type="submit" value="Subscribe" /><p><a href="https://tinyletter.com" target="_blank">powered by TinyLetter</a></p></form>
</p>
</div>
<br />

<h3>What is the purpose of Newsletter</h3>
It is becoming difficult to consume and process information these days. We have too many sources of information, and the rate at which information is being created is astonishing. As a Container and Cloud native enthusiast, I spend multiple hours every week going around the web, looking for information. My usual picks : Hacker News, Reddit, High Scalability Blog, Wiki / Blog of key organizations and thought leaders, Books, Twitter, Newsletters and casual chat with my friends and colleagues. I always struggled to put all this information together. And I realized, more information does not mean right information. 

As a knowledge worker, it is crucial that we are careful and deliberate on what we use our time for. Hence, I am starting my first attempt to "curate" the web for you. I am ofcouse kidding ! I am starting a newsletter that will combine my interest in consuming helpful information and writing to present a weekly set of 6 findings that I would recommend to anyone. 

This is an experiment, and I am setting up myself for success. If you are interested to join in, please subscribe to this weekly newsletter. I promise I will do my best to provide you with the best what the web has to offer (not too much and not too less) around the space of "Containerization", "Cloud native software development" and "the engineering mindset" to excel in this transformation. 

I will keep your information private, and will NEVER ever SPAM you with anything. Only relevant information every week around this exciting space.

Happy Reading !


