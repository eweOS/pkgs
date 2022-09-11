# Maintainer: Yukari Chiba <i@0x7f.cc>

_basename=linux
pkgname=(linux linux-headers)
pkgver=5.19.3
_kernelver=519
pkgrel=1
pkgdesc='Linux kernel meta package'
arch=('any')
license=('GPL')
source=(linux.install)

sha256sums=('SKIP')

optdepends=('mkinitramfs: generate initramfs')

install=linux.install

package_linux() {
  depends=(linux${_kernelver})
}

package_linux-headers() {
  depends=(linux${_kernelver}-headers)
}

