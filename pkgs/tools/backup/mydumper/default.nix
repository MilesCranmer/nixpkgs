{ lib, stdenv, fetchFromGitHub
, cmake, pkg-config, sphinx
, glib , pcre
, libmysqlclient, libressl
, zlib, zstd
}:

stdenv.mkDerivation rec {
  pname = "mydumper";
  version = "0.14.1-1";

  src = fetchFromGitHub {
    owner  = "mydumper";
    repo = "mydumper";
    rev = "refs/tags/v${version}";
    hash = "sha256-I8COArsIO8+09SNa3DrgoGpvhLj08I8UvT2H9k9mJNQ=";
  };

  outputs = [ "out" "doc" "man" ];

  nativeBuildInputs = [ cmake pkg-config sphinx ];

  buildInputs = [
    glib pcre
    libmysqlclient libressl
    zlib zstd
  ];

  cmakeFlags = [
    "-DCMAKE_SKIP_BUILD_RPATH=ON"
    "-DMYSQL_INCLUDE_DIR=${lib.getDev libmysqlclient}/include/mysql"
    "-DWITH_ZSTD=ON"
  ];

  meta = with lib; {
    description = "High-perfomance MySQL backup tool";
    homepage = "https://github.com/maxbube/mydumper";
    changelog = "https://github.com/mydumper/mydumper/releases/tag/v${version}";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    maintainers = with maintainers; [ izorkin ];
  };
}
