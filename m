Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17894C021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 21:00:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpZMb-00034K-If; Tue, 04 Mar 2025 15:59:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tpZMV-00032q-Sy; Tue, 04 Mar 2025 15:59:36 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1tpZMT-0005Kx-3F; Tue, 04 Mar 2025 15:59:35 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 666CC4E6014;
 Tue, 04 Mar 2025 21:59:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 2vG4Ajb8QqhL; Tue,  4 Mar 2025 21:59:26 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 87E364E6010; Tue, 04 Mar 2025 21:59:26 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] docs/system/ppc/amigang.rst: Update for NVRAM emulation
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Message-Id: <20250304205926.87E364E6010@zero.eik.bme.hu>
Date: Tue, 04 Mar 2025 21:59:26 +0100 (CET)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, PP_MIME_FAKE_ASCII_TEXT=0.234,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add NVRAM and hint on how to make it persistent. Also update Linux
boot section which should now boot automatically with the new NVRAM
defaults so manual settings in menu may not be needed normally.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
Based-on: <cover.1740673173.git.balaton@eik.bme.hu>

 docs/system/ppc/amigang.rst | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/docs/system/ppc/amigang.rst b/docs/system/ppc/amigang.rst
index e2c9cb74b7..21bb14ed09 100644
--- a/docs/system/ppc/amigang.rst
+++ b/docs/system/ppc/amigang.rst
@@ -21,6 +21,7 @@ Emulated devices
  * VIA VT82C686B south bridge
  * PCI VGA compatible card (guests may need other card instead)
  * PS/2 keyboard and mouse
+ * 4 KiB NVRAM (use ``-drive if=mtd,format=raw,file=nvram.bin`` to keep contents persistent)
 
 Firmware
 --------
@@ -54,14 +55,14 @@ To boot the system run:
                     -cdrom "A1 Linux Net Installer.iso" \
                     -device ati-vga,model=rv100,romfile=VGABIOS-lgpl-latest.bin
 
-From the firmware menu that appears select ``Boot sequence`` →
-``Amiga Multiboot Options`` and set ``Boot device 1`` to
-``Onboard VIA IDE CDROM``. Then hit escape until the main screen appears again,
-hit escape once more and from the exit menu that appears select either
-``Save settings and exit`` or ``Use settings for this session only``. It may
-take a long time loading the kernel into memory but eventually it boots and the
-installer becomes visible. The ``ati-vga`` RV100 emulation is not
-complete yet so only frame buffer works, DRM and 3D is not available.
+If a firmware menu appears, select ``Boot sequence`` → ``Amiga Multiboot Options``
+and set ``Boot device 1`` to ``Onboard VIA IDE CDROM``. Then hit escape until
+the main screen appears again, hit escape once more and from the exit menu that
+appears select either ``Save settings and exit`` or ``Use settings for this
+session only``. It may take a long time loading the kernel into memory but
+eventually it boots and the installer becomes visible. The ``ati-vga`` RV100
+emulation is not complete yet so only frame buffer works, DRM and 3D is not
+available.
 
 Genesi/bPlan Pegasos II (``pegasos2``)
 ======================================
-- 
2.30.9


