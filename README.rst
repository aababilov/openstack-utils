Prerequisities
--------------
* RHEL or CentOS
* yum repository with openstack essex and diablo. Check that you have
  exactly one up-to-date repo.
* python 2.6


Diablo installation guide
-------------------------

We assume that no openstack is installed.

Place sql scripts to a directory, populate the databases
(all will reside in mysql), and update configuration files.

WARNING: existing  databases will be overwritten!

::
    openstack-pkg install diablo
    openstack-etc setup
    openstack-db populate <path-to-dir>

For each service (nova, glance, keystone), openstack-db will execute
(in althabetical order) scripts from the given directory that start
from service's name. You can name the scripts nova-0.sql,
nova-1.sql, etc. to control execution order.

Now proceed to Configure Keystone.


Migrate from diablo to essex
----------------------------

Stop openstack daemons, erase packages, and purge etc:

::
    openstack-daemons stop
    openstack-pkg erase
    openstack-etc purge

Install essex and setup it:

::
    openstack-pkg install essex
    openstack-etc setup

Migrate the databases. nova and glance will be updated, keystone moved
to keystoneold and rewritten. nova migration usually takes long time (minutes).

::
    openstack-db migrate

Now proceed to Configure Keystone.


Configure Keystone
------------------

A new admin token or password are generated and stored in
configuration files. Save it in keystone database:

::
    openstack-etc keystone_db

Now start openstack and other necessary daemons:

::
    openstack-daemons start all


Verify openstack installation
-----------------------------

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
