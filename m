Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DFBFD3772
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 16:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvHbe-0005qC-CC; Wed, 25 Feb 2026 11:19:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvHbM-0005bZ-H2
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:19:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vvHbK-0005ZS-Jz
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:19:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772036342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v+qVlRk/d++K6eeh2ddzgS+mCUFOCL2EiVUqbJASXWE=;
 b=ITw2AHz78n58Ola7GKCt2sd6q1U8ojTulRJhoJGnKabgHD0zjSy56tCUjXtyB6wzfL4NtX
 C6n9GXbbDnNko4oMFGHO49O/Cq3aFUmbUms3b1zQJG/xV3UBGAZ2V2qoLxJ/P5J4CMO4rq
 ORBeGdnAO7eTvzMOrqmzGZMoZzn14Eg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-n4M6J_h_MkiDMDjuvv1fvg-1; Wed,
 25 Feb 2026 11:18:56 -0500
X-MC-Unique: n4M6J_h_MkiDMDjuvv1fvg-1
X-Mimecast-MFC-AGG-ID: n4M6J_h_MkiDMDjuvv1fvg_1772036334
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A3A018002C1; Wed, 25 Feb 2026 16:18:54 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.158])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 510331800465; Wed, 25 Feb 2026 16:18:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	"Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: devel@lists.libvirt.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Subject: [PATCH 4/4] Remove the qemu-system-microblazeel target from the build
Date: Wed, 25 Feb 2026 17:18:21 +0100
Message-ID: <20260225161823.1438850-5-thuth@redhat.com>
In-Reply-To: <20260225161823.1438850-1-thuth@redhat.com>
References: <20260225161823.1438850-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 tests/tcg/plugins/syscall.c                      |  1 -
 7 files changed, 17 insertions(+), 29 deletions(-)
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
diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index 5658f830879..624836dec62 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -40,7 +40,6 @@ static const struct SyscallInfo arch_syscall_info[] = {
     { "loongarch64", -1 },
     { "m68k", 4 },
     { "microblaze", 4 },
-    { "microblazeel", 4 },
     { "mips", 1 },
     { "mips64", 1 },
     { "mips64el", 1 },
-- 
2.53.0


