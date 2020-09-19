# Sync a entire repository to another repo like subdir

This action sync a repository when pushed changes to another repository, like subdir.

## Why?

I have a Repo with HTML slides and I pushed changes frequently. I also have a second repository which is also a Github Page. This action publish my commits of the first repo in the second one. In the target repository, the source will be copied like sub directory.

## Arguments and variables

There are 3 required arguments:

 * `##username/repository_name##`: Target repository name (not url). Show [actions/checkout](https://github.com/actions/checkout#checkout-multiple-repos-side-by-side) documentation.
 * `##commit_github_username##`: User to show like Author in Github Commit
 * `##subdir_name_on_target##`: Name of directory on Target Repository

 You have to define the secret `API_TOKEN_GITHUB` in the source repo secrets section. You have define a Token [here](https://github.com/settings/tokens) (set the `repo` permission).

## Usage

Create an action file `.github/workflows/action-sync-repos.yml` in your source repo (where do you want to commit) with the next code:

```yaml
on: [push]

jobs:
  sync-with-gh-page:
    runs-on: ubuntu-latest
    name: Sync this repo with GH pages
    steps:
    - name: Checkout source repository
      uses: actions/checkout@v2
      with:
        path: source-repo
    - name: Checkout target repository
      uses: actions/checkout@v2
      with:
        repository: ##username/repository_name##
        path: target-repo
        token: ${{ secrets.API_TOKEN_GITHUB }}
    - name: Sync the repo
      id: sync
      uses: tomasdelvechio/actions-push-repo-to-subdir@v1.2.0
      with:
        github-username: ##commit_github_username##
        target-subdir-name: ##subdir_name_on_target##
```

## Examples

### Sync a repository to github page

The action file content:

```yaml
on: [push]

jobs:
  sync-with-gh-page:
    runs-on: ubuntu-latest
    name: Sync this repo with GH pages
    steps:
    - uses: actions/checkout@v2
      with:
        path: source-repo
    - uses: actions/checkout@v2
      with:
        repository: pawunlu/pawunlu.github.io
        path: target-repo
        token: ${{ secrets.API_TOKEN_GITHUB }}
    - name: Sync the repo
      id: sync
      uses:  tomasdelvechio/actions-push-repo-to-subdir@v1.2.0
      with:
        github-username: 'tomasdelvechio'
        target-subdir-name: 'slides'
```

 * **Target Repo**: `pawunlu/pawunlu.github.io` (A Github page repo)
 * **Github Username**: `tomasdelvechio` (Commit's author)
 * **Subdir name**: `slides` (You have this directory on [the repository](https://github.com/pawunlu/pawunlu.github.io))

 This file is created in the source repository. Example name: `.github/workflows/action-sync-repos.yml`.