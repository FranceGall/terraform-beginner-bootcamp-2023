# Week 2
![image](https://github.com/FranceGall/terraform-beginner-bootcamp-2023/assets/35935505/f479c917-aa87-465e-999a-a1615a9c2c5f)

## Web Servers

Use **Sinatra** for lightweight web server and **Rails** for a heavy duty web server.

Golang Binary will be used for CRUD and call the Provider and Resource in Main.tf.
It will initiate JSON payloads to call corresponding APIs (Create, Read, Update, Delete)
APIs will then be executed in the web servers.

## Clone Repository 
Clone Mock server repository using SSH from GitHub into local GitPod
[Mock Server](https://github.com/ExamProCo/terratowns_mock_server.git)

```sh
git clone https://github.com/ExamProCo/terratowns_mock_server.git
```

Then delete `.git` file created automatically...
Change directory:
```
cd terratowns_mock_server/
```
List all files in directory:
```
ls -la
```
Then remove the `.git` directory:
RM - remove, RF - remove force
```
rm -rf .git
```

