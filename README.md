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

Since we never work on the master (main) branch on Git, the first thing to do is learn how to create a branch:

```bash
$ git checkout -b dev
$ git branch -a
* dev
  master
  remotes/origin/master
```

The `checkout -b` command not only created a new branch for us, but we are also directly on it.

Now let's make some changes to our code:

```bash
$ echo -e "\nHello, world\n" >> README.md
$ git commit -a -m "second commit"
[dev 4c2b9cf] second commit
 1 file changed, 3 insertions(+)
$ git status
On branch dev
nothing to commit, working tree clean
```

Once our work is done on this branch, it's time to merge with the master branch:

```bash
$ git checkout master
Switched to branch 'master'
$ git merge dev
Updating 0245f07..2783feb
Fast-forward
 README.md | 3 +++
 1 file changed, 3 insertions(+)
```

Usually at this point you also wanted to delete the branch you were working on:

```bash
$ git branch -d dev
Deleted branch dev (was 2783feb).
```

## 3. Do it yourself!

It's time to jump in without a net and give it a try!

1. Create a new "test" branch
1. Edit a few lines of the README file (or if you are an adventurer you could even create a new file!)
1. Save the changes in the "test" branch
1. Then go back to the master branch and merge your branch
1. Don't forget to delete it ;-)

## 4. Conflicts

Now let's test the following scenario: One seeking to fix two different problems, your colleague and you inadvertently modify a common part of the code.

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

Oops, it is not possible to merge the issue15 branch, because it conflicts with the issue14 branch that we merged earlier.

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

How to do ?

Git adds standard conflict-resolution markers to the files that have conflicts, so you can open them manually and resolve those conflicts:

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

Be careful, you might get a diploma in conflict management ;-)

## 5. A little exercise?

Run the following command:

```bash
$ curl -sSL https://raw.githubusercontent.com/de13/git/main/scripts/conflicts.sh | sh -
```

You should now have a nice conflict:

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

It's your turn !

## 6. Do and undo is always to work

Here is the scenario: You are working on your code and creating a lot of new files. At the time of the commit, you forgot one!

```bash
$ touch file1 file2
$ git add file1
$ git commit -m "There are new files here!"
[master 58ff1cf] There are new files here!
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 file1
$ git status
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)

        file2

nothing added to commit but untracked files present (use "git add" to track)
```

At this point, it would not be elegant to add with the new file, and make a new commit, because that would make a lot of noise in the history.

Instead, you can use `--amend`:

```bash
$ git add file2
$ git commit --amend
[master 5127811] There are new files here!
 Date: Thu Apr 8 14:06:01 2021 +0000
 2 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 file1
 create mode 100644 file2
```

The file will then be added to your previous commit.

We can also imagine the reverse scenario: you added a file that you didn't want to add.

```bash
$ touch binary_file
$ git add binary_file
$ git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

        new file:   binary_file
```

Don't panic:

```bash
$ git reset HEAD binary_file
$ git status
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)

        binary_file

nothing added to commit but untracked files present (use "git add" to track)
```

And there you have it, the file is no longer staged!

It is also possible not to want to save your modifications, and to wish to return to the previous state of the file:

```bash
$ echo "Oops, I don't want to make this change" >> README.md
$ git status
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   README.md

no changes added to commit (use "git add" and/or "git commit -a")
```

Again, don't worry, this is not the end!

```bash
$ tail -1 README.md 
Oops, I don\'t want to make this change
$ git checkout -- README.md 
$ tail -1 README.md 
Everything looks fine now
```

And that's it for the tour of the commands that will be most useful to you every day. If you want to learn more:

- [Pro Git](https://git-scm.com/book/en/v2): Free online book
- [Learn Git Branching](https://learngitbranching.js.org/): an interactive online tutorial