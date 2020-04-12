This is a fork from: https://github.com/michaelkamprath/multi-service-rtmp-broadcaster

# Multi-Service RTMP Broadcaster

The goal of this project is to create a Docker-deployed service that will allow you to easily broadcast a livestream to multiple services (YouTube, Twitch, Facebook, etc) at the same time. This stream rebroadcaster is designed to be used by a single source / user.

## Usage
The instructions here assume you are running on linux. With some modification of the commands, you can make this Docker build work on Windows and Mac OS too.

The first step is to build the docker file. After you clone this repository, `cd` into and and issue:

```
docker build -t multistreaming-server ./multistreaming-server/
```

Once built, start the server on the same host as where your streaming source (e.g., OBS) is running with:

```
docker run -it -p 80:80 -p 1935:1935 \
  --env MULTISTREAMING_PASSWORD=__made_up_password__ \
  --env "MULTISTREAMING_KEY_TWITCH1=__your_twitch_stream_key__" \
  --env "MULTISTREAMING_KEY_TWITCH2=__your_twitch_stream_key__" \
  --env "MULTISTREAMING_KEY_FACEBOOK1=__your_facebook_stream_key__" \
  --env "MULTISTREAMING_KEY_FACEBOOK2=__your_facebook_stream_key__" \
  --env "MULTISTREAMING_KEY_INSTAGRAM1=__your_instagram_stream_key_from_yellow_duck__" \
  --env "MULTISTREAMING_KEY_INSTAGRAM2=__your_instagram_stream_key_from_yellow_duck__" \
  --env "MULTISTREAMING_KEY_YOUTUBE1=__your_youtube_stream_key__" \  
  --env "MULTISTREAMING_KEY_YOUTUBE2=__your_youtube_stream_key__" \  
  --env "MULTISTREAMING_KEY_MICROSOFTSTREAM1=__your_microsoft_stream_ingest_url__" \
  --env "MULTISTREAMING_KEY_MICROSOFTSTREAM2=__your_microsoft_stream_ingest_url__" \
  --env "MULTISTREAMING_KEY_CUSTOM1=__your_full_rtmp_url__" \
  --env "MULTISTREAMING_KEY_CUSTOM2=__your_full_rtmp_url__" \
  --env "MULTISTREAMING_KEY_PERISCOPE1=__your_periscope_stream_key__" \
  --env "PERISCOPE_REGION_ID1=__periscope_2-letter_region_code__" \
  --env "MULTISTREAMING_KEY_PERISCOPE2=__your_periscope_stream_key__" \
  --env "PERISCOPE_REGION_ID2=__periscope_2-letter_region_code__" \
  multistreaming-server:latest
```

Alternatively, you could use the DockerHub build of this image by pulling and using the `hovee/multistreaming-server:latest` Docker image.

Note that several environment variables are set when running the Docker image. There are duplicates for each service if you would like to stream to different pages for one service.

* `MULTISTREAMING_PASSWORD` _(REQUIRED)_ - This is a password you define and will be used by your steaming software. This is a marginally secure way to prevent other people from pushing to your stream.
* `MULTISTREAMING_KEY_TWITCH1` _(OPTIONAL)_ - Your Twitch stream key. Only define if you want to rebroadcast your stream to Twitch.
* `MULTISTREAMING_KEY_TWITCH2` _(OPTIONAL)_ - Your Twitch stream key. Only define if you want to rebroadcast your stream to Twitch.
* `MULTISTREAMING_KEY_FACEBOOK1` _(OPTIONAL)_ - Your Facebook stream key. Only define if you want to rebroadcast your stream to Facebook.
* `MULTISTREAMING_KEY_FACEBOOK2` _(OPTIONAL)_ - Your Facebook stream key. Only define if you want to rebroadcast your stream to Facebook.
* `MULTISTREAMING_KEY_INSTAGRAM1` _(OPTIONAL)_ - Your Instagram stream key. You will need to use https://yellowduck.tv/ to retrieve your stream key for Instagram. Only define if you want to rebroadcast your stream to Instagram.
* `MULTISTREAMING_KEY_INSTAGRAM2` _(OPTIONAL)_ - Your Instagram stream key. You will need to use https://yellowduck.tv/ to retrieve your stream key for Instagram. Only define if you want to rebroadcast your stream to Instagram.
* `MULTISTREAMING_KEY_YOUTUBE1` _(OPTIONAL)_ - Your YouTube stream key. Only define if you want to rebroadcast your stream to YouTube.
* `MULTISTREAMING_KEY_YOUTUBE2` _(OPTIONAL)_ - Your YouTube stream key. Only define if you want to rebroadcast your stream to YouTube.
* `MULTISTREAMING_KEY_MICROSOFTSTREAM1` _(OPTIONAL)_ - Your Microsoft Stream Ingest URL. Only define if you want to rebroadcast your stream to Microsoft Stream.
* `MULTISTREAMING_KEY_MICROSOFTSTREAM2` _(OPTIONAL)_ - Your Microsoft Stream Ingest URL. Only define if you want to rebroadcast your stream to Microsoft Stream.
* `MULTISTREAMING_KEY_CUSTOM1` _(OPTIONAL)_ - Your full RTMP url, including rtmp://, to any live stream service. Only define if you want to rebroadcast your stream to a custom service.
* `MULTISTREAMING_KEY_CUSTOM2` _(OPTIONAL)_ - Your full RTMP url, including rtmp://, to any live stream service. Only define if you want to rebroadcast your stream to a custom service.
* `MULTISTREAMING_KEY_PERISCOPE1` _(OPTIONAL)_ - Your Periscope stream key. Only define if you want to rebroadcast your stream to Periscope.
* `PERISCOPE_REGION_ID1` _(OPTIONAL)_ - The two letter region code that is part of the Periscope server URL. If undefined, it will default to `VA` (the "US East" region)
* `MULTISTREAMING_KEY_PERISCOPE2` _(OPTIONAL)_ - Your Periscope stream key. Only define if you want to rebroadcast your stream to Periscope.
* `PERISCOPE_REGION_ID2` _(OPTIONAL)_ - The two letter region code that is part of the Periscope server URL. If undefined, it will default to `VA` (the "US East" region)

You could start this docker with no stream keys defined, but that wouldn't do anything interesting then.

Once the Docker image is running, set up your stream software with the following paramters:

* **Server** : `rtmp://__docker_host_IP_address__/live` - Replace `__docker_host_IP_address__` with the IP address of your host that is running this Docker container.
* **Stream Key** : `__made_up_stream_name__?pwd=__made_up_password__` - Here `__made_up_stream_name__` is any arbitrary stream name, and `__made_up_password__` is the same password defined for `MULTISTREAMING_PASSWORD` above.

In OBS, you would set the above parameters for a "Custom..." Service in the Stream settings.

The next thing to do is start your stream!

## Future work

Goals for future improvements to this project include:

* Adding more streaming services
* Creating a useful status web page
* Create a control panel web page where you'd set stream keys rather than through environment variables
* Enable management of multiple stream rebroadcasts

## Acknowledgements

This work was heavily influenced by the following articles:

* The basic concept: [https://www.scaleway.com/en/docs/setup-rtmp-streaming-server/](https://www.scaleway.com/en/docs/setup-rtmp-streaming-server/)
* How to use `rtmps` with Facebook: [https://dev.to/lax/rtmps-relay-with-stunnel-12d3](https://dev.to/lax/rtmps-relay-with-stunnel-12d3)
