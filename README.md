Paper MC Docker Images
======================

Dockerfile and script to build and run PaperMC minecraft servers within docker.

Building an image
=================

To build the latest PaperMC build, clone this repository and run:

```sh
docker build -t papermc:latest .
```

Note: You don't have to name the image `papermc:latest`.

If you'd like to build a specific version of Minecraft, you can do that:

```sh
docker build -t papermc:1.19.4 --build-arg PAPERMC_VERSION=1.19.4 .
```

And if you want to use a *particular* build of PaperMC, you can do that too:

```sh
docker build -t papermc:1.19.4-527 --build-arg PAPERMC_VERSION=1.19.4 --build-arg PAPERMC_BUILD=527 .
```

Running a server
================

The server's root directory needs to be mounted to `/srv` within the container. 

Additionally, port 25565 needs to be exposed.

For example: 

```sh
docker run -it -p 25565 -v ./my_server_folder:/srv papermc/1.19.4:latest 
```

Multiple servers
================

If you want to run multiple servers, you need to resolve any port conflicts. The port of the internal server can remain 25565, you just need to map it to a different port externally. Here's an example of binding to port 25566 instead of 25565.

```sh
docker run -it -p 25566:25565 -v ./my_server_folder:/srv papermc/1.19.4:latest
```

