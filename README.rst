Prerequisities
==============
* RHEL or CentOS.
* yum repository with openstack essex and diablo. Check that you have
  exactly one up-to-date repo.
* python 2.6.
* main-node as a hostname for the main node (set it in /etc/hosts).
* `DB_ROOT_PWD` environment variable that contains root password for
  mysql, `DB_USER` as OpenStack mysql user and `DB_PWD` as its password
  (if not set, these variables default to `nova`).


Diablo installation guide
=========================

WARNING: existing databases will be overwritten!

Place sql scripts to a directory and give its name to the script:

::
    openstack-pkg install_full diablo


Migrate from diablo to essex
============================

Execute:

::
    openstack-pkg migrate


Verify openstack installation
=============================

Check daemon status:

::
    openstack-daemons status


Setup credential environment variables and list VMs and images:

::
    nova list
    nova image-list

Try to start an instance.

::
    nova boot --flavor 2 --image <image-id> test-instance


Commands
========

openstack-pkg
-------------

install (diablo|essex) [-y]
    Install requested release.

erase
    Erase OpenStack rpm packages.

purge
    DANGEROUS!!! It will remove glance images and instance data!
    Erase all OpenStack files.


openstack-etc
-------------

setup
    Updates configuration files (sets database urls etc.).

purge
    Delete configuration files.

keystone_db
    Save in keystone database admin token or password that are stored
    in configuration files.

openstack-db
------------

Optionally, a list of databases can be specified. By default, script
operates on all databases.

populate <directory> [databases]
    DANGEROUS!!! All existing databases will be overwritten!
    Populates database with scripts from the given directory.
    Scripts are executed in althabetical order. You can name the
    scripts nova-0.sql, nova-1.sql, etc. for convenience.

migrate [databases]
    Migrate the databases. nova and glance will be updated, keystone
    moved to keystoneold and rewritten. nova migration usually takes
    long time (minutes).


openstack-daemons
-----------------

Optional "all" suboption propagates script's action not only to OpenStack
daemons, but also to libvirtd, rabbitmq, and massagebus.

start [all]
    Start daemons.

stopt [all]
    Stop daemons.

restart [all]
    Restart daemons.

status [all]
    Get daemons status.
