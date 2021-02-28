A Github Action for gitchangelog
================================

.. image:: https://socialify.git.ci/sarnold/gitchangelog-action/image?description=1&font=Raleway&issues=1&language=1&owner=1&pulls=1&stargazers=1&theme=Light
   :alt: gitchangelog-action

.. image:: https://github.com/sarnold/gitchangelog-action/actions/workflows/main.yml/badge.svg
    :target: https://github.com/sarnold/gitchangelog-action/actions/workflows/main.yml
    :alt: CI test status

.. image:: https://img.shields.io/github/v/tag/sarnold/gitchangelog-action?color=green&include_prereleases&label=latest%20release
    :target: https://github.com/sarnold/gitchangelog-action/releases
    :alt: GitHub tag

.. image:: https://img.shields.io/github/license/sarnold/gitchangelog-action
    :target: https://github.com/sarnold/gitchangelog-action/blob/master/LICENSE
    :alt: License


What is gitchangelog?
=====================
 
gitchangelog_ creates a changelog from git log history using multiple
template engines and a config file. Output can be either `reStructuredText`_
or `MarkDown`_, with the latter format as default for this action (mainly
for generating GitHub release pages).

What you can do with gitchangelog-action:

* generate a nicely-formatted/configurable github release document to
  use with something like `softprops/action-gh-release`_
* generate a full changelog during any workflow (capture as a workflow
  or release artifact)
* use a custom ``gitchangelog.rc`` file from your source repo

By default this action will use the same ``gitchangelog.rc.github.release``
config file installed by the gitchangelog package.  The full option list
is shown below.


.. _reStructuredText: https://docutils.sourceforge.io/rst.html
.. _MarkDown: https://www.markdownguide.org/
.. _softprops/action-gh-release: https://github.com/softprops/action-gh-release


Usage
=====

Create a .yml file under .github/workflows with the following contents.

Default configuration
---------------------

::

    name: gitchangelog
    on: [push]

    jobs:
      release:
        name: gitchangelog-action
        runs-on: ubuntu-latest
        steps:
          - uses: actions/checkout@v2
            with:
              fetch-depth: 0

          - name: gitchangelog action step
            uses: sarnold/gitchangelog-action@master
            with:
              github_token: ${{ secrets.GITHUB_TOKEN}}


Full configuration
------------------

::

    name: gitchangelog
    on:
      push:
        # trigger a release on any tag push
        tags:
          - '*'

    jobs:
      build:
        # build stuff here to create release artifacts if needed

      release:
        name: gitchangelog with gh-release action
        runs-on: ubuntu-latest
        steps:
          - name: Get version
            id: get_version
            run: |
              echo "VERSION=${GITHUB_REF/refs\/tags\//}" >> $GITHUB_ENV
              echo ${{ VERSION }}

          - uses: actions/checkout@v2
            with:
              fetch-depth: 0

          - name: Generate changes file
            uses: sarnold/gitchangelog-action@master
            with:
              github_token: ${{ secrets.GITHUB_TOKEN}}

          - name: Create release
            uses: softprops/action-gh-release@v1
            env:
              GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
            with:
              tag_name: ${{ env.VERSION }}
              name: Release ${{ env.VERSION }}
              body_path: CHANGES.md
              draft: true
              prerelease: false


Input Options
-------------

.. note:: All input options are optional *except* ``github_token``. By
          default, the ``commit_changelog`` option uses ``--dry-run`` so
          you can see what it *would* do before you actually enable it.


:github_token: GITHUB_TOKEN secret (automatically provided by Github)
:config_file: Path to gitchangelog.rc (default: Markdown release cfg)
:output_file: Filename for changelog (default: CHANGES.md)
:extra_sort: Additionally sort the list of found tags (default: False)
:no_args: Pass no ref args to gitchangelog (always generate full changelog)

The following options are not yet implemented:

:commit_changelog: Whether to commit the changelog file (default: false)
:target_branch: Branch that the action will target (default: current branch)


Output Constraints
------------------

* If you need to generate changelogs outside the github release context,
  the workaround for now is using `actions/upload-artifact`_.


Please refer to the gitchangelog_ readme document for further details.

.. note:: gitchangelog works best if you use the "tags" it knows about
          in your commit messages.  If you already use your own commit
          tags/markers, you can edit (or provide) your own config file.
          See the comments in `gitchangelog-release.rc`_ for a brief
          description of how the tags work, and the above readme for an
          example.


.. _actions/upload-artifact: https://github.com/actions/upload-artifact
.. _gitchangelog: https://github.com/sarnold/gitchangelog


Operating System Support
------------------------

This action runs in a Docker container and requires the Ubuntu_ CI runner.
In your workflow job configuration, you should set the ``runs-on``
property to ``ubuntu-latest``::

    jobs:
      release:
        runs-on: ubuntu-latest

The ``gitchangelog`` tool itself is built and tested in github CI using
Linux, Macos, and Windows, so you can always generate output on your local
machine as needed.


.. _Ubuntu: https://ubuntu.com/

