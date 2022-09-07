# Maintainer: Yukari Chiba <i@0x7f.cc>

pkgname=ucspi-unix
pkgver=1.0
pkgrel=1
pkgdesc="UNIX-domain socket client-server command-line tools"
arch=('x86_64')
url="http://untroubled.org/ucspi-unix"
depends=('bash')
source=("http://untroubled.org/ucspi-unix/archive/${pkgname}-${pkgver}.tar.gz")
license=('GPL')
sha256sums=('SKIP')

build() {
  cd "${srcdir}/${pkgname}-${pkgver}"
  sed -i "1s/\$/ $(echo -n $CFLAGS | sed 's/[\/&]/\\&/g')/" conf-cc
  sed -i "s/gcc/clang/g" conf-cc
  sed -i "1s/\$/ $(echo -n $LDFLAGS | sed 's/[\/&]/\\&/g')/" conf-ld
  sed -i "s/gcc/clang/g" conf-ld
  make
}

package() {
  cd "${srcdir}/${pkgname}-${pkgver}"
  make install prefix="${pkgdir}/usr" mandir="share/man"
}
