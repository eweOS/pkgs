# Maintainer: Yukari Chiba <i@0x7f.cc>

pkgname=s6
pkgver=2.11.1.2
pkgrel=1
pkgdesc='A small process supervision suite for UNIX.'
arch=(x86_64)
url='http://skarnet.org/software/s6/'
license=(ISC)
groups=(base)
depends=(execline)
makedepends=(skalibs execline)
options=(emptydirs)
source=(
    "http://skarnet.org/software/s6/s6-${pkgver}.tar.gz"
    rc.init
    rc.shutdown
    s6.install
    s6-init
    s6-svscan-crash
    s6-svscan-finish
    s6-svscan-log
    s6-service
    s6-telinit
    taillog
    tty1-service
    ttyS0-service
)

sha256sums=(
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
)

install=s6.install

build() {
    cd ${pkgname}-${pkgver}
    ./configure \
      --prefix=/usr \
      --bindir=/usr/bin \
      --libexecdir=/usr/lib/s6
    make
}

package() {
    cd ${pkgname}-${pkgver}
    make DESTDIR="${pkgdir}" install
    
    cd "${pkgdir}" || return 1
    mv usr/lib/s6/libs6.a usr/lib/

    # Services dir and init
    install -d s6 etc/s6/services/{available,enabled}
    install -d usr/bin
    install -m 0750 "${srcdir}/s6-init" usr/bin/
    install -m 0750 "${srcdir}/rc.init" etc/s6/
    install -m 0750 "${srcdir}/rc.shutdown" etc/s6/
    install -m 0750 "${srcdir}/s6-telinit" usr/bin/

    # Early env vars
    install -d etc/s6/env
    echo 'UTC' >etc/s6/env/TZ

    # crash and finish scripts for s6-svscan
    install -d etc/s6/init-services/.s6-svscan
    install -m 0750 "${srcdir}/s6-svscan-crash" etc/s6/init-services/.s6-svscan/crash
    install -m 0750 "${srcdir}/s6-svscan-finish" etc/s6/init-services/.s6-svscan/finish

    # early tty1 and ttyS0 service
    install -d etc/s6/init-services/tty1 etc/s6/init-services/ttyS0
    install -m 0754 "${srcdir}/tty1-service" etc/s6/init-services/tty1/run
    install -m 0754 "${srcdir}/ttyS0-service" etc/s6/init-services/ttyS0/run

    # Script and named pipe for catchall logging process
    install -d etc/s6/init-services/s6-svscan-log
    install -m 0750 "${srcdir}/s6-svscan-log" etc/s6/init-services/s6-svscan-log/run
    mkfifo etc/s6/init-services/s6-svscan-log/fifo
    chmod 0600 etc/s6/init-services/s6-svscan-log/fifo

    # Human readable/usable service compatibility layer
    install -m 0754 "${srcdir}/s6-service" usr/bin/
    install -m 0755 "${srcdir}/taillog" usr/bin/
}
