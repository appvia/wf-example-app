# wf-example-app
An example app to demonstrate using Wayfinder for PR previews and deployment

To use this example, generate an access token in your workspace and add as a secret:

```
wf use workspace ws1
wf create workspaceaccesstoken wf-example-app-ghactions --reset-token --show-token | gh secret set WAYFINDER_TOKEN -R appvia/wf-example-app -a actions
```

Permission the token:
* Add cluster.deployment on an existing cluster to host the PR environments (e.g. demo-envs) - note the name of the cluster
* Add workspace.appdeployer and workspace.appmanager roles

Configure other variables, adjust the values as appropriate for your app, environment, and PR preview cluster:
```
gh variable set WAYFINDER_WORKSPACE -r appvia/wf-example-app --body ws1
gh variable set WAYFINDER_SERVER -r appvia/wf-example-app --body https://api-wayfinder.myorg.io
gh variable set APP_NAME -r appvia/wf-example-app --body wfexampleapp
gh variable set APP_COMPONENT_NAME -r appvia/wf-example-app --body ui
gh variable set PR_PREVIEW_CLUSTER -r appvia/wf-example-app --body demo-envs
gh variable set LIVE_ENV_NAME -r appvia/wf-example-app --body prod
```