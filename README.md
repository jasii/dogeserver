### About
Doge / Nut server set up using lsiobase/alpine.python3:3.8. 
If you're familiar with linuxserver.io images this is for you.

### Getting Started
First make a `/doge` folder you are going to mount to.
Make a `/nut` folder inside of doge.
Make a `/conf` folder inside of nut, so that you have `/doge/nut/conf/` directories.

Copy your keys.txt file into `/doge/nut/conf/`
Copy your configured doge.config.json file into the `/doge`
Map your volumes with the docker create script.

    docker create
    --name DogeServer
    -v </path/to/doge/doge.config.json:/doge/doge.config.json
    -v </path/to/doge/data>:/doge/data
    -v </path/to/nsp>:/nsp
    -v </path/to/doge/nut/conf>:/doge/nut/conf
    -v </path/to/doge/nut/conf/keys.txt>:/doge/nut/keys.txt
    -v </path/to/doge/nut/titledb>:/doge/nut/titledb
    -v </path/to/doge/nut/switch>:/doge/nut/switch
    -v </path/to/titles>:/doge/nut/titles
    -e PGID=1000 -e PUID=1000 
    -p 6093:6093
    -p 9000:9000
    jojojoseph/dogeserver


If you need to get into the container and perform commands you can do so with

`docker exec -it DogeServer /bin/bash`

## Parameters
The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container. So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080 http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.

Parameter Function
-p 6093 doge port -p 9000 nut port -e PUID	for UserID, see below for explanation -e GUID	for GroupID, see below for explanation

User / Group Identifiers
Sometimes when using volumes (-v flags) permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user PUID and group PGID.

Ensure any volume directories on the host are owned by the same user you specify and it will "just work" ™.

In this instance PUID=1001 and PGID=1001, to find yours use id user as below:

$ id uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)

Setting up the application Doge access at :6093. Nut access at :9000.
