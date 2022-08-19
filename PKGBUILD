# Maintainer: Yukari Chiba <i@0x7f.cc>

pkgname=binutils
pkgver=2.37
pkgrel=1
pkgdesc='A set of programs to assemble and manipulate binary and object files'
arch=(x86_64)
url='https://www.gnu.org/software/binutils/'
license=('GPL3' 'GPL' 'FDL1.3' 'custom:FSFAP')
groups=(base-devel)
depends=(musl zlib)
# init by self
makedepends=(binutils)
options=(staticlibs !distcc !ccache debug)
source=("http://ftp.gnu.org/gnu/binutils/binutils-${pkgver}.tar.xz")
sha256sums=('SKIP')

prepare() {
    [[ ! -d binutils-gdb ]] && ln -s binutils-$pkgver binutils-gdb
    mkdir -p binutils-build
    cd binutils-gdb
    sed -i '/^development=/s/true/false/' bfd/development.sh
}

build() {
    cd binutils-build
    "$srcdir/binutils-gdb/configure" \
      --prefix=/usr \
      --disable-plugins \
      --disable-werror \
      --disable-nls \
      --with-system-zlib
    make tooldir=/usr
    tail -n 5 "${srcdir}"/binutils-gdb/ld/scripttempl/README > FSFAP
}

package() {
    cd binutils-build
    make prefix="$pkgdir/usr" tooldir="$pkgdir/usr" install
    install -Dm644 -t "${pkgdir}"/usr/share/licenses/${pkgname}/ FSFAP
}
