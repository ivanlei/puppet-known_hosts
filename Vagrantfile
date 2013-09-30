# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |global_config|

  global_config.vm.box = 'ubunutu-srv-x64-12042-vb4216'
  global_config.vm.box_url = '/vms/boxes/ubunutu-srv-x64-12042-vb4216.box'

  vms = {
    'init' => {
      :ip           => '10.8.66.10',
    },
  }

  def bool_to_on_off(val)
    if val
      return 'on'
    else
      return 'off'
    end
  end

  vms.each_pair do |vm_name, vm_settings|
    global_config.vm.define vm_name do |config|

      ###########
      # Params  #
      ###########
      ram           = vm_settings.fetch(:ram,         '2048')
      cpus          = vm_settings.fetch(:cpus,        '2')
      enable_gui    = vm_settings.fetch(:enable_gui,  false)
      enable_usb    = vm_settings.fetch(:enable_usb,  false)
      forward_ssh   = vm_settings.fetch(:forward_ssh, false)
      debug         = vm_settings.fetch(:debug,       false)

      config.ssh.forward_agent  = forward_ssh
      config.vm.hostname        = "#{vm_name}.someorg.com"
      config.vm.network :private_network, ip: vm_settings[:ip]

      ###############
      # VirtualBox  #
      ###############
      config.vm.provider :virtualbox do |vb|
        vb.gui = enable_gui

        # VBoxManager Reference - http://www.virtualbox.org/manual/ch08.html
        vb.customize [
          'modifyvm',     :id,
          '--memory',     ram,
          '--cpus',       cpus,
          '--acpi',       'on',
          '--hwvirtex',   'on',
          '--largepages', 'on',
          '--audio',      'none',
          '--usb',        bool_to_on_off(enable_usb)]

        if enable_gui
          vb.customize [
            'modifyvm',        :id,
            '--vram',          '64',
            '--accelerate3d',  'on']
        end
      end

      ##################
      # VMWare Fusion  #
      ##################
      config.vm.provider :vmware_fusion do |vf|
        vf.gui = enable_gui

        # http://www.sanbarrow.com/vmx.html
        vf.vmx['memsize']       = ram
        vf.vmx['numvcpus']      = cpus
        vf.vmx['usb.present']   = enable_usb
        vf.vmx['sound.present'] = false
        vf.vmx['displayName']   = vm_name
      end

      ###########
      # Puppet  #
      ###########
      config.vm.provision :puppet do |puppet|
        puppet.module_path    = './modules'
        puppet.manifests_path = './tests'
        puppet.manifest_file  = "#{vm_name}.pp"
        if debug
          puppet_debug_options = '--verbose --debug'
        else
          puppet_debug_options = ''
        end
        puppet.options = '--parser future ' + puppet_debug_options
      end
    end
  end
end
