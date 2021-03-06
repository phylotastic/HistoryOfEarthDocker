# HistoryOfEarthDocker
Instructions to set up historyofearth server.

Download HistoryOfEarthDocker.

Go to HistoryOfEarthDocker directory and write [note that DockerfileWithServer is traditional, like how datelife works; the new Dockerfile sets up as shinyproxy.io wants Dockerfile]

For shinyproxy:

`docker build -t historyofearth .`

To build with no cache

`docker build -t historyofearth --no-cache .`


For regular server:

`docker build -f DockerfileWithServer -t historyofearth .`


Then start the server with

`docker run -t -i -p 80:3838 historyofearth`

After building, you can push to docker hub

`docker tag historyofearth bomeara/historyofearth`

`docker login`

`docker push bomeara/historyofearth`

and then other machines can download it as is to run:

`docker pull bomeara/historyofearth`

And run it as (if doing the DockerfileWithServer, if doing shinyproxy, drop down to that section)

`docker run -t -i -p 80:3838 bomeara/historyofearth`

Now, go to http://localhost on any browser to watch the server running

Doing

`docker run -t -i -p 80:3838 bomeara/historyofearth sh -c '/bin/bash'`

Will log you into the server so you can look around (i.e., in the /srv dir).

Once you've finished looking around, just type `exit` and you will be logged out.

You can run multiple instances using

`sudo docker-compose up -d --scale historyofearth=32` for 32 instances

## Ideas

Could have it do the caching of maps when doing the creation of the docker thing (i.e., call R).

# shinyproxy

Running on host omearashiny1.desktop.utk.edu

This uses shinyproxy-2.1.0.jar from https://www.shinyproxy.io -- we store it locally for convenience but it's their code.

When first setting up the host:

`sudo systemctl edit docker` and paste in contents of override.conf. Or, once it's made, use the command below

`sudo cp override.conf /etc/systemd/system/docker.service.d/override.conf`

Either way, then do

`sudo systemctl daemon-reload`

`sudo systemctl restart docker`

If getting rid of this approach, remove contents of /etc/systemd/system/docker.service.d/override.conf, then daemon reload and restart docker


application.yml is the configuration file for that.

On the server, start

`java -jar shinyproxy-2.1.0.jar` to start shinyproxy and the application

Then go to http://omearashiny1.desktop.utk.edu/8080

## Swarm

Go to node where swarm is being managed. You can change the number of workers in replicas in docker-compose-swarm.yml



`sudo docker stack deploy --compose-file docker-compose-swarm.yml historyofearth`

See how it's doing with

`sudo docker stack services historyofearth`

And stop it with

`sudo docker stack rm historyofearth`

For domain, *, @, www all resolve to `omearashiny1.desktop.utk.edu.` (yes, with a period after edu) using CNAME
