``docker build .``

![docker build result](.\static\dockerBuild.png)

take image id and run

``docker run -p 3000:3000 2012c68a4ddd9959c82e1682487256eb4a72549090274d6de9e0fc6033e06be0``

the cmd should stay suspended if it worked

go to localhost:3000 and see the "Hi there!" message

``docker ps`` lists all the available container

take the NAME of the container and you can use it to stop the container 

![docker build result](.\static\dockerPs.png)

``docker stop great_panini``
