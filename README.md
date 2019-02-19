# HistoryOfEarthDocker
Instructions to set up historyofearth server.

Download HistoryOfEarthDocker.

Go to HistoryOfEarthDocker directory and write

`docker build -t historyofearth .`

To build with no cache

`docker build -t historyofearth --no-cache .`

Then start the server with

`docker run -t -i -p 80:3838 historyofearth`

After building, you can push to docker hub

`docker tag historyofearth bomeara/historyofearth`

`docker login`

`docker push bomeara/historyofearth`

and then other machines can download it as is to run:

`docker pull bomeara/historyofearth`

And run it as

`docker run -t -i -p 80:3838 bomeara/historyofearth`

Now, go to http://localhost on any browser to watch the server running

Doing

`docker run -t -i -p 80:3838 bomeara/historyofearth sh -c '/bin/bash'`

Will log you into the server so you can look around (i.e., in the /srv dir).

Once you've finished looking around, just type `exit` and you will be logged out.

You can run multiple instances using

`docker-compose up -d --scale historyofearth=10` for ten instances

## Swarm

Go to node where swarm is being managed. You can change the number of workers in replicas in docker-compose-swarm.yml

`sudo docker stack deploy --compose-file docker-compose-swarm.yml historyofearth`

See how it's doing with

`sudo docker stack services historyofearth`

And stop it with

`sudo docker stack rm historyofearth`

For domain, *, @, www all resolve to `omearalab13.bio.utk.edu.` (yes, with a period after edu) using CNAME
