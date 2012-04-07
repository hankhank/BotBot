#############################################################
#
# minidlna
#
#############################################################

MINIDLNA_VERSION = 1.0.24
MINIDLNA_SOURCE = minidlna_$(MINIDLNA_VERSION)_src.tar.gz
MINIDLNA_SITE = http://$(BR2_SOURCEFORGE_MIRROR).dl.sourceforge.net/sourceforge/minidlna
MINIDLNA_DEPENDENCIES = libexif libid3tag jpeg flac libvorbis sqlite util-linux libav
MINIDLAN_INSTALL_STAGING = yes
#libavformat 

define MINIDLNA_BUILD_CMDS
 $(MAKE) STAGING_DIR="$(STAGING_DIR)" CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D) all
endef


$(eval $(call GENTARGETS,package,minidlna))
