Overview
========

This is the Chef repository for the FAIMS (http://www.fedarch.org) NeCTAR deployment. 

It is built on a clone of the original Opscode chef-repo skeleton. So to quote:
"This is the place where cookbooks, roles, config files and other artifacts ... will live."

In order to build a machine up from scratch, install the Opscode OpenStack plug in for Knife: <https://github.com/opscode/knife-openstack>
If the following fixes haven't been performed on the latest version of the Knife plugin <https://github.com/jkburges/knife-openstack/commit/4ea2072dcbce4ccb74d6a16a14adcbed9f5007fe> then you'll have to apply them to run against the NeCTAR cloud.

Then once the recipies have been uploaded to the chef server, the following commands are of interest:

    admin$ knife openstack server create -f 0 -I 964d2451-6727-4663-8d8e-d18a2f04b62c -N database -S KeyName -G PostgreSQL -i path/to/key --network-id queensberry -r 'recipe[postgresql]'

to set up a raw postgress server.
