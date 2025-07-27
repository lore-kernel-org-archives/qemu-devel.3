Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 014EDC87FCF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 22:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ug9iQ-0000F6-3M; Sun, 27 Jul 2025 18:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1ug9iL-0000D7-JC
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 18:19:29 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1ug9iJ-0001Ed-L6
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 18:19:29 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9FA3F13A986;
 Mon, 28 Jul 2025 01:19:16 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id DF5962511A9;
 Mon, 28 Jul 2025 01:19:22 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Hao Wu <wuhaotsh@google.com>, Havard Skinnemoen <hskinnemoen@google.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH for 10.1 2/2] roms/Makefile: build ast27x0_bootrom
Date: Mon, 28 Jul 2025 01:19:19 +0300
Message-ID: <607a943a587248fbe0ff0897de80aee98a093caa.1753654515.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <2a89ad4c8f5665d07952a4f1749caa6ec0cd3d9c.1753654515.git.mjt@tls.msk.ru>
References: <2a89ad4c8f5665d07952a4f1749caa6ec0cd3d9c.1753654515.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
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

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3052
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 roms/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/roms/Makefile b/roms/Makefile
index 6af68a922f..2691b935c4 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -68,6 +68,7 @@ default help:
 	@echo "  u-boot.sam460      -- update u-boot.sam460"
 	@echo "  npcm7xx_bootrom    -- update vbootrom for npcm7xx"
 	@echo "  npcm8xx_bootrom    -- update vbootrom for npcm8xx"
+	@echo "  ast27x0_bootrom    -- update vbootrom for ast27x0"
 	@echo "  efi                -- update UEFI (edk2) platform firmware"
 	@echo "  opensbi32-generic  -- update OpenSBI for 32-bit generic machine"
 	@echo "  opensbi64-generic  -- update OpenSBI for 64-bit generic machine"
@@ -200,6 +201,10 @@ npcm8xx_bootrom:
 	$(MAKE) -C vbootrom/npcm8xx CROSS_COMPILE=$(aarch64_cross_prefix)
 	cp vbootrom/npcm8xx/npcm8xx_bootrom.bin ../pc-bios/npcm8xx_bootrom.bin
 
+ast27x0_bootrom:
+	$(MAKE) -C vbootrom/ast27x0 CROSS_COMPILE=$(aarch64_cross_prefix) CC='$$(CROSS_COMPILE)gcc'
+	cp vbootrom/ast27x0/ast27x0_bootrom.bin ../pc-bios/ast27x0_bootrom.bin
+
 hppa-firmware:
 	$(MAKE) -C seabios-hppa parisc
 	cp seabios-hppa/out/hppa-firmware.img      ../pc-bios/
-- 
2.47.2


