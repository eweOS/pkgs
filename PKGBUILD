# Maintainer: Ziyao <tswuyin_st127@163.com>

pkgname='binutils-gold'
pkgver=2.39
pkgrel=0
pkgdesc='Part of binutils'
arch=(x86_64)
url='https://github.com/eweOS/binutils-gold'
license=('GPL3' 'GPL' 'FDL1.3')
depends=(musl zlib)
source=("https://github.com/eweOS/binutils-gold/archive/refs/tags/v${pkgver}.tar.gz")
sha256sums=('SKIP')

build() {
	cd binutils-gold-${pkgver}
	cd bfd && ./configure --with-system-zlib --disable-werror && make -i
	cd ../libiberty && ./configure && make -i
	cd ../gold && ./configure && make -i
}

package() {
    cd binutils-gold-${pkgver}/gold
    cp ld-new binutils-gold
    install -Dm755 -t "${pkgdir}"/usr/bin/ binutils-gold
}
