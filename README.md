# java-mysql-k8s-helm
This app reads a message from mysql database and displays it through java console application
We used Docker to containerize the application, Kubernetes and Helm to deploy the application and database

## Implementation
As part of this excercise we have covered below items
Creating application as docker image
Used secrets concept to store mysql db password securely
Used persitent volume and persistent volume claim to maintain data persistency
Used config map to execute initdb script which creates db,table and inserts sample data in to it
Exposed database host as cluster-ip service for communication with application
Created Helm charts for both db and app deployments
Parameterised App Helm chart to read docker image name form values.yaml file

## Prerequisites
Docker
Kubernetes cluster
Helm

## Steps to build Docker image and Deploy it through Helm/Kubernetes
### Cloning application code and deployment config files
Clone this repository to local
```
git clone https://github.com/pavaraj29/java-mysql-k8s-helm
```
### Choosing root password of mysql database and updating it in secrets file and application code
Choose a root password for mysql database and encrypt it
```
echo -n "your password here" | base64
```
Copy the encrypted value and update in file in helm-chart/helloworlddb/secrets.yaml to mysql-root-password field
Also update the plain password in helloworld.java file to static final String PASS = line
### Building and pushing docker image to docker registry
Now create Docker image and push it to registry with below commands from root directory of git repo
```
docker run -t <provide your repository name>/<provide your imagename> .
docker push <provide your repository name>/<provide your imagename>
```
### Updating image name in values.yaml file of application helm chart
Open helm-chart/helloworldapp/templates/values.yaml and provide docker image name under image->repository
### Performing deployment through Helm
<If you want to execute deployment with default values you can skip all above steps except cloning application code and deployment config files>
Make sure you have helm installed and initialized tiller pod by executing "helm init" command
Go to helm-chart folder and execute below commands
  
#### Installing DB chart
```
helm install helloworlddb
```
#### Installing App chart
```
helm install helloworldapp
```
The first command will create a secret, creates persistent volume and a mysql db
Also we are creating database, table and inserting sample data through config map as part of db deployment
The second helm command is to deploy application with latest docker image that we have provided in values.yaml file
  
### Testing the deployment
As the application we are using is a console application we have to check pod logs to test whether we are getting data from db to app
Execute below commands to do the same
```
kubectl get po
```
copy the pod name of helloworldapp pod
```
kubectl logs <pod name of helloworldapp>
```
There you should see a message like "welcome to demo" that we provided in database, this message can be changed in deployment.yaml of db helm chart
