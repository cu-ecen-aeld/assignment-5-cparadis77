
##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

#
#In the action definitions, you can use the following variables:
#
#$(LIBFOO_PKGDIR) contains the path to the directory containing the libfoo.mk and Config.in files.
#  						This variable is useful when it is necessary to install a file bundled in Buildroot,
#						like a runtime configuration file, a splashscreen image.
#
#$(@D), which contains the directory in which the package source code has been uncompressed.
#
#$(LIBFOO_DL_DIR) contains the path to the directory where all the downloads made by Buildroot for libfoo are stored in.
#
#$(TARGET_CC), $(TARGET_LD), etc. to get the target cross-compilation utilities
#
#$(TARGET_CROSS) to get the cross-compilation toolchain prefix
#
#Of course the $(HOST_DIR), $(STAGING_DIR) and $(TARGET_DIR) variables to install the packages properly.
#			Those variables point to the global host, staging and target directories, unless per-package directory
#			support is used, in which case they point to the current package host, staging and target directories.
#			In both cases, it doesn’t make any difference from the package point of view: it should simply use HOST_DIR,
#			STAGING_DIR and TARGET_DIR.

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
#AESD_ASSIGNMENTS_VERSION = '#COMMIT VERSION NUMBER'
#AESD_ASSIGNMENTS_VERSION = '798e7e68b320d100de458aee464a79aff9488665'
#AESD_ASSIGNMENTS_VERSION = 'ed8a1a9d6dc7bff76644b4110b30ccc8272537d3'
#AESD_ASSIGNMENTS_VERSION = '5c92c16935f6c46f46db8c9a1ae353aa46e84e26'
AESD_ASSIGNMENTS_VERSION = '44b33420a6d926510216a25ce47dc82645555814'
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
#AESD_ASSIGNMENTS_SITE = '#GITHUB REPOSITORY LINK'
AESD_ASSIGNMENTS_SITE = 'git@github.com:cu-ecen-aeld/assignments-3-and-later-cparadis77.git'
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

define AESD_ASSIGNMENTS_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app all
endef

# TODO add your writer, finder and finder-test utilities/scripts to the installation steps below
define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	$(INSTALL) -d 0755 $(@D)/conf/ $(TARGET_DIR)/etc/finder-app/conf/
	$(INSTALL) -m 0755 $(@D)/conf/* $(TARGET_DIR)/etc/finder-app/conf/
	$(INSTALL) -m 0755 $(@D)/assignment-autotest/test/assignment4/* $(TARGET_DIR)/bin
	$(INSTALL) -m 0755 $(@D)/finder-app/writer $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/finder-app/finder.sh $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/finder-app/finder-test.sh $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
