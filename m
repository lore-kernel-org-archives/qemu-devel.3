Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA111C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ldq-0005U6-3u; Wed, 16 Sep 2026 05:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6ldk-0005C3-CJ; Wed, 16 Sep 2026 05:09:17 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6ldi-0007Rz-QK; Wed, 16 Sep 2026 05:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789549560; bh=pVexX22Gswp37I+jYIlwDUiiRIeswn+1lPMG9xjQgtY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gto0DBmPgTOzWpapF7VB/GBwT5/Co98W0Fw9CwhqCNA1A3RsyC663YOwvXZeMPvfs
 h8nsA082RMqfJo/zO4flgUDgO6f4kjXT6BIYasBTelZ85Qht2dyRVAzNJ1X6zur8ox
 nwtTjyxfkHgyu/JWTrVj1IqICVW8/tWR4x9drsJE9rfg/Kb/BJo/OcuglwyCZvxCju
 tcFZnx8yU5W/r/MSFFf4b6jaJ5PUbXtDxo7XIiDzqMay00f7moN8H6t+XzSiM4fe/E
 +LpfOikDAYI7Tb8LuuOKBQPj0mwTPsohR1zU3h/Bh4obam8VJ5Do/l1Sq5xtrZ3DC9
 oB78wwrhVNujQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F139C1D56D4;
 Wed, 16 Sep 2026 12:06:00 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9CF1F429E1E;
 Wed, 16 Sep 2026 12:06:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8515F5A797; Wed, 16 Sep 2026 12:06:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bin Meng <bin.meng@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.5 31/57] hw/sd: sdhci: Accept version 4 enable without
 UHS-I
Date: Wed, 16 Sep 2026 12:03:55 +0300
Message-ID: <20260916090516.677749-31-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
References: <qemu-stable-11.0.5-20260916120417@cover.tls.msk.ru>
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

From: Bin Meng <bin.meng@processmission.com>

Host Control 2 writes have been conditional on modeled UHS-I support
since commit 0034ebe6ee31. Host Version 4 Enable does not control UHS
signaling, so controllers without modeled UHS-I cannot enter version
4 mode.

Retain Host Version 4 Enable independently of UHS-I while continuing
to reject UHS-specific fields and keeping voltage changes UHS-gated.

Cc: qemu-stable@nongnu.org
Fixes: 0034ebe6ee31 ("sdhci: implement UHS-I voltage switch")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260723151853.2143177-9-bin.meng@processmission.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 10dddf15e294f01561bacd815c78f2da03c4f1a0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index e58a6103970..a612e5cbafb 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1345,11 +1345,24 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         }
         sdhci_update_irq(s);
         break;
-    case SDHC_ACMD12ERRSTS:
+    case SDHC_ACMD12ERRSTS: {
+        uint16_t hostctl2_mask = mask >> 16;
+        uint16_t hostctl2_value = value >> 16;
+
         MASKED_WRITE(s->acmd12errsts, mask, value & UINT16_MAX);
-        if (s->uhs_mode >= UHS_I) {
-            MASKED_WRITE(s->hostctl2, mask >> 16, value >> 16);
+        if (s->uhs_mode < UHS_I) {
+            /*
+             * VERSION4 is writable even without UHS-I. Preserve all other
+             * Host Control 2 bits when UHS-I is not supported.
+             */
+            uint16_t independent = R_SDHC_HOSTCTL2_VERSION4_MASK;
 
+            hostctl2_mask |= ~independent;
+            hostctl2_value &= independent;
+        }
+        MASKED_WRITE(s->hostctl2, hostctl2_mask, hostctl2_value);
+
+        if (s->uhs_mode >= UHS_I) {
             if (FIELD_EX32(s->hostctl2, SDHC_HOSTCTL2, V18_ENA)) {
                 sdbus_set_voltage(&s->sdbus, SD_VOLTAGE_1_8V);
             } else {
@@ -1357,6 +1370,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
             }
         }
         break;
+    }
 
     case SDHC_CAPAB:
     case SDHC_CAPAB + 4:
-- 
2.47.3


