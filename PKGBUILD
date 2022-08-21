# Maintainer: Yukari Chiba <i@0x7f.cc>

pkgname=execline
pkgver=2.8.0.1
pkgrel=1
pkgdesc='a (non-interactive) scripting language.'
arch=(x86_64)
url='http://skarnet.org/software/execline/'
license=(ISC)
groups=()
depends=()
makedepends=(skalibs)
options=()
source=(
    "http://skarnet.org/software/execline/execline-${pkgver}.tar.gz"
)

sha256sums=(
    'SKIP'
)

build() {
    cd ${pkgname}-${pkgver}
    ./configure --prefix=/usr
    make
}

package() {
    cd ${pkgname}-${pkgver}
    make DESTDIR="${pkgdir}" install
}

