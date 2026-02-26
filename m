Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 561B2FC5911
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 08:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvX1B-0005GJ-28; Thu, 26 Feb 2026 03:46:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvX18-0005Ey-SC
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 03:46:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvX17-000588-8n
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 03:46:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772095600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L+RyRLaqQtZc3EzTIayv9FDKEXo7lUf/dERof9VMRnM=;
 b=W/puaDiWKlF6qNVHJINy71bcPBY0Wt0X6CkcRexv1iYbmFPsI5AcJ8oAImUitjSykhDW+u
 yQtfIH8BzGw4NQUj+B3aTfibxdkaXoYoqVkeD5i1z9EP3a8ziMOiZlInCzaB3LH5mfJHpE
 hgHnqAu400OfgMXNhueIg/KZW/6VPtk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-WrgkjeoaPtClaTCQjWECXQ-1; Thu,
 26 Feb 2026 03:46:36 -0500
X-MC-Unique: WrgkjeoaPtClaTCQjWECXQ-1
X-Mimecast-MFC-AGG-ID: WrgkjeoaPtClaTCQjWECXQ_1772095595
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 404EA1956088; Thu, 26 Feb 2026 08:46:35 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.225.23])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DCAAB19560B5; Thu, 26 Feb 2026 08:46:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 4/4] Remove the qemu-system-microblazeel target from the
 build
Date: Thu, 26 Feb 2026 09:46:06 +0100
Message-ID: <20260226084608.11251-5-thuth@redhat.com>
In-Reply-To: <20260226084608.11251-1-thuth@redhat.com>
References: <20260226084608.11251-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

It's been deprecated since two releases, so it should be fine to
remove this now. Users can use the qemu-system-microblaze binary
instead that can handle both endiannesses now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                      |  4 ++--
 docs/about/deprecated.rst                        | 13 -------------
 docs/about/removed-features.rst                  | 14 ++++++++++++++
 configs/devices/microblazeel-softmmu/default.mak |  6 ------
 configs/targets/microblazeel-softmmu.mak         |  6 ------
 qapi/machine.json                                |  2 +-
 6 files changed, 17 insertions(+), 28 deletions(-)
 delete mode 100644 configs/devices/microblazeel-softmmu/default.mak
 delete mode 100644 configs/targets/microblazeel-softmmu.mak

diff --git a/MAINTAINERS b/MAINTAINERS
index 233d2a5e71f..2af4b2c0887 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -286,7 +286,7 @@ F: target/microblaze/
 F: hw/microblaze/
 F: disas/microblaze.c
 F: tests/docker/dockerfiles/debian-microblaze-cross.d/build-toolchain.sh
-F: tests/functional/microblaze*/meson.build
+F: tests/functional/microblaze/
 
 MIPS TCG CPUs
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
@@ -1422,7 +1422,7 @@ M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 S: Maintained
 F: hw/microblaze/petalogix_s3adsp1800_mmu.c
 F: include/hw/char/xilinx_uartlite.h
-F: tests/functional/microblaze*/test_s3adsp1800.py
+F: tests/functional/microblaze/test_s3adsp1800.py
 
 petalogix_ml605
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 1d5c4f3707c..d0ce914d858 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -301,19 +301,6 @@ please write a mail to the qemu-devel mailing list). If you just want to
 boot a Cortex-A15 or Cortex-A9 Linux, use the ``virt`` machine instead.
 
 
-System emulator binaries
-------------------------
-
-``qemu-system-microblazeel`` (since 10.1)
-'''''''''''''''''''''''''''''''''''''''''
-
-The ``qemu-system-microblaze`` binary can emulate little-endian machines
-now, too, so the separate binary ``qemu-system-microblazeel`` (with the
-``el`` suffix) for little-endian targets is not required anymore. The
-``petalogix-s3adsp1800`` machine can now be switched to little endian by
-setting its ``endianness`` property to ``little``.
-
-
 Backend options
 ---------------
 
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 41bec8b8e38..c6ee20ff620 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -1277,6 +1277,20 @@ The 'pvrdma' device and the whole RDMA subsystem have been removed.
 
 SD physical layer specification v2.00 supersedes the v1.10 one.
 
+
+System emulator binaries
+------------------------
+
+``qemu-system-microblazeel`` (removed in 11.0)
+''''''''''''''''''''''''''''''''''''''''''''''
+
+The ``qemu-system-microblaze`` binary can emulate little-endian machines
+now, too, so the separate binary ``qemu-system-microblazeel`` (with the
+``el`` suffix) for little-endian targets is not required anymore. The
+``petalogix-s3adsp1800`` machine can now be switched to little endian by
+setting its ``endianness`` property to ``little``.
+
+
 Related binaries
 ----------------
 
diff --git a/configs/devices/microblazeel-softmmu/default.mak b/configs/devices/microblazeel-softmmu/default.mak
deleted file mode 100644
index 4c1086435bf..00000000000
--- a/configs/devices/microblazeel-softmmu/default.mak
+++ /dev/null
@@ -1,6 +0,0 @@
-# Default configuration for microblazeel-softmmu
-
-# Boards are selected by default, uncomment to keep out of the build.
-# CONFIG_PETALOGIX_S3ADSP1800=n
-# CONFIG_PETALOGIX_ML605=n
-# CONFIG_XLNX_ZYNQMP_PMU=n
diff --git a/configs/targets/microblazeel-softmmu.mak b/configs/targets/microblazeel-softmmu.mak
deleted file mode 100644
index 52feb957b48..00000000000
--- a/configs/targets/microblazeel-softmmu.mak
+++ /dev/null
@@ -1,6 +0,0 @@
-TARGET_ARCH=microblaze
-# needed by boot.c
-TARGET_NEED_FDT=y
-TARGET_XML_FILES=gdb-xml/microblaze-core.xml gdb-xml/microblaze-stack-protect.xml
-TARGET_LONG_BITS=32
-TARGET_NOT_USING_LEGACY_LDST_PHYS_API=y
diff --git a/qapi/machine.json b/qapi/machine.json
index ef8575b6eb9..685e4e29b87 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -38,7 +38,7 @@
 ##
 { 'enum' : 'SysEmuTarget',
   'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'hexagon', 'hppa', 'i386',
-             'loongarch64', 'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
+             'loongarch64', 'm68k', 'microblaze', 'mips', 'mips64',
              'mips64el', 'mipsel', 'or1k', 'ppc',
              'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
              'sh4eb', 'sparc', 'sparc64', 'tricore',
-- 
2.53.0


