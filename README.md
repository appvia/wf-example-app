# wf-example-app

An example app to demonstrate using Wayfinder for ephemeral PR previews and deploying to a 
long-lived environment on merge.

The main branch of this repository deploys to https://ui-prod-wfexam9lvp.demo.wayfinder.run/

## Using the example

### 1. Create the app in Wayfinder

Create an application in your workspace in Wayfinder. To get going quickly, edit the manifests in
the app folder, then apply to your workspace:

```
wf use workspace wsp1
wf apply -f ./app
```

### 2. Create an access token to permit GitHub access to your workspace

Create an access token in your workspace and add as a GitHub secret for your repository:
```
wf create workspaceaccesstoken wf-example-app-ghactions --show-token | gh secret set WAYFINDER_TOKEN -R appvia/wf-example-app -a actions
```

### 3. Create a cluster to host your PR previews and live environments

If you don't already have a cluster in your workspace that you wish to use, create a cluster 
choosing an appropriate plan.

Note the name of the cluster, we'll need it below.

### 4. Permission the access token to use this cluster

* Add workspace.appdeployer and workspace.appmanager roles - this allows the token to create 
  ephemeral environments and deploy to them.
* Add cluster.deployment on the cluster you wish to host the PR preview environments. This allows 
  the token to deploy to any environment on the PR preview cluster.
* Add namespace.deployment on the cluster namespace you wish to host the long-lived 'prod' 
  environment (not needed if using the same cluster as above)
* Add cluster.deployment.readonly on the cluster you wish to host the long-lived 'prod' environment 
  (not needed if using the same cluster as above)

### 5. Configure supporting variables in GitHub for the workflows:

Adjusting as needed for your application, create variables for the workflow:
```
gh variable set WAYFINDER_WORKSPACE -r appvia/wf-example-app --body ws1
gh variable set WAYFINDER_SERVER -r appvia/wf-example-app --body https://api-wayfinder.myorg.io
gh variable set APP_NAME -r appvia/wf-example-app --body wfexampleapp
gh variable set APP_COMPONENT_NAME -r appvia/wf-example-app --body ui
gh variable set PR_PREVIEW_CLUSTER -r appvia/wf-example-app --body demo-envs
gh variable set LIVE_ENV_NAME -r appvia/wf-example-app --body prod
```
