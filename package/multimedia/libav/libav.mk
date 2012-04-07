#############################################################
#
# libav
#
#############################################################

LIBAV_VERSION = 0.7
LIBAV_SOURCE = libav-$(LIBAV_VERSION).tar.gz
LIBAV_SITE = http://libav.org/releases
LIBAV_INSTALL_STAGING = YES

LIBAV_CONF_OPT = \
 --prefix=/usr       \
 --enable-shared     \
 --disable-avfilter  \
 $(if $(BR2_HAVE_DOCUMENTATION),,--disable-doc)

ifeq ($(BR2_PACKAGE_LIBAV_GPL),y)
LIBAV_CONF_OPT += --enable-gpl
else
LIBAV_CONF_OPT += --disable-gpl
endif

ifeq ($(BR2_PACKAGE_LIBAV_NONFREE),y)
LIBAV_CONF_OPT += --enable-nonfree
else
LIBAV_CONF_OPT += --disable-nonfree
endif

ifeq ($(BR2_PACKAGE_LIBAV_FFMPEG),y)
LIBAV_CONF_OPT += --enable-ffmpeg
else
LIBAV_CONF_OPT += --disable-ffmpeg
endif

ifeq ($(BR2_PACKAGE_LIBAV_FFPLAY),y)
LIBAV_DEPENDENCIES += sdl
LIBAV_CONF_OPT += --enable-ffplay
LIBAV_CONF_ENV += SDL_CONFIG=$(STAGING_DIR)/usr/bin/sdl-config
else
LIBAV_CONF_OPT += --disable-ffplay
endif

ifeq ($(BR2_PACKAGE_LIBAV_FFSERVER),y)
LIBAV_CONF_OPT += --enable-ffserver
else
LIBAV_CONF_OPT += --disable-ffserver
endif

ifeq ($(BR2_PACKAGE_LIBAV_POSTPROC),y)
LIBAV_CONF_OPT += --enable-postproc
else
LIBAV_CONF_OPT += --disable-postproc
endif

ifeq ($(BR2_PACKAGE_LIBAV_SWSCALE),y)
LIBAV_CONF_OPT += --enable-swscale
else
LIBAV_CONF_OPT += --disable-swscale
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_LIBAV_ENCODERS)),all)
LIBAV_CONF_OPT += --disable-encoders \
 $(foreach x,$(call qstrip,$(BR2_PACKAGE_LIBAV_ENCODERS)),--enable-encoder=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_LIBAV_DECODERS)),all)
LIBAV_CONF_OPT += --disable-decoders \
 $(foreach x,$(call qstrip,$(BR2_PACKAGE_LIBAV_DECODERS)),--enable-decoder=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_LIBAV_MUXERS)),all)
LIBAV_CONF_OPT += --disable-muxers \
 $(foreach x,$(call qstrip,$(BR2_PACKAGE_LIBAV_MUXERS)),--enable-muxer=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_LIBAV_DEMUXERS)),all)
LIBAV_CONF_OPT += --disable-demuxers \
 $(foreach x,$(call qstrip,$(BR2_PACKAGE_LIBAV_DEMUXERS)),--enable-demuxer=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_LIBAV_PARSERS)),all)
LIBAV_CONF_OPT += --disable-parsers \
 $(foreach x,$(call qstrip,$(BR2_PACKAGE_LIBAV_PARSERS)),--enable-parser=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_LIBAV_BSFS)),all)
LIBAV_CONF_OPT += --disable-bsfs \
 $(foreach x,$(call qstrip,$(BR2_PACKAGE_LIBAV_BSFS)),--enable-bsf=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_LIBAV_PROTOCOLS)),all)
LIBAV_CONF_OPT += --disable-protocols \
 $(foreach x,$(call qstrip,$(BR2_PACKAGE_LIBAV_PROTOCOLS)),--enable-protocol=$(x))
endif

ifneq ($(call qstrip,$(BR2_PACKAGE_LIBAV_FILTERS)),all)
LIBAV_CONF_OPT += --disable-filters \
 $(foreach x,$(call qstrip,$(BR2_PACKAGE_LIBAV_FILTERS)),--enable-filter=$(x))
endif

ifeq ($(BR2_PACKAGE_LIBAV_INDEVS),y)
LIBAV_CONF_OPT += --enable-indevs
else
LIBAV_CONF_OPT += --disable-indevs
endif

ifeq ($(BR2_PACKAGE_LIBAV_OUTDEVS),y)
LIBAV_CONF_OPT += --enable-outdevs
else
LIBAV_CONF_OPT += --disable-outdevs
endif

ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
LIBAV_CONF_OPT += --enable-pthreads
else
LIBAV_CONF_OPT += --disable-pthreads
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
LIBAV_CONF_OPT += --enable-zlib
LIBAV_DEPENDENCIES += zlib
else
LIBAV_CONF_OPT += --disable-zlib
endif

# MMX on is default for x86, disable it for lowly x86-type processors
ifeq ($(BR2_x86_i386)$(BR2_x86_i486)$(BR2_x86_i586)$(BR2_x86_i686)$(BR2_x86_pentiumpro)$(BR2_x86_geode),y)
LIBAV_CONF_OPT += --disable-mmx
endif

# ARM defaults to v5: clear if less, add extra if more
ifeq ($(BR2_generic_arm)$(BR2_arm7tdmi)$(BR2_arm610)$(BR2_arm710)$(BR2_arm720t)$(BR2_arm920t)$(BR2_arm922t),y)
LIBAV_CONF_OPT += --disable-armv5te
endif
ifeq ($(BR2_arm1136jf_s)$(BR2_arm1176jz_s)$(BR2_arm1176jzf-s),y)
LIBAV_CONF_OPT += --enable-armv6
endif
ifeq ($(BR2_arm10)$(BR2_arm1136jf_s)$(BR2_arm1176jz_s)$(BR2_arm1176jzf-s)$(BR2_cortex_a8)$(BR2_cortex_a9),y)
LIBAV_CONF_OPT += --enable-armvfp
endif
# NEON is optional for A9
ifeq ($(BR2_cortex_a8),y)
LIBAV_CONF_OPT += --enable-neon
endif
# Set powerpc altivec appropriately
ifeq ($(BR2_powerpc),y)
ifeq ($(BR2_powerpc_7400)$(BR2_powerpc_7450)$(BR2_powerpc_970),y)
LIBAV_CONF_OPT -= --enable-altivec
else
LIBAV_CONF_OPT += --disable-altivec
endif
endif

LIBAV_CONF_OPT += $(call qstrip,$(BR2_PACKAGE_LIBAV_EXTRACONF))

# Override LIBAV_CONFIGURE_CMDS: FFmpeg does not support --target and others
define LIBAV_CONFIGURE_CMDS
 (cd $(LIBAV_SRCDIR) && rm -rf config.cache && \
 $(TARGET_CONFIGURE_OPTS) \
 $(TARGET_CONFIGURE_ARGS) \
 $(LIBAV_CONF_ENV) \
 ./configure \
     --enable-cross-compile  \
     --cross-prefix=$(TARGET_CROSS) \
     --sysroot=$(STAGING_DIR) \
     --host-cc="$(HOSTCC)" \
     --arch=$(BR2_ARCH) \
     --target-os=linux \
     --extra-cflags=-fPIC \
     $(SHARED_STATIC_LIBS_OPTS) \
     $(LIBAV_CONF_OPT) \
 )
endef

$(eval $(call AUTOTARGETS,package/multimedia,libav))
