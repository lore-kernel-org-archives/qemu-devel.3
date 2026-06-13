Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E1ACD8CA8
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:42:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYVAE-0003JL-8C; Sat, 13 Jun 2026 16:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYVAC-0003Hi-Cl; Sat, 13 Jun 2026 16:41:08 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYVAA-00055G-ED; Sat, 13 Jun 2026 16:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781382965; bh=VEkwjzgqpOMRnj24Pf/csY6+NNWUGNA5MVFit704Ems=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=uOWD3HaFf+ZpNzDyni5Jj5jUU4ah5S00KRUdaqoYt3gsUk4IbQORX7AkjzhQw2u/O
 pJ82xzjabhV1xIcEXhUzoo15C67foVpDDBl16AeRgjQGTnYUV+95yrQquOU0itcrd9
 miopFihtuLiKxmCevDDHuKnWaWukDFd4lROoV0sfJQTXtPBstlRqWh5C2USUGZ4z4i
 HzhUyanwPUxMvf2/hUiTC5c0wIPMXIR0XxDnLvesb9G5XLDpyRD5jJ4n9DloEj2q69
 ChICw72TMlY6He4R+SgD23aD/MgZzSBItQLhmjX8a/QXXPwYe5H8wEh4Mijs5hn8Pi
 zV5Xja5/Cl6RA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B1D371B6F16;
 Sat, 13 Jun 2026 23:36:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 241C23CE960;
 Sat, 13 Jun 2026 23:36:24 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 52/72] ci: drop cirrus MacOS build
Date: Sat, 13 Jun 2026 23:35:18 +0300
Message-ID: <20260613203542.1809153-52-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

CirrusCI is closing down soon so time to migrate.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260526110243.470002-6-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
(cherry picked from commit 984b192bdf371e275fb4226ca5047c1fff1de972)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index f2a9a64b76..b71ab090b6 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -44,17 +44,3 @@ x64-freebsd-14-build:
     INSTALL_COMMAND: pkg install -y
     CONFIGURE_ARGS: --target-list-exclude=arm-softmmu,i386-softmmu,mips64el-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4eb-softmmu,xtensa-softmmu --enable-rust
     TEST_TARGETS: check
-
-aarch64-macos-build:
-  extends: .cirrus_build_job
-  variables:
-    NAME: macos-14
-    CIRRUS_VM_INSTANCE_TYPE: macos_instance
-    CIRRUS_VM_IMAGE_SELECTOR: image
-    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-runner:sonoma
-    UPDATE_COMMAND: brew update
-    INSTALL_COMMAND: brew install
-    PATH_EXTRA: /opt/homebrew/ccache/libexec:/opt/homebrew/gettext/bin
-    PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
-    CONFIGURE_ARGS: --target-list-exclude=arm-softmmu,i386-softmmu,mips64-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4-softmmu,xtensaeb-softmmu --enable-rust
-    TEST_TARGETS: check-unit check-block check-qapi-schema check-softfloat check-qtest-x86_64
diff --git a/.gitlab-ci.d/cirrus/macos-14.vars b/.gitlab-ci.d/cirrus/macos-14.vars
deleted file mode 100644
index def77cfdea..0000000000
--- a/.gitlab-ci.d/cirrus/macos-14.vars
+++ /dev/null
@@ -1,16 +0,0 @@
-# THIS FILE WAS AUTO-GENERATED
-#
-#  $ lcitool variables macos-14 qemu
-#
-# https://gitlab.com/libvirt/libvirt-ci
-
-CCACHE='/opt/homebrew/bin/ccache'
-CPAN_PKGS=''
-CROSS_PKGS=''
-MAKE='/opt/homebrew/bin/gmake'
-NINJA='/opt/homebrew/bin/ninja'
-PACKAGING_COMMAND='brew'
-PIP3='/opt/homebrew/bin/pip3'
-PKGS='bash bc bindgen bison bzip2 capstone ccache cmocka coreutils ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libcbor libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python-setuptools python3 rpm2cpio rust sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 vulkan-tools xorriso zlib zstd'
-PYPI_PKGS='PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
-PYTHON='/opt/homebrew/bin/python3'
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index e4d01d792b..fa4a16e358 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -311,7 +311,6 @@ try:
     # Cirrus packages lists for GitLab
     #
     generate_cirrus("freebsd-14")
-    generate_cirrus("macos-14")
 
     #
     # VM packages lists
-- 
2.47.3


