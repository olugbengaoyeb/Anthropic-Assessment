Here is a **clean, complete, and interview-ready README**, finished in a professional and human tone while staying concise and clear.

---

# AWS Resource Cleanup Script (Bash)

## Overview

This script identifies and removes unused AWS resources to help reduce cloud costs and operational clutter. It currently targets:

* Stopped EC2 instances
* Unattached (available) EBS volumes

The script is safe by default, supports dry-run execution, includes structured logging, and is configurable via a config file or command-line arguments.

---

## Requirements

* Bash 4+
* AWS CLI v2
* AWS credentials configured via environment variables, AWS config file, or IAM role
* IAM permissions:

  * `ec2:DescribeInstances`
  * `ec2:TerminateInstances`
  * `ec2:DescribeVolumes`
  * `ec2:DeleteVolume`

---

## Usage

### Dry-run (default)

Lists resources that would be deleted without making changes:

```bash
./cleanup.sh -r us-east-1
```

### Perform actual deletion

Executes cleanup by terminating instances and deleting volumes:

```bash
./cleanup.sh -r us-east-1 -n
```

### Use a custom configuration file

```bash
./cleanup.sh -c config.conf -r us-east-1
```

### Optional flags

* `-r` AWS region (required)
* `-n` Disable dry-run mode
* `-c` Path to config file
* `-d` Threshold in days for unused resources

---

## Configuration

The script can be configured using `config.conf`:

```bash
REGION="us-east-1"
DAYS_UNUSED=30
```

Command-line arguments take precedence over config file values.

---

## Logging

Execution logs are written to:

```
logs/cleanup.log
```

Logs include timestamps, resource identifiers, and actions taken or skipped.

---

## Safety and Error Handling

* Dry-run mode is enabled by default
* Script exits on errors using strict Bash options
* Resources are logged before any deletion occurs

---

## Assumptions

* Stopped EC2 instances are safe to terminate
* Unattached EBS volumes are unused
* The script is run by an operator with appropriate AWS permissions
* No protected resources are excluded by tags (can be extended if needed)

---

## Testing

Basic integration tests are provided using Bats:

```bash
bats tests/
```

---

## Time Spent

* Script design and implementation: ~1 hour
* Testing and validation: ~30 minutes
* Documentation: ~30 minutes
* Total: ~2 hours

---

