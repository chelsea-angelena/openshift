# Openshift Test

Learning to use open shift 

## Installation

Use npm to install dependencoes

```bash
cd client && npm i
```

```bash
cd server && npm i
```

## Usage

### Prereqs
- **openshift developer sandbox account**
- node
- nest-cli
- docker
- oc-cli
- kubectl-cli (optional but useful for quickly troubleshooting pods etc)

### Env Vras

- REGISTRY
    -  run `make oc-registry-info`
    - (copy output into the REGISTRY var in .env)
- PROJECT
    - name of your project in the developer sandbox

- CLIENT_IMAGE=openshift-client (or whatever makes sense)

- SERVER_IMAGE=openshift-server (or whatever makes sense)

### Openshift Login
go to: "https://console-openshift-console.apps.sandbox-m3.1530.p1.openshiftapps.com/k8s/ns/<your namespace>" and click your name to copy the login cmd


### Openshift Registry Info
Details instructions are here:
https://cookbook.openshift.org/image-registry-and-image-streams/how-do-i-push-an-image-to-the-internal-image-registry.html

### Set Registry Env Var
run `make oc-registry-info`
(copy output into the REGISTRY var in .env)

### Deploying To OC

`make oc-registry-login`

`make build`

`make tag-server`
`make tag-client`

`make push-server`
`make push-client`

`make apply`

## License

[MIT](https://choosealicense.com/licenses/mit/)
