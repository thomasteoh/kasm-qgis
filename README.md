# Kasm workspace image with QGIS installed

[Kasm Workspaces](https://www.kasmweb.com/) is a platform for streaming containerised apps and desktops to end-users. QGIS is a desktop geographic information system. This Docker image is the current Kasm distribution of Ubuntu Bionic (18.04) with QGIS 3.0 pre-installed. 

image

The docker image is available on dockerhub [here](https://hub.docker.com/r/tteoh/kasm-qgis)

```
docker pull tteoh/kasm-qgis
```

# Adding a link to the image

You will need to link the image in the administration pane of Kasm Workspaces to allow users to access it as an app.

Adding an app icon and a shared folder at this point is recommended.

More information can be found on [the official website](https://www.kasmweb.com/docs/latest/guide/custom_images.html)

# Manual deployment

To build the image:

```
docker build -t tteoh/kasm-qgis -f Dockerfile .
```

While these image are primarily built to run inside the Workspaces platform, they can also be executed manually. Please note that certain functionality, such as audio, uploads, downloads, and microphone pass-through are only available within the Kasm platform.

```
docker run --rm  -it --shm-size=512m -p 6901:6901 -e VNC_PW=password tteoh/kasm-qgis
```

The container is now accessible via a browser: `https://<IP>:6901`

- User: `kasm_user`
- Password: `password`

# About Workspaces

Kasm Workspaces is a docker container streaming platform that enables you to deliver browser-based access to desktops, applications, and web services. Kasm uses a modern DevOps approach for programmatic delivery of services via Containerized Desktop Infrastructure (CDI) technology to create on-demand, disposable, docker containers that are accessible via web browser. 

Information taken from [kasmtech/workspaces-images](https://github.com/kasmtech/workspaces-images).
