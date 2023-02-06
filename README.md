# Drupal meets Monk

This repository contains Monk.io template to deploy Drupal system either locally or on cloud of your choice (AWS, GCP, Azure, Digital Ocean).

- [Drupal meets Monk](#drupal-meets-monk)
  - [Prerequisites](#prerequisites)
    - [Make sure monkd is running.](#make-sure-monkd-is-running)
    - [Clone Repository](#clone-repository)
    - [Load Template](#load-template)
    - [Verify if it's loaded correctly](#verify-if-its-loaded-correctly)
    - [Deploy Drupal](#deploy-drupal)
    - [Notice](#notice)
  - [Variables](#variables)
  - [Stop, remove and clean up workloads and templates](#stop-remove-and-clean-up-workloads-and-templates)

## Prerequisites

- [Install Monk](https://docs.monk.io/docs/get-monk)
- [Register and Login Monk](https://docs.monk.io/docs/acc-and-auth)
- [Add Cloud Provider](https://docs.monk.io/docs/cloud-provider)
- [Add Instance](https://docs.monk.io/docs/multi-cloud)

### Make sure monkd is running.

```bash
foo@bar:~$ monk status
daemon: ready
auth: logged in
not connected to cluster
```

### Clone Repository

```bash
git clone git@github.com:CuteAnonymousPanda/monk-drupal.git
```

### Load Template

```bash
cd monk-drupal
✔ Read files successfully
✔ Loaded manifest.yaml successfully

Loaded 2 runnables, 1 process groups, 0 services, 0 entities and 0 entity instances
✨ Loaded:
 ├─🔩 Runnables:
 │  ├─🧩 drupal/db
 │  └─🧩 drupal/server
 └─🔗 Process groups:
    └─🧩 drupal/stack
✔ All templates loaded successfully
```

### Verify if it's loaded correctly

```bash
$ monk list drupal
✔ Got the list
Type      Template       Repository  Version  Tags
runnable  drupal/db      local       -        -
runnable  drupal/server  local       -        -
group     drupal/stack   local       -        -
```

### Deploy Drupal

```bash
$ monk run drupal/stack
✔ Starting the job: local/drupal/stack... DONE
✔ Preparing nodes DONE
✔ Checking/pulling images...
✔ [================================================] 100% drupal:10-apache-bullseye local
✔ Checking/pulling images DONE
✔ Starting containers DONE
✔ New container 4bac2c06234d2461bf3251ede1baa29c-local-drupal-db-mariadb created DONE
✔ New container 5b5de5ef8868182c7bc37f9a49b887e7-local-drupal-server-drupal created DONE
✔ Started local/drupal/stack

🔩 templates/local/drupal/stack
 └─🧊 Peer local
    ├─🔩 templates/local/drupal/server
    │  └─📦 5b5de5ef8868182c7bc37f9a49b887e7-local-drupal-server-drupal running
    │     ├─🧩 drupal:10-apache-bullseye
    │     └─🔌 open 1.1.1.1:80 -> 80
    └─🔩 templates/local/drupal/db
       └─📦 4bac2c06234d2461bf3251ede1baa29c-local-drupal-db-mariadb running
          ├─🧩 mariadb:10.5
          └─💾 /var/lib/monkd/volumes/drupal/mysql -> /var/lib/mysql

💡 You can inspect and manage your above stack with these commands:
        monk logs (-f) local/drupal/stack - Inspect logs
        monk shell     local/drupal/stack - Connect to the container's shell
        monk do        local/drupal/stack/action_name - Run defined action (if exists)
💡 Check monk help for more!
```

### Notice

During Drupal installation you need to specify drupal database password, even though it is set in variables.

## Variables

The variables are stored in `manifest.yaml` file.
You can quickly setup by editing the values there.

| Variable | Description                   | Default |
| -------- | ----------------------------- | ------- |
| db-name  | Your Drupal database name     | drupal  |
| db-user  | Your Drupal database username | drupal  |
| db-pass  | Your Drupal database password | drupal  |

## Stop, remove and clean up workloads and templates

```bash
monk purge    drupal/stack
monk purge -x drupal/stack
```
