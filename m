Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F989D15D89
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 12:48:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2rp2-0007iE-1z; Mon, 21 Oct 2024 08:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2rox-0007cP-9j
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 08:47:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2rov-0003rj-85
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 08:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729514856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=a+8QXTcmT3aBZ46jg5bF7mQrlPboSdIrk5XG25TDXRQ=;
 b=gGKhE+ChvokMm5FLeAtxaFAUhL5frVR3wezdehDv0WlbpGvY/z5Nz3tHCU5z91wt8KWBc0
 ism21x5hrKtwbr95aBy7pwfVFTjYqoHPT/VRVT6VEBWRQncSOP5BQpeeD9CKEQVXv4FGbS
 1q3TZb8AIGBzBPYgG6mX7Ujssl761ns=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-KNMjLr-6Pp-9AhFpv0SeNQ-1; Mon,
 21 Oct 2024 08:47:35 -0400
X-MC-Unique: KNMjLr-6Pp-9AhFpv0SeNQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DA4E1955F41; Mon, 21 Oct 2024 12:47:34 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.49])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D061319560A2; Mon, 21 Oct 2024 12:47:31 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH] .gitlab-ci.d/cirrus: Remove the macos-15 job
Date: Mon, 21 Oct 2024 14:47:22 +0200
Message-ID: <20241021124722.139348-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Cirrus-CI stopped providing the possibility to run macOS 15 jobs.
Quoting https://cirrus-ci.org/guide/macOS/ :

 "Cirrus CI Cloud only allows ghcr.io/cirruslabs/macos-runner:sonoma image ..."

If you still try to run a Sequoia image, it gets automatically "upgraded"
to Sonoma instead. So the macos-15 job in the QEMU CI now does not
make sense anymore, thus let's remove it.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/cirrus.yml           | 20 ++------------------
 .gitlab-ci.d/cirrus/macos-15.vars | 16 ----------------
 tests/lcitool/refresh             |  1 -
 3 files changed, 2 insertions(+), 35 deletions(-)
 delete mode 100644 .gitlab-ci.d/cirrus/macos-15.vars

diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index 5708c2bbab..6a7bafac7b 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -60,13 +60,13 @@ x64-freebsd-14-build:
     CONFIGURE_ARGS: --target-list-exclude=arm-softmmu,i386-softmmu,microblaze-softmmu,mips64el-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,xtensa-softmmu
     TEST_TARGETS: check
 
-aarch64-macos-14-base-build:
+aarch64-macos-build:
   extends: .cirrus_build_job
   variables:
     NAME: macos-14
     CIRRUS_VM_INSTANCE_TYPE: macos_instance
     CIRRUS_VM_IMAGE_SELECTOR: image
-    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-sonoma-base:latest
+    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-runner:sonoma
     CIRRUS_VM_CPUS: 12
     CIRRUS_VM_RAM: 24G
     UPDATE_COMMAND: brew update
@@ -75,19 +75,3 @@ aarch64-macos-14-base-build:
     PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
     CONFIGURE_ARGS: --target-list-exclude=arm-softmmu,i386-softmmu,microblazeel-softmmu,mips64-softmmu,mipsel-softmmu,mips-softmmu,ppc-softmmu,sh4-softmmu,xtensaeb-softmmu
     TEST_TARGETS: check-unit check-block check-qapi-schema check-softfloat check-qtest-x86_64
-
-aarch64-macos-15-base-build:
-  extends: .cirrus_build_job
-  variables:
-    NAME: macos-15
-    CIRRUS_VM_INSTANCE_TYPE: macos_instance
-    CIRRUS_VM_IMAGE_SELECTOR: image
-    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-sequoia-base:latest
-    CIRRUS_VM_CPUS: 12
-    CIRRUS_VM_RAM: 24G
-    UPDATE_COMMAND: brew update
-    INSTALL_COMMAND: brew install
-    PATH_EXTRA: /opt/homebrew/ccache/libexec:/opt/homebrew/gettext/bin
-    PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
-    TEST_TARGETS: check-unit check-block check-qapi-schema check-softfloat check-qtest-x86_64
-    QEMU_JOB_OPTIONAL: 1
diff --git a/.gitlab-ci.d/cirrus/macos-15.vars b/.gitlab-ci.d/cirrus/macos-15.vars
deleted file mode 100644
index 23b2c1d22f..0000000000
--- a/.gitlab-ci.d/cirrus/macos-15.vars
+++ /dev/null
@@ -1,16 +0,0 @@
-# THIS FILE WAS AUTO-GENERATED
-#
-#  $ lcitool variables macos-15 qemu
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
-PKGS='bash bc bison bzip2 capstone ccache cmocka ctags curl dbus diffutils dtc flex gcovr gettext git glib gnu-sed gnutls gtk+3 gtk-vnc jemalloc jpeg-turbo json-c libepoxy libffi libgcrypt libiscsi libnfs libpng libslirp libssh libtasn1 libusb llvm lzo make meson mtools ncurses nettle ninja pixman pkg-config python3 rpm2cpio sdl2 sdl2_image snappy socat sparse spice-protocol swtpm tesseract usbredir vde vte3 xorriso zlib zstd'
-PYPI_PKGS='PyYAML numpy pillow sphinx sphinx-rtd-theme tomli'
-PYTHON='/opt/homebrew/bin/python3'
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 0f16f4d525..7cf882cda7 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -229,7 +229,6 @@ try:
     #
     generate_cirrus("freebsd-14")
     generate_cirrus("macos-14")
-    generate_cirrus("macos-15")
 
     #
     # VM packages lists
-- 
2.47.0


