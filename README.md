# Go Dockerized dev environment
A template to start developing go apps inside docker with hot-reload


## Quickstart


Ensure that you have docker installed and started, change the `GO_VERSION` on Dockerfile to the desired go version and change the `GO_PORT` occurencies if you want to expose a port(if you're developing an API for instance).

After that, edit the `Makefile`, substituting the github username and repository with your information

Also in the `Makefile`, change the variable `TARGET_BIN` to your project name

Then run:
```

make setup
```

### Run the application
To run the application with hot-reload, run:
```
make run
```
### Debug the application
To debug the application with delve, run:
```
make debug
```
Then go to VS Code debug tab, select `connect to server` and start the debug session. Add breakpoints and vs code will hit them.

## Build

Just run one of the three comands:

```
make build-macos
make build-linux
make build-windows
```
