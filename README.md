# git

## 1 Welcome to Git
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
* master
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

## 2. Basic Branching and Merging

Comme nous ne travailons jamais sur la branche master (main) sur Git, la première chose à faire est d'apprendre à créer une branche :

```bash
$ git checkout -b dev
$ git branch -a
* dev
  master
  remotes/origin/master
```

La commande `checkout -b` nous a non seulement créé une nouvelle branche, mais nous sommes également directement dessus.

Apportons maintenant quelques modifications à notre code :

```bash
$ echo -e "\nHello, world\n" >> README.md
$ git commit -a -m "second commit"
[dev 4c2b9cf] second commit
 1 file changed, 3 insertions(+)
$ git status
On branch dev
nothing to commit, working tree clean
```

Une fois que notre travail est achevé sur cette branche, il est temps de faire un merge avec la branche master :

```bash
$ git checkout master
Switched to branch 'master'
$ git merge dev
Updating 0245f07..2783feb
Fast-forward
 README.md | 3 +++
 1 file changed, 3 insertions(+)
```

Généralement, à ce stade, vous voulaiez également supprimer la branche sur laquelle vous avez travaillé :

```bash
$ git branch -d dev
Deleted branch dev (was 2783feb).
```

## 3. Faites le vous-même !

It's time to jump in without a net and give it a try!

1. Create a new "test" branch
1. Edit a few lines of the README file (or if you are an adventurer you could even create a new file!)
1. Save the changes in the "test" branch
1. Then go back to the master branch and merge your branch
1. Don't forget to delete it ;-)

## 4. Conflicts

Testons maintenant le scénario suivant : un cherchant à régler deux problèmes différents, votre collègue et vous modifier par inadvertance une partie commune du code.

```bash
$ git checkout -b issue14
Switched to a new branch 'issue14'
$ echo "## How I did it by Jack the Ripper" >> README.md 
$ git commit -a -m "resolution issue 14"
[issue14 cda6569] resolution issue 14
 1 file changed, 1 insertion(+)
$ git checkout master
Switched to branch 'master'
$ git checkout -b issue15
Switched to a new branch 'issue15'
$ echo "## Shit happens" >> README.md 
$ git commit -a -m "resolution issue 15"
[issue15 67eb066] resolution issue 15
 1 file changed, 1 insertion(+)
$ git checkout master
Switched to branch 'master'
$ git merge issue14
Updating 2783feb..cda6569
Fast-forward
 README.md | 1 +
 1 file changed, 1 insertion(+)
$ git merge issue15
Auto-merging README.md
CONFLICT (content): Merge conflict in README.md
Automatic merge failed; fix conflicts and then commit the result.
```

Oups, il n'est pas possible de faire un merge de la branche issue15, car elle rentre en conflit avec la branche issue14 que nous avons merge un peu plus tôt.

```bash
$ git status
On branch master
You have unmerged paths.
  (fix conflicts and run "git commit")
  (use "git merge --abort" to abort the merge)

Unmerged paths:
  (use "git add <file>..." to mark resolution)

        both modified:   README.md

no changes added to commit (use "git add" and/or "git commit -a")
```

Comment faire ?

Git adds standard conflict-resolution markers to the files that have conflicts, so you can open them manually and resolve those conflicts :

```bash
$ nano README.md
# My Awesome Project

Hello, world

<<<<<<< HEAD
## How I did it by Jack the Ripper
=======
## Shit happens
>>>>>>> issue15
```

```bash
# My Awesome Project

Hello, world

## How I did it by Jack the Ripper

## Shit happens
```

This is just an example, and there are different ways to resolve a conflict:

- Accept current change
- Accept incoming change
- Accept both changes (this is our option)

Once we fix the conflict in the file, we can resolve it in Git :

```bash
$ git add README.md 
$ git commit -m "conflict resolved"
[master 2088752] conflict resolved
$ git status
On branch master
nothing to commit, working tree clean
$ git push origin master
Enumerating objects: 14, done.
Counting objects: 100% (14/14), done.
Delta compression using up to 2 threads
Compressing objects: 100% (7/7), done.
Writing objects: 100% (12/12), 1.06 KiB | 542.00 KiB/s, done.
Total 12 (delta 1), reused 0 (delta 0)
To localhost:/srv/git/demo.git
   0245f07..2088752  master -> master
$ git branch -d issue14
Deleted branch issue14 (was cda6569).
$ git branch -d issue15
Deleted branch issue15 (was 67eb066).
```

Faites attention, vous pourriez recevoir un diplôme en gestion de conflits ;-)

## 5. 
