aws-micro-swap Cookbook
=======================
This cookbook sets up and enables a swap on micro EC2 instances.

Requirements
------------
Requires that the node be an EC2 instance of micro size. The recipe checks for this to be an EC2 node, and that the instance type is a micro type. Otherwise, nothing will execute.

Usage
-----
#### aws-micro-swap::default
Just include `aws-micro-swap` in your node's `run_list`:

```json
{
  "name": "my_node",
  "run_list": [
    "recipe[aws-micro-swap]"
  ]
}
```

Authors
-------------------
Authors: Jeff Byrnes <thejeffbyrnes@gmail.com>
