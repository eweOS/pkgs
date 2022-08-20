# Maintainer: Yukari Chiba <i@0x7f.cc>

pkgname=fakeroot
pkgdesc='fakeroot placeholder'
pkgver=0.0.1
pkgrel=1
arch=("x86_64")
license=('GPL')
source=(fakeroot)
sha256sums=('SKIP')

package() {
    install -d ${pkgdir}/usr/bin
    install -m 0755 "${srcdir}/fakeroot" ${pkgdir}/usr/bin/fakeroot
}
