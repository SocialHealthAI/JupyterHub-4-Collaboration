# Docker base image of JupyterHub for Collaboration
Files used to build the Docker image: 
__[JupyterHub for Collaboration](https://hub.docker.com/repository/docker/jeffgunderson/jupyterhub4collaboration)__

The image has the following packages and extensions:
- Anaconda to support multiple environments and provide popular data science libraries
- JupyterLab Git to manage updates and sharing on GitHub
- Support for reveal.js to produce slide shows
- JupyterLab Table of Contents support
- JupyterLab Spell Check
- Interactive Matplotlib support for presentations
- Support for adding new users

To see how the Docker image was built:
__[Building Docker Based JupyterHub for Collaboration](http://socialhealthai.org/ai-solutions/building-docker-based-jupyterhub-for-collaboration-917ec296b44d/)__

To deploy the image you will need to install Docker. Using a terminal or PowerShell you can pull the image from DockerHub and run the image in a container named j4c using:
~~~
docker run -p 8000:8000 -d --name j4c / jeffgunderson/jupyterhub4collaboration
~~~

You should see the image running by selecting Containers in Docker Desktop.

Connect to the container in a browser using http://localhost:8000 and you should see the Sign in prompt. Sign on with user "admin", password "default". This will present the JupyterHub Launcher where you can launch notebooks, consoles and other applications.

JupyterHub supports a number of user authentication methods. We are using the default PAM-based Authenticator, for logging in with container user accounts via a username and password. To add a new user select File > Hub Control Panel > Admin.  When adding a new user, the user will have password "default". You can change the password defined in the container user account. In a terminal or PowerShell start a bash shell:
~~~
docker exec -it j4c bash
~~~
and change the password with:
~~~
passwd username
~~~
To start using collaboration tools see:
__[Using GitHub for Collaboration with JupyterLab](http://socialhealthai.org/ai-solutions/using-github-for-collaboration-with-jupyterlab-f6ee51ff4e0c/)__
and 
__[Effective Documentation and Presentations with JupyterLab](http://socialhealthai.org/ai-solutions/effective-documentation-and-presentations-with-jupyterlab-c7fb9bcf39bf/)__

