# Maintainer: Yukari Chiba <i@0x7f.cc>

pkgname=gettext
pkgver=0.21
pkgrel=1
pkgdesc="GNU internationalization library"
arch=(x86_64)
license=(GPL3)
groups=(base-devel)
depends=(acl)
makedepends=(gettext)
options=(!docs)
source=(https://ftp.gnu.org/pub/gnu/gettext/$pkgname-$pkgver.tar.gz)
sha256sums=('SKIP')

build() {
  cd $pkgname-$pkgver

  ./configure \
    --prefix=/usr \
    --enable-csharp \
    --enable-nls \
    --with-xz \
    --without-included-gettext

  sed -e 's/ -shared / -Wl,-O1,--as-needed\0/g' \
      -i gettext-{tools,runtime,runtime/libasprintf}/libtool

  make
}

package() {
  cd $pkgname-$pkgver
  make DESTDIR="$pkgdir" install
}

