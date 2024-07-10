# Git Rebase

A GitHub Action for branch rebasing in independent repository using **force push**.

## Features

- Rebase branches on a GitHub repository
- Rebase branches on a remote repository
- GitHub action can be triggered on a timer or on push or manually

## Usage

> Always make a full backup of your repo (`git clone --mirror`) before using this action.

### GitHub Actions

```yml
# .github/workflows/git-rebase.yml

on: push
jobs:
  git-rebase:
    runs-on: ubuntu-latest
    steps:
      - name: git-rebase
        uses: tiacsys/git-rebase@v1
        with:
          repo: "org/repository"
          source_branch: "next"
          destination_branch: "main"
          ssh_private_key: ${{ secrets.SSH_PRIVATE_KEY }} # optional
```

##### Using shorthand

You can use GitHub repo shorthand like `username/repository`.

##### Using ssh

> The `ssh_private_key` must be supplied if using ssh clone urls.

```yml
repo: "git@github.com:username/repository.git"
```
or
```yml
repo: "git@gitlab.com:username/repository.git"
```

##### Using https

> The `ssh_private_key` can be omitted if using authenticated https urls.

```yml
repo: "https://username:personal_access_token@github.com/username/repository.git"
```

#### Set up deploy keys

> You only need to set up deploy keys if repository is private and ssh clone url is used.

- Generate ssh key for the repository, leave passphrase empty (note that GitHub deploy keys must be unique for a repository)

```sh
$ ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

- In GitHub, either:

  - add the unique public keys (`key_name.pub`) to _Repo Settings > Deploy keys_ for each repository respectively and allow write access for the destination repository

  or

  - add the single public key (`key_name.pub`) to _Personal Settings > SSH keys_

- Add the private key(s) to _Repo > Settings > Secrets_ for the repository containing the action (`SSH_PRIVATE_KEY`)

### Docker

```sh
$ docker run --rm -e "SSH_PRIVATE_KEY=$(cat ~/.ssh/id_rsa)" $(docker build -q .) \
  $SOURCE_REPO $SOURCE_BRANCH $DESTINATION_REPO $DESTINATION_BRANCH
```

## Author

[TiaC Systems](https://tiac-systems.net/) _info@tiac-systems.net_

## License

[MIT](LICENSE)
