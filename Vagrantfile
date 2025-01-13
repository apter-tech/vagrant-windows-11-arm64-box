# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "pipegz/Windows11ARM"
  config.vm.box_version = "1.0.1"
  config.vm.guest = :windows
  config.vm.communicator = "winrm"
  config.vm.provider :vmware_desktop do |vmware|
    vmware.vmx["ethernet0.pcislotnumber"] = "160"
    vmware.vmx["ethernet0.virtualdev"] = "vmxnet3"
  end
  config.vm.provision :shell, :path => "auto_login.ps1", :privileged => false

  config.vagrant.plugins = [ "vagrant-vmware-desktop" ]
end
