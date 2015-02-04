# docker-nginx
Example of how nginx could be easily used to proxy containers

This is a docker container that runs three little python servers to 
simulate three docker containers running on a host.  Nginx is then 
used to proxy the three servers (running on ports 8080, 8081, and 8082)
to the end user as separate paths on the host.

### Build the docker image

`git checkout https://github.com/bmamlin/docker-nginx`

`cd docker-nginx`

`docker build -t foo .`

### Run the docker image

`docker run -d -p 80:80 --name foo foo`

### If you are on Mac or Windows, get the IP address of your docker VM

`boot2docker ip`

### Browse to the example

http://http://192.168.59.103/

(assuming your docker host is running at 192.168.59.103)

# What's the point?

The main point of this exercise is to see how easily nginx can proxy 
multiple containers.  Take a look at the config (I've purposefully limited 
it to the bare essentials for example):

```
daemon off;

events { }

http {
  server {
    listen 80;
    location / {
      root /docs/root/;
    }
    include /nginx_proxies/*;
  }
}
```

Ignore the daemon thing (that's just for this docker example).  The `events` 
block would contain some detail about how many worker bees should be serving up 
content.  It isn't too hard to understand that the `http` block describes a 
`server` listening on port 80, serving documents from `/docs/root/` and including 
some additional directives from the `/nginx_properties/` folder.

If you look in the `nginx_properties` folder, it's just a file per proxy. Each one 
has a simple directive like this:

```
location /one {
	proxy_pass http://localhost:8080/;
}
```

Again, it's pretty simple.  It's not hard to decipher that this is telling nginx 
requests to `/one` should be passed to `http://localhost:8080/` (one of our little 
python web servers).  On a real host, each of these proxy files would map a 
particular path to an app running in a docker container.
