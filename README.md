# melat-demo

## Dockerfile for OpenShift
```
RUN chgrp -R 0 /var/cache/nginx /var/run /etc/nginx /usr/share/nginx/html && \
    chmod -R g=u /var/cache/nginx /var/run /etc/nginx /usr/share/nginx/html
```

---

## With Docker Run
```bash
docker build -t melat-demo:v1 .

docker build -t melat-demo:v2 .

docker run -d -p 8080:8080 --name melat-container melat-demo:v1
```

---

## With Docker Compose Volume
```bash
docker compose -f docker-compose-volume.yaml up -d

docker compose -f docker-compose-volume.yaml down
```

## With Docker Compose Production
```bash
docker compose -f docker-compose-prod.yaml up -d

docker compose -f docker-compose-prod.yaml down

nano docker-compose-prod.yaml # Change the image to v2

docker compose -f docker-compose-prod.yaml up -d
```

---

## Push to Registry
```bash
docker tag melat-demo:v1 registry.sarvrayaneh.com/test/melat-demo:v1
docker tag melat-demo:v2 registry.sarvrayaneh.com/test/melat-demo:v2

docker push registry.sarvrayaneh.com/test/melat-demo:v1
docker push registry.sarvrayaneh.com/test/melat-demo:v2
```

---

# OpenShift
1. Create deployment
2. Create Service
    ```bash
    oc expose deployment melat-demo --port=8080 --target-port=8080 --name=melat-demo-service -n melat
    ```
3. Create Route
   ```bash
   oc expose service melat-demo-service -n melat
   ```
4. Get URL
   ```bash
   oc get route melat-demo-route -n melat -o jsonpath='{.spec.host}'
   ```

---

## Make sure Always get the latest image
```bash
imagePullPolicy: Always
```
### Maybe need to change the image tag
```bash
registry.sarvrayaneh.com/test/melat-demo:v3.1
```
## Check the created time of image
```bash
docker inspect registry.sarvrayaneh.com/test/melat-demo:v3 | grep -i created
```

---

# Check logs
```bash
oc logs deployment/melat-demo -n melat
oc logs pod/<POD-NAME> -c nginx -n melat
oc describe pod <POD-NAME> -n melat
```

---

# Not recommended
```bash
oc adm policy add-scc-to-user anyuid -z default -n melat
```
## Final proposed version for default SCC compatible securityContext:
```yaml
spec:
  containers:
    - name: your-container
      securityContext:
        allowPrivilegeEscalation: false
        capabilities:
          drop:
            - ALL
        seccompProfile:
          type: RuntimeDefault
```

# Color
## v1
```css
body color: #ffffff

background overlay (body::before): rgba(0, 0, 0, 0.75)

aside background-color: #1e293b

aside h2: #f8fafc

table background-color: rgba(255, 255, 255, 0.08)

th, td border: rgba(255, 255, 255, 0.25)

th background-color: rgba(37, 99, 235, 0.6)

```
## v2
```css
body color: #1e293b

background overlay (body::before): rgba(255, 255, 255, 0.7)

aside background: #f1f5f9

aside h2: #0f172a

table background-color: rgba(0, 0, 0, 0.04)

th, td border: rgba(0, 0, 0, 0.15)

th background-color: rgba(59, 130, 246, 0.7)
```