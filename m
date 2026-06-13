Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8046CD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYVAb-0004aL-2s; Sat, 13 Jun 2026 16:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYVAZ-0004UC-RW; Sat, 13 Jun 2026 16:41:31 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYVAX-00056E-RY; Sat, 13 Jun 2026 16:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781382965; bh=zb56gFXKrBxhm7F3CspMLidaMJreYiHvIKwE6YJdNk8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=f+L+H20sAxbteDh9UTW/Z2CdvKlpV1vLJA+Wc1nv4bD4iJuaf/tcY1/bQ40JvaX+K
 oLH9q5KM5UlFgiUu9T7RBooCGRly1aUZrDu4Y9wYHEEJjb735kNWm/0SK4mZHVTb2U
 /5g0CXwGFTaYddzFXcrxwKzMjPgkfTPOnJnAX7r32ogo2xpEYIaxmglzqcz37bZ0Zt
 a7F7/iIS1JftiwP7gM1gMesHkJl+Y6wSWAx9qK9hnUGsj67w4G/3/8Ooy7Ax/0vbOq
 IWEYhJtvf+PDg4d3WdM1f3j72lYzb6qmc+uCRwXB1KvfjIHa8C1HysjvVZfvYeSRsr
 PRTH3o9vyueUA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D0B001B6F18;
 Sat, 13 Jun 2026 23:36:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 428903CE962;
 Sat, 13 Jun 2026 23:36:24 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 54/72] gitlab: remove x64-freebsd-14-build Cirrus job
Date: Sat, 13 Jun 2026 23:35:20 +0300
Message-ID: <20260613203542.1809153-54-mjt@tls.msk.ru>
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Cirrus has shut down and the x64-freebsd-14-build is failing:
https://gitlab.com/qemu-project/qemu/-/jobs/14656732122

Remove the x64-freebsd-14-build job to get the CI pipeline passing
again. The next commit will be to remove Cirrus integration from the
GitLab YAML and lcitool since it is no longer used.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@mailo.com>
Message-id: 20260602162457.828969-2-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 4023f38b50a42a9a936ee3c1c3a9642110e42916)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index b71ab090b6..4769d00c67 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -30,17 +30,3 @@
     - cirrus-run -v --show-build-log always .gitlab-ci.d/cirrus/$NAME.yml
   variables:
     QEMU_JOB_CIRRUS: 1
-
-x64-freebsd-14-build:
-  extends: .cirrus_build_job
-  variables:
-    NAME: freebsd-14
-    CIRRUS_VM_INSTANCE_TYPE: freebsd_instance
-    CIRRUS_VM_IMAGE_SELECTOR: image_family
-    CIRRUS_VM_IMAGE_NAME: freebsd-14-3
-    CIRRUS_VM_CPUS: 8
-    CIRRUS_VM_RAM: 8G
-    UPDATE_COMMAND: pkg update; pkg upgrade -y
-    INSTALL_COMMAND: pkg install -y
-    CONFIGURE_ARGS: --target-list-exclude=arm-softmmu,i386-softmmu,mips64el-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4eb-softmmu,xtensa-softmmu --enable-rust
-    TEST_TARGETS: check
diff --git a/.gitlab-ci.d/cirrus/freebsd-14.vars b/.gitlab-ci.d/cirrus/freebsd-14.vars
deleted file mode 100644
index 98fbde6cc6..0000000000
--- a/.gitlab-ci.d/cirrus/freebsd-14.vars
+++ /dev/null
@@ -1,16 +0,0 @@
-# THIS FILE WAS AUTO-GENERATED
-#
-#  $ lcitool variables freebsd-14 qemu
-#
-# https://gitlab.com/libvirt/libvirt-ci
-
-CCACHE='/usr/local/bin/ccache'
-CPAN_PKGS=''
-CROSS_PKGS=''
-MAKE='/usr/local/bin/gmake'
-NINJA='/usr/local/bin/ninja'
-PACKAGING_COMMAND='pkg'
-PIP3='/usr/local/bin/pip'
-PKGS='alsa-lib bash bison bzip2 ca_root_nss capstone4 ccache4 cmocka coreutils ctags curl cyrus-sasl dbus diffutils dtc flex fusefs-libs3 gettext git glib gmake gnutls gsed gtk-vnc gtk3 json-c libepoxy libffi libgcrypt libjpeg-turbo libnfs libslirp libspice-server libssh libtasn1 llvm lzo2 meson mtools ncurses nettle ninja opencv pixman pkgconf png py311-numpy py311-pillow py311-pip py311-pyyaml py311-setuptools py311-sphinx py311-sphinx_rtd_theme py311-tomli py311-wheel python3 rpm2cpio rust rust-bindgen-cli sdl2 sdl2_image snappy sndio socat spice-protocol tesseract usbredir virglrenderer vte3 vulkan-tools xorriso zstd'
-PYPI_PKGS=''
-PYTHON='/usr/local/bin/python3'
diff --git a/MAINTAINERS b/MAINTAINERS
index ad215eced8..8cc89d4feb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4502,9 +4502,7 @@ FreeBSD Hosted Continuous Integration
 M: Ed Maste <emaste@freebsd.org>
 M: Li-Wen Hsu <lwhsu@freebsd.org>
 S: Maintained
-F: .gitlab-ci.d/cirrus/freebsd*
 F: tests/vm/freebsd
-W: https://cirrus-ci.com/github/qemu/qemu
 
 Functional testing framework
 M: Thomas Huth <th.huth+qemu@posteo.eu>
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 4289cc381a..ad6a1e6fe8 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -313,11 +313,6 @@ try:
                         enable_rust=False,
                         trailer="".join(debian_all_test_cross_compilers))
 
-    #
-    # Cirrus packages lists for GitLab
-    #
-    generate_cirrus("freebsd-14")
-
     #
     # GitLab packages lists
     #
-- 
2.47.3


