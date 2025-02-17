# A Simple Way To Test Webgl Build

-   Thanks to <https://traefik.me/> for providing free ssl certificate

-   **Place** the `h5-serve.sh` file to any where in your `$PATH` and remove the `.sh` extension
-   Run the following command

```bash
# use current dir as http root
h5-serve

# use the specified dir as http root
h5-serve /path/to/your/webgl/build
```

-   Open the browser and visit `https://127-0-0-1.traefik.me` or any `-` ip address that the server is listening on
-   You can also connect `wss://127-0-0-1.traefik.me/ws` with websocket, which proxy_pass to `ws://host.docker.internal:3000`, you can use <https://github.com/darklinden/echo-server/releases/tag/v0.0.1> to start a websocket server for testing
