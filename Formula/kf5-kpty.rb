class Kf5Kpty < Formula
  desc "Pty abstraction"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.56/kpty-5.56.0.tar.xz"
  sha256 "f310c89854a10000dabc3e67b227bf6b28b1511c87968a7cb81a9a9f8d22f7b7"

  revision 1
  head "git://anongit.kde.org/kpty.git"
  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-kcoreaddons"
  depends_on "KDE-mac/kde/kf5-ki18n"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
