Vidushi Jain - MobileAppAndServices - First Programming Assignement

Product built - ViduGram (Instagram)
I decided to build a sample Instagram application and called it ViduGram. 
An application very similar to a rudimentary version of Instagram.  
ViduGram allows users create an account through the sign up screen. 
It then allows logged in users to follow other registered accounts.
Once a user has created an account then can post and share images to their feed. They can also add a comment along with their username to the image they are sharing. 
Similar to instagram, I also created a feed section where images posted by users are visible to others following them. 

To get started I downloaded XCode and wrote in Swift to build my first iOS application. 
Next I created a GitHub account to create my code repository. 
I used a Git Cheat Sheet to familiarize myself with the steps of pushing my code onto my repository. https://education.github.com/git-cheat-sheet-education.pdf
How to add changes to git:
* git status
* git add *
* git commit -m "Commit Message"
* git push
* Create pull request in github repo
* Merge pull request

I signed up for a Udemy course https://www.udemy.com/course/ios-12-developer-course/learn/lecture/10863736#overview 
on how to build your first iOS sample application and followed the Instagram tutorial. 
The course taught my how to create my AWS account to process and store user account information. 
Next, I followed the steps in the tutorial to use Parse Server to store user data on AWS. 
A bug I encountered was the course used an older version of Swift. I was able to overcome that problem by using stack overflow and the XCode auto fix feature to make it compatible. 

URL to my repository - https://github.com/VidushiJain106/MobileAppOne


AWS Commands:

To connect to server:

* cd ~/MobileAppOne
* ssh -i "instagram.pem" bitnami@ec2-3-143-204-92.us-east-2.compute.amazonaws.com


To run the backend server which serves the paths to the topic photos:
* python imageServer.py

To run a server that serves the images:
* python3 -m http.server 8000


Problems:

Setting up the server -> Username from aws was incorrect. When trying to logon to the commandline with user@aws.ip 





