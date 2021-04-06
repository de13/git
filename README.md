# git

## First steps
We'll start by configuring git:

```bash
$ git config --global user.email "you@example.com"
$ git config --global user.name "Your Name"
```

Then we will create a new project:

```bash
$ mkdir my_project
$ cd my_project
$ git init
```

We will now generate a first content, for example a README file:

```bash
$ echo "# My Awesome Project" > README.md
```

Now let's do our first commit:

```bash
$ git add .
$ git commit -m "first commit"
[master (root-commit) f361cbb] first commit
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 README.md
```

Fanstatic! Now it's time to push this commit to our remote server:

```bash
$ git branch
$ git remote add origin git@localhost:/srv/git/demo.git
$ git push origin master
The authenticity of host 'localhost (::1)' can't be established.
ECDSA key fingerprint is SHA256:GLhXVk0/qQK5avYudAeYM5qn74q1AW1hmzWq3nJLYyA.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'localhost' (ECDSA) to the list of known hosts.
Enumerating objects: 3, done.
Counting objects: 100% (3/3), done.
Writing objects: 100% (3/3), 211 bytes | 211.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0)
To localhost:/srv/git/demo.git
 * [new branch]      master -> master
```

And voilà, here we are!