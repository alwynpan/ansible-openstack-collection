# Ansible Collection - alwynpan.openstack

This Ansible collection provides roles and automation for managing OpenStack infrastructure on NeCTAR/MRC, including instances, networks, and volumes. It is designed to help you quickly provision and manage OpenStack resources using best practices.

## Features

- Create and manage OpenStack instances (servers)
- Create and manage OpenStack networks, subnets, and routers
- Create and manage OpenStack block storage volumes
- Common setup and dependency management for OpenStack automation

## Installation

Install from Ansible Galaxy:

```bash
ansible-galaxy collection install alwynpan.openstack
```

## Requirements

- Ansible 2.9+
- Python 3.6+
- OpenStack cloud credentials
- openstack.cloud collection
- community.general collection

## Roles Included

- **openstack_common**: Sets up local environment and dependencies
- **openstack_network**: Creates networks, subnets, and routers
- **openstack_volume**: Manages block storage volumes
- **openstack_instance**: Provisions and manages OpenStack instances

## Example Usage

```yaml
- hosts: localhost
  vars:
    cloud: mycloud
    project_name: myproject
    availability_zone: my-zone
    host_group: openstack_instances
    networks:
      - network_name: my-net
        subnets:
          - name: my-subnet
            cidr: 192.168.10.0/24
            gateway_ip: 192.168.10.1
    volumes:
      - name: data-volume-1
        size: 10
        description: Data volume for app
        state: present
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
    - alwynpan.openstack.openstack_common
    - alwynpan.openstack.openstack_network
    - alwynpan.openstack.openstack_volume
    - alwynpan.openstack.openstack_instance
```

## Contributing

Contributions are welcome! Please open issues or submit pull requests on [GitHub](https://github.com/alwynpan/ansible-openstack-collection).

## License

MIT

## Author

Alwyn Pan <geminean@msn.com>
