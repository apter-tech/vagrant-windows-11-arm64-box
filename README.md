# Windows 11 ARM64 Vagrant Box

The `apter-tech/windows-11-arm64` Vagrant box provides a pre-configured **Windows 11 ARM64 environment** with **auto-login enabled**. It is based on the `pipegz/Windows11ARM` box and optimized for VMware Desktop. This box is designed for streamlined workflows on ARM-based platforms such as Apple Silicon.

## Features

- **Base Box**: Built on the reliable `pipegz/Windows11ARM` base box.
- **Auto Login**: Automatically logs in as the `vagrant` user for seamless access.
- **VMware Desktop Support**: Fully configured for VMware Desktop with `vmxnet3` networking for better performance.
- **Pre-configured**: Comes with a Vagrantfile for quick setup.

## Requirements

### Software
- [Vagrant](https://www.vagrantup.com/) (latest version)
- [Vagrant VMware Desktop Plugin](https://www.vagrantup.com/docs/providers/vmware)
- [VMware Fusion](https://www.vmware.com/products/fusion.html) (macOS) or [VMware Workstation](https://www.vmware.com/products/workstation-pro.html) (Windows/Linux)

## Usage

1. Initialize the box:

```bash
vagrant init apter-tech/windows-11-arm64 --box-version 1.0.0
```

2. Start the VM:

```bash
vagrant up --provider vmware_desktop
```

This will:
- Download the box (if not already available locally).
- Start the Windows 11 ARM64 VM.

## Configuration

The box is pre-configured for the **VMware Desktop provider**:
- **Networking:** Uses `vmxnet3` for optimized network performance.
- **Auto Login:** Automatically logs into the vagrant user.

To customize the configuration, edit the Vagrantfile generated during initialization.

## Box Details
- **Name:** apter-tech/windows-11-arm64
- **Version:** 1.0.0
- **Provider:** vmware_desktop
- **Base Box:** pipegz/Windows11ARM

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Acknowledgments
Base box: [pipegz/Windows11ARM](https://vagrantcloud.com/pipegz/boxes/Windows11ARM)
Tools: [Vagrant](https://www.vagrantup.com/), [VMware](https://www.vmware.com/)