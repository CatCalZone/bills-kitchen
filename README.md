
Bill's Kitchen
==============

All you (or Bill Gates would) need for cooking with Chef and Vagrant on Windows, shrink-wrapped in a portable package:

 * Main Tools
	* [Ruby](http://rubyinstaller.org/downloads/) 1.9.3 + [DevKit](http://rubyinstaller.org/add-ons/devkit/) 4.5.2
		* [bundler](http://bundler.io/) is the only pre-installed gem, everything else is expected to be managed via project-specific `Gemfile`
 	* [Vagrant](http://vagrantup.com/) 1.3.6
 		* [bindler](https://github.com/fgrehm/bindler) is the only pre-installed vagrant plugin, everything else is expected to be managed via project-specific `plugins.json`
 	* [Omnibus Chef](http://www.getchef.com/chef/install/) 11.10.4
 		* [knife-audit](https://github.com/jbz/knife-audit) and [knife-server](https://github.com/fnichol/knife-server) are exemplary pre-installed knife plugins. Install more via `W:/tools/chef/opscode/chef/embedded/bin/gem install <plugin>`
 * Supporting Tools
 	* [ConEmu](https://code.google.com/p/conemu-maximus5/) - a better windows console with colours, tabs, etc...
 	* [SublimeText2](http://www.sublimetext.com/) - a better editor (trial version, please buy!) with additional packages for [Chef](https://github.com/cabeca/SublimeChef) and [Cucumber](https://github.com/npverni/cucumber-sublime2-bundle) installed
 	* [PortableGit](https://code.google.com/p/msysgit/) - git client for windows (preconfigured with [kdiff3](http://kdiff3.sourceforge.net/) as diff/merge tool)
 	* [putty](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html) - the SSH client for windows
 	* [Cygwin](http://www.cygwin.com/)-based `ssh.exe` and `rsync.exe` to make rsync-based synced folders with Vagrant work on Windows
 * Environmental Changes (all via `W:\set-env.bat`)
 	* Constraining as much as possible to the `W:\` drive:
 		* `%HOME%` points to `W:\home`
 		* `%VAGRANT_HOME%` points to `W:\home\.vagrant.d`
 		* exception: `%VBOX_USER_HOME%` points to `%USERPROFILE%` (i.e. VirtualBox VMs are still stored under `%USERPROFILE%`!)
 	* Fixing annoyances:
 		* `set TERM=rxvt` to fix vagrant ssh issues
 		* `set ANSICON=true` to get coloured output with Vagrant on Windows
 		* `set SSL_CERT_FILE=W:\home\cacert.pem` pointing to recent CA certs avoiding Ruby SSL errors
 * Aliases
 	* run `be <command>` for `bundle exec <command>`
 	* run `vi <file_or_dir>` for `sublime_text <file_or_dir>` 
 * Example Repositories
 	* A [sample-application-cookbook](https://github.com/tknerr/sample-application-cookbook) with all kinds cookbook tests: syntax check, style checks, linting, unit and integration tests (see [README](https://github.com/tknerr/sample-application-cookbook/blob/master/README.md))
 	* A [sample-infrastructure-repo](https://github.com/tknerr/sample-infrastructure-repo) which defines a sample server infrastructure with environments and databages via Vagrant / Chef Solo

The only requirement for using the devpack is a recent version of [VirtualBox](https://www.virtualbox.org/wiki/Downloads) (couldn't make that one portable).


Screenshot
==========

![Bill's Kitchen Screenshot](https://raw.github.com/tknerr/bills-kitchen/master/doc/bills_kitchen_screenshot.png) 


Installation
============

As a prerequisite for building bill's kitchen you need 7zip installed in `C:\Program Files\7-Zip\7z.exe`.

To build the kitchen (make sure you don't have spaces in the path):
```
gem install bundler
bundle install
rake build
```

This might take a while (you can go fetch a coffee). It will download the external dependencies, install the tools and prepare everything else we need in the kitchen into the `target/build` directory. Finally it runs the `spec/integration` examples to ensure everything is properly installed.

To run the more comprehensive `spec/acceptance` tests:
```
rake acceptance
```

This will use various of the tools in the kitchen in combination, e.g.:

* cloning a sample application cookbook and sample infrastructure repository
* running various commands like `bundle install`, `vagrant plugin install`, `vagrant up`
* running different kinds of cookbook tests via `knife cookbook test`, `foodcritic`, `chefspec` and `test-kitchen`

Finally, if all the tests pass you can create a portable zip package:
```
rake package
```

This will and finally package everything in the `target/build` directory into `target/bills-kitchen-<version>.7z`.


Usage
=====

Make sure you have  [VirtualBox](https://www.virtualbox.org/wiki/Downloads) installed, then:
S
1. unzip the `target/bills-kitchen-<version>.7z` somewhere
2. mount the kitchen to the `W:\` drive by double-clicking the `mount-w-drive.bat` file
3. click `W:\Launch ConEmu.lnk` to open a command prompt
4. in the command prompt run `W:\set-env.bat` to set up the PATH etc 
5. walk through the [GETTING_STARTED](file://W:/_GETTING_STARTED.html) tutorial to get familiar with Vagrant, Chef & Co
6. continue with the [COOKBOOK_DEVELOPMENT](file://W:/_COOKBOOK_DEVELOPMENT.html) guide and start cooking your own recipes!
