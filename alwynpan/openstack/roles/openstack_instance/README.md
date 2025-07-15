OpenStack Instance Role
======================

This role creates and manages OpenStack instances with configurable flavors, images, networks, and volumes. It supports creating multiple instances and automatically adds them to Ansible inventory.

Requirements
------------

- Ansible 2.9+
- Python 3.6+
- OpenStack cloud credentials
- openstack.cloud collection
- community.general collection

Role Variables
-------------

- `cloud`: OpenStack cloud name
- `project_name`: OpenStack project name
- `availability_zone`: OpenStack availability zone
- `instances`: List of instance configurations
- `host_group`: Ansible host group name for created instances

Dependencies
------------

- alwynpan.openstack.openstack_common
- alwynpan.openstack.openstack_network
- alwynpan.openstack.openstack_volume

Example Playbook
----------------

```yaml
- hosts: localhost
  vars:
    cloud: mycloud
    project_name: myproject
    availability_zone: my-zone
    host_group: openstack_instances
    instances:
      - name: web-server-1
        flavor: m1.small
        image: my-image-id
        key_name: my-key
        networks:
          - network: private-network
        security_groups:
          - default
          - web
        volumes:
          - vol_name_prefix: data
            device: /dev/vdb
  roles:
    - alwynpan.openstack.openstack_instance
```

License
-------

MIT

Author Information
------------------

Alwyn Pan <geminean@msn.com>
