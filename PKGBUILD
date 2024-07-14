# Maintainer: Jerry Y. Chen <chen@jyny.dev>

pkgname=atlas-git
pkgdesc="A modern tool for managing database schemas"
pkgver=0.25.0
pkgrel=1
binary=atlas
arch=("x86_64")
makedepends=("go")

license=("Apache-2.0")
provides=('atlas')
conflicts=('atlas')
url="https://github.com/ariga/${binary}"
source=(
  "${binary}-${pkgver}.tar.gz::https://github.com/ariga/${binary}/archive/v${pkgver}.tar.gz"
)

sha256sums=('fbb385185c9c1576c2350d483bc624409904b8ee63db0950b84a4115e991bfd8')
b2sums=('698c53b5f01200c397ee2f613d90735c474dbf243e6e48d6ad7bc625da29054dfc87666e74e4754ba3371fef6e40bf175e863b6e0c996b0cf2038b4cce882291')

prepare() {
  cd "${srcdir}/${binary}-${pkgver}"
}

build() {
  export GOPATH="${srcdir}/.go"
  export CGO_CFLAGS="${CFLAGS}"
  export CGO_CPPFLAGS="${CPPFLAGS}"
  export CGO_CXXFLAGS="${CXXFLAGS}"
  export CGO_LDFLAGS="${LDFLAGS}"
  export GOFLAGS="-buildmode=pie -trimpath -mod=readonly -modcacherw -x -v"

  cd "${srcdir}/${binary}-${pkgver}/cmd/${binary}"
  go build -ldflags "-X 'ariga.io/atlas/cmd/atlas/internal/cmdapi.version=v${pkgver}'" .

  go clean -x -modcache
}

package() {
  install -Dm755 "${srcdir}/${binary}-${pkgver}/cmd/${binary}/${binary}" "${pkgdir}/usr/bin/${binary}"
}