Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440AEC36008
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Mar 2025 15:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyYLh-0003fe-Cy; Sat, 29 Mar 2025 11:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tyYLK-0003bc-NO
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 11:43:31 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tyYLH-0003CP-Ac
 for qemu-devel@nongnu.org; Sat, 29 Mar 2025 11:43:30 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C4FF04E6039;
 Sat, 29 Mar 2025 16:43:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id LrP7dcC-nOmZ; Sat, 29 Mar 2025 16:43:23 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CACC24E6031; Sat, 29 Mar 2025 16:43:23 +0100 (CET)
Message-ID: <bb208aab670cc59bdb1f7ea67239e2b72884f317.1743262839.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1743262839.git.balaton@eik.bme.hu>
References: <cover.1743262839.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 2/2] pc-bios: Move device tree files in their own subdir
To: qemu-devel@nongnu.org
Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 29 Mar 2025 16:43:23 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

We have several device tree files already and may have more in the
future so add a new dtb subdirectory and move device tree files there
so they are not mixed with ROM binaries.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 MAINTAINERS                                |   2 +-
 pc-bios/{ => dtb}/bamboo.dtb               | Bin
 pc-bios/{ => dtb}/bamboo.dts               |   0
 pc-bios/{ => dtb}/canyonlands.dtb          | Bin
 pc-bios/{ => dtb}/canyonlands.dts          |   0
 pc-bios/dtb/meson.build                    |  23 +++++++++++++++++++++
 pc-bios/{ => dtb}/petalogix-ml605.dtb      | Bin
 pc-bios/{ => dtb}/petalogix-ml605.dts      |   0
 pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb | Bin
 pc-bios/{ => dtb}/petalogix-s3adsp1800.dts |   0
 pc-bios/meson.build                        |  23 +--------------------
 system/datadir.c                           |   4 +++-
 12 files changed, 28 insertions(+), 24 deletions(-)
 rename pc-bios/{ => dtb}/bamboo.dtb (100%)
 rename pc-bios/{ => dtb}/bamboo.dts (100%)
 rename pc-bios/{ => dtb}/canyonlands.dtb (100%)
 rename pc-bios/{ => dtb}/canyonlands.dts (100%)
 create mode 100644 pc-bios/dtb/meson.build
 rename pc-bios/{ => dtb}/petalogix-ml605.dtb (100%)
 rename pc-bios/{ => dtb}/petalogix-ml605.dts (100%)
 rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dtb (100%)
 rename pc-bios/{ => dtb}/petalogix-s3adsp1800.dts (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index d54b5578f8..9349950527 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1569,7 +1569,7 @@ F: hw/pci-host/ppc440_pcix.c
 F: hw/display/sm501*
 F: hw/ide/sii3112.c
 F: hw/rtc/m41t80.c
-F: pc-bios/canyonlands.dt[sb]
+F: pc-bios/dtb/canyonlands.dt[sb]
 F: pc-bios/u-boot-sam460ex-20100605.bin
 F: roms/u-boot-sam460ex
 F: docs/system/ppc/amigang.rst
diff --git a/pc-bios/bamboo.dtb b/pc-bios/dtb/bamboo.dtb
similarity index 100%
rename from pc-bios/bamboo.dtb
rename to pc-bios/dtb/bamboo.dtb
diff --git a/pc-bios/bamboo.dts b/pc-bios/dtb/bamboo.dts
similarity index 100%
rename from pc-bios/bamboo.dts
rename to pc-bios/dtb/bamboo.dts
diff --git a/pc-bios/canyonlands.dtb b/pc-bios/dtb/canyonlands.dtb
similarity index 100%
rename from pc-bios/canyonlands.dtb
rename to pc-bios/dtb/canyonlands.dtb
diff --git a/pc-bios/canyonlands.dts b/pc-bios/dtb/canyonlands.dts
similarity index 100%
rename from pc-bios/canyonlands.dts
rename to pc-bios/dtb/canyonlands.dts
diff --git a/pc-bios/dtb/meson.build b/pc-bios/dtb/meson.build
new file mode 100644
index 0000000000..7a71835bca
--- /dev/null
+++ b/pc-bios/dtb/meson.build
@@ -0,0 +1,23 @@
+dtbs = [
+  'bamboo.dtb',
+  'canyonlands.dtb',
+  'petalogix-ml605.dtb',
+  'petalogix-s3adsp1800.dtb',
+]
+
+dtc = find_program('dtc', required: false)
+if dtc.found()
+  foreach out : dtbs
+    f = fs.replace_suffix(out, '.dts')
+    custom_target(f,
+        build_by_default: have_system,
+        input: files(f),
+        output: out,
+        install: get_option('install_blobs'),
+        install_dir: qemu_datadir / 'dtb',
+        command: [ dtc, '-q', '-I', 'dts', '-O', 'dtb',
+                        '-o', '@OUTPUT@', '@INPUT0@' ])
+  endforeach
+else
+    install_data(dtbs, install_dir: qemu_datadir / 'dtb')
+endif
diff --git a/pc-bios/petalogix-ml605.dtb b/pc-bios/dtb/petalogix-ml605.dtb
similarity index 100%
rename from pc-bios/petalogix-ml605.dtb
rename to pc-bios/dtb/petalogix-ml605.dtb
diff --git a/pc-bios/petalogix-ml605.dts b/pc-bios/dtb/petalogix-ml605.dts
similarity index 100%
rename from pc-bios/petalogix-ml605.dts
rename to pc-bios/dtb/petalogix-ml605.dts
diff --git a/pc-bios/petalogix-s3adsp1800.dtb b/pc-bios/dtb/petalogix-s3adsp1800.dtb
similarity index 100%
rename from pc-bios/petalogix-s3adsp1800.dtb
rename to pc-bios/dtb/petalogix-s3adsp1800.dtb
diff --git a/pc-bios/petalogix-s3adsp1800.dts b/pc-bios/dtb/petalogix-s3adsp1800.dts
similarity index 100%
rename from pc-bios/petalogix-s3adsp1800.dts
rename to pc-bios/dtb/petalogix-s3adsp1800.dts
diff --git a/pc-bios/meson.build b/pc-bios/meson.build
index 34d6616c32..34d8cc4f33 100644
--- a/pc-bios/meson.build
+++ b/pc-bios/meson.build
@@ -86,31 +86,10 @@ blobs = [
   'vof-nvram.bin',
 ]
 
-dtc = find_program('dtc', required: false)
-foreach f : [
-  'bamboo.dts',
-  'canyonlands.dts',
-  'petalogix-s3adsp1800.dts',
-  'petalogix-ml605.dts',
-]
-  out = fs.replace_suffix(f, '.dtb')
-  if dtc.found()
-    custom_target(f,
-        build_by_default: have_system,
-        input: files(f),
-        output: out,
-        install: get_option('install_blobs'),
-        install_dir: qemu_datadir,
-        command: [ dtc, '-q', '-I', 'dts', '-O', 'dtb',
-                        '-o', '@OUTPUT@', '@INPUT0@' ])
-  else
-    blobs += out
-  endif
-endforeach
-
 if get_option('install_blobs')
   install_data(blobs, install_dir: qemu_datadir)
 endif
 
 subdir('descriptors')
+subdir('dtb')
 subdir('keymaps')
diff --git a/system/datadir.c b/system/datadir.c
index e450b84ce9..f96f8fc264 100644
--- a/system/datadir.c
+++ b/system/datadir.c
@@ -44,9 +44,11 @@ char *qemu_find_file(QemuFileType type, const char *name)
 
     switch (type) {
     case QEMU_FILE_TYPE_BIOS:
-    case QEMU_FILE_TYPE_DTB:
         subdir = "";
         break;
+    case QEMU_FILE_TYPE_DTB:
+        subdir = "dtb/";
+        break;
     case QEMU_FILE_TYPE_KEYMAP:
         subdir = "keymaps/";
         break;
-- 
2.41.3


