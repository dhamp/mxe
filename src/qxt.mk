# This file is part of MXE.
# See index.html for further information.

PKG             := qxt
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 0.6.2
$(PKG)_CHECKSUM := 4cc514d725afe29bf4e1b165bbdf9a997703b46f
$(PKG)_SUBDIR   := lib$(PKG)-lib$(PKG)-dadc327c2a6a
$(PKG)_FILE     := v$($(PKG)_VERSION).tar.bz2
$(PKG)_URL      := http://bitbucket.org/lib$(PKG)/lib$(PKG)/get/$($(PKG)_FILE)
$(PKG)_DEPS     := qt

define $(PKG)_UPDATE
    echo $(PKG)_VERSION
endef

define $(PKG)_BUILD
    cd '$(1)' && \
        OPENSSL_LIBS="`'$(TARGET)-pkg-config' --libs-only-l openssl`" \
        ./configure -prefix $(PREFIX)/$(TARGET)/\
        -qmake-bin $(PREFIX)/$(TARGET)/qt/bin/qmake \
        -no-avahi \
        -no-db \
        -nomake docs \
        -nomake sql \
        -nomake berkeley \
        -nomake designer \
        -nomake gui \
        -nomake sql \
        -nomake web \
        -nomake zeroconf

    $(MAKE) -C '$(1)' -j '$(JOBS)'
    rm -rf '$(PREFIX)/$(TARGET)/$(PKG)'
    $(MAKE) -C '$(1)' -j 1 install

endef

$(PKG)_BUILD_SHARED = $(subst -static ,-shared ,\
                      $($(PKG)_BUILD))
