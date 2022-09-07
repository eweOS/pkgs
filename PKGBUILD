# Maintainer: Yukari Chiba <i@0x7f.cc>

pkgname=libcap
pkgver=2.65
pkgrel=1
pkgdesc="POSIX 1003.1e capabilities"
arch=(x86_64)
url="https://sites.google.com/site/fullycapable/"
license=(GPL2)
depends=(musl)
makedepends=(linux-headers)
options=(debug)
source=(https://kernel.org/pub/linux/libs/security/linux-privs/${pkgname}2/$pkgname-$pkgver.tar.xz)
sha256sums=('SKIP')

build() {
  make HOSTCC=clang CC=clang DYNAMIC=yes KERNEL_HEADERS=/usr/include lib=lib prefix=/usr sbindir=bin -C $pkgname-$pkgver
}

package() {
  make HOSTCC=clang CC=clang DESTDIR="$pkgdir" RAISE_SETFCAP=no lib=lib prefix=/usr sbindir=bin install -C $pkgname-$pkgver
}
