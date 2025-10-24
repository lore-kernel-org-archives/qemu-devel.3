Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1800CCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 23:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCRFo-0006PG-M7; Fri, 24 Oct 2025 19:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vCRFk-0006NU-2S; Fri, 24 Oct 2025 19:31:25 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vCRFg-0000Gr-Nm; Fri, 24 Oct 2025 19:31:23 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 43533597455;
 Sat, 25 Oct 2025 01:31:19 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 19RG6XjyrvrO; Sat, 25 Oct 2025 01:31:17 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id F07CB597458; Sat, 25 Oct 2025 01:31:16 +0200 (CEST)
Message-ID: <f86b90f6839a0cf9426c0d89e95e6ca33704728c.1761346145.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1761346145.git.balaton@eik.bme.hu>
References: <cover.1761346145.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 4/4] hw/ppc/pegasos: Update documentation for pegasos1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Sat, 25 Oct 2025 01:31:16 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 docs/system/ppc/amigang.rst | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/docs/system/ppc/amigang.rst b/docs/system/ppc/amigang.rst
index 21bb14ed09..e290412369 100644
--- a/docs/system/ppc/amigang.rst
+++ b/docs/system/ppc/amigang.rst
@@ -1,6 +1,6 @@
-=========================================================
-AmigaNG boards (``amigaone``, ``pegasos2``, ``sam460ex``)
-=========================================================
+=======================================================================
+AmigaNG boards (``amigaone``, ``pegasos1``, ``pegasos2``, ``sam460ex``)
+=======================================================================
 
 These PowerPC machines emulate boards that are primarily used for
 running Amiga like OSes (AmigaOS 4, MorphOS and AROS) but these can
@@ -64,18 +64,23 @@ eventually it boots and the installer becomes visible. The ``ati-vga`` RV100
 emulation is not complete yet so only frame buffer works, DRM and 3D is not
 available.
 
-Genesi/bPlan Pegasos II (``pegasos2``)
-======================================
+Genesi/bPlan Pegasos (``pegasos1``, ``pegasos2``)
+=================================================
 
-The ``pegasos2`` machine emulates the Pegasos II sold by Genesi and
-designed by bPlan. Its schematics are available at
-https://www.powerdeveloper.org/platforms/pegasos/schematics.
+The ``pegasos1`` machine emulates the original Pegasos (later marked I) sold by
+Genesi and designed by bPlan. It uses the same Articia S north bridge as the
+``amigaone`` machine, otherwise it is mostly the same as the later Pegasos II.
+
+The ``pegasos2`` machine emulates the Pegasos II which is a redesigned version
+of Pegasos I to fix problems with its north bridge. Its schematics are available
+at https://www.powerdeveloper.org/platforms/pegasos/schematics.
 
 Emulated devices
 ----------------
 
  * PowerPC 7457 CPU (can also use ``-cpu g3`` or ``750cxe``)
- * Marvell MV64361 Discovery II north bridge
+ * Articia S north bridge (for ``pegasos1``)
+ * Marvell MV64361 Discovery II north bridge (for ``pegasos2``)
  * VIA VT8231 south bridge
  * PCI VGA compatible card (guests may need other card instead)
  * PS/2 keyboard and mouse
@@ -83,9 +88,9 @@ Emulated devices
 Firmware
 --------
 
-The Pegasos II board has an Open Firmware compliant ROM based on
+The Pegasos boards have an Open Firmware compliant ROM based on
 SmartFirmware with some changes that are not open-sourced therefore
-the ROM binary cannot be included in QEMU. An updater was available
+the ROM binary cannot be included in QEMU. A Pegasos II updater was available
 from bPlan, it can be found in the `Internet Archive
 <http://web.archive.org/web/20071021223056/http://www.bplan-gmbh.de/up050404/up050404>`_.
 The ROM image can be extracted from it with the following command:
@@ -111,7 +116,7 @@ At the firmware ``ok`` prompt enter ``boot cd install/pegasos``.
 
 Alternatively, it is possible to boot the kernel directly without
 firmware ROM using the QEMU built-in minimal Virtual Open Firmware
-(VOF) emulation which is also supported on ``pegasos2``. For this,
+(VOF) emulation which is also supported on ``pegasos1`` and ``pegasos2``. For this,
 extract the kernel ``install/powerpc/vmlinuz-chrp.initrd`` from the CD
 image, then run:
 
-- 
2.41.3


