# This file is part of MXE.
# See index.html for further information.

PKG             := qtserialport
$(PKG)_IGNORE   :=
$(PKG)_VERSION   = $(qtbase_VERSION)
$(PKG)_CHECKSUM := aa843f96fe1a49d91eb7582d3be5035de5b5508e
$(PKG)_SUBDIR    = $(subst qtbase,qtserialport,$(qtbase_SUBDIR))
$(PKG)_FILE      = $(subst qtbase,qtserialport,$(qtbase_FILE))
$(PKG)_URL       = $(subst qtbase,qtserialport,$(qtbase_URL))
$(PKG)_DEPS     := gcc qtbase

define $(PKG)_UPDATE
    echo $(qtbase_VERSION)
endef

define $(PKG)_BUILD
    # invoke qmake with removed debug options as a workaround for
    # https://bugreports.qt-project.org/browse/QTBUG-30898
    cd '$(1)' && '$(PREFIX)/$(TARGET)/qt5/bin/qmake' CONFIG-='debug debug_and_release'
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef

define $(PKG)_BUILD_STATIC
    cd '$(1)' && sed -i 's#SUBDIRS\ =\ src\ examples\ tests#SUBDIRS\ =\ src#g' qtserialport.pro
    cd '$(1)' && '$(PREFIX)/$(TARGET)/qt/bin/qmake' CONFIG+=staticlib
    $(MAKE) -C '$(1)' -j '$(JOBS)'
    $(MAKE) -C '$(1)' -j 1 install
endef

