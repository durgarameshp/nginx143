apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    run: nginx
  name: nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      run: nginx
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        run: nginx
    spec:
      volumes:
      - name: logs
        emptyDir: {}
      containers:
      - image: nginx
        name: nginx
        resources: {}
        volumeMounts:
          - name: logs
            mountPath: /var/log/access.log
      - image: busybox
        name: sidecar
        command: ["/bin/sh","-c","tail -f /var/log/sidecar/access.log"]
        volumeMounts:
        - name: logs
          mountPath: /var/log/
