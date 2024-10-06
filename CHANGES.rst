Changelog
=========


1.1.1 (2024-10-06)
------------------

Fixes
~~~~~
- Update default release config to pick up new: tag. [Stephen Arnold]

  * set include merges to false


1.1.0 (2024-03-23)
------------------

Changes
~~~~~~~
- Bump versions of gitchangelog and workflow actions. [Steve Arnold]

Fixes
~~~~~
- Make git describe find the right tag with multiple choices. [Steve
  Arnold]

  * this should make sure git can find the right tag regardless of
    tag type or date ordering


1.0.0 (2022-10-31)
------------------

Changes
~~~~~~~
- Update readme, add simple pre-commit config. [Stephen L Arnold]
- Tool/action version upgrades, add tag check to release workflow.
  [Stephen L Arnold]

  * bump versions for gitchangelog and actions/checkout
  * hold release action if tag starts with 'v'


0.2.0 (2022-10-03)
------------------

Changes
~~~~~~~
- Use python:alpine image, bump gitchangelog version to latest. [Stephen
  L Arnold]

  * update docker file for new container usage
- Update tag_regexps in default config, bump dep version. [Stephen L
  Arnold]

  * make sure 'v' tag prefix is recognized
  * install latest gitchangelog using gh wheel url


0.1.4 (2022-09-26)
------------------

Fixes
~~~~~
- Switch pip install to source tarball until pypi deps are fixed.
  [Stephen L Arnold]

  * pystache 0.6.1 has bad version (0.6.0) on both GH and pypi
  * action/Docker env started failing dep installs, and now
  * pip no longer installs from github release page links


0.1.3 (2022-04-15)
------------------

Fixes
~~~~~
- Use latest gitchangelog release wheel, remove extra dep install.
  [Stephen L Arnold]

Other
~~~~~
- Doc: add readme note about using latest tag if not on master. [Stephen
  L Arnold]
- Wrap final command with some useful github variables. [Stephen L
  Arnold]
- Try running suggested git config command => safe.directory. [Stephen L
  Arnold]
- Post-tag commit: update pep8speaks config. [Stephen L Arnold]


0.1.2 (2021-03-02)
------------------

Changes
~~~~~~~
- Still less is even more. [Stephen L Arnold]
- Check changelog output with/without version in env. [Stephen L Arnold]
- Set override version for latest tag. [Stephen L Arnold]
- Add dogfood example repo, update usage a bit. [Stephen L Arnold]
- Filter out refs that are not tags. [Stephen L Arnold]

Fixes
~~~~~
- Use correct flake8 config syntax. [Stephen L Arnold]

Other
~~~~~
- Yet-another-readme-update (less is more) [Stephen L Arnold]
- Fix missing link in readme. [Stephen L Arnold]


0.1.1 (2021-03-01)
------------------

Changes
~~~~~~~
- Upgrade gitchangelog (#4) [Steve Arnold]

  * upgrade to latest gitchangelog and update readme file
  * usr: improve install time using latest wheels


0.1.0 (2021-03-01)
------------------

New
~~~
- Add baseline docker action files (wip) [Stephen L Arnold]

Fixes
~~~~~
- Default config environment var (#3) [Steve Arnold]

  * update shell env and rename default cfg, update workflow/readme
  * use absolute container path for default config file
  * usr: tweak default config for more data/ better output

Other
~~~~~
- Image switch (#1) [Steve Arnold]

  * switch to apline with minimal required deps
  * add release cfg rc file to docker, set/check env vars
  * wire up input options, show output, update readme
  * add no-args option for full changelog, update readme


